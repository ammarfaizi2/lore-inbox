Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751443AbWD1UTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbWD1UTl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 16:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbWD1UTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 16:19:41 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:36749 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751443AbWD1UTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 16:19:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=O4NQ8YeMOSJjwCCl4Tq19ON3oTiQ/Lsdm58ev22qDE7PzLOZ9ziAZSHcoIlamPsuoBpWue/UpdsyDkLrYVAmF9RjOtW85dBJVIfS0wSBXIANt3ljGXPuqsaxsF1oUN50Szit0KqAP/tYeBAyaTfMREcEWh4UoXMlOh6+OKM+BS4=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: [RFC] PATCH 0/4 - Time virtualization
Date: Fri, 28 Apr 2006 22:10:17 +0200
User-Agent: KMail/1.8.3
Cc: user-mode-linux-devel@lists.sourceforge.net,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org, JANAK DESAI <janak@us.ibm.com>
References: <200604131719.k3DHJcZG004674@ccure.user-mode-linux.org> <200604281554.32665.blaisorblade@yahoo.it> <20060428151543.GA7397@ccure.user-mode-linux.org>
In-Reply-To: <20060428151543.GA7397@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604282210.17956.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 April 2006 17:15, Jeff Dike wrote:
> On Fri, Apr 28, 2006 at 03:54:31PM +0200, Blaisorblade wrote:
> > Additionally, if this flag ever goes into clone, it mustn't be named
> > CLONE_TIME, but CLONE_NEWTIME (or CLONE_NEWUTS). And given CLONE_NEWNS,
> > it's IMHO ok to have unshare(CLONE_NEWTIME) to mean "unshare time
> > namespace", even if it's incoherent with unshare(CLONE_FS) - the
> > incoherency already exists with CLONE_NEWNS.

> I wonder if they should be CLONE_* at all.

I've wondered about this too. It makes some sense to renforce the relationship 
with clone, but when you read the call to unshare you must do you get 
nonsense. Like the above incoherence.

> Given that we are likely 
> to run out of free CLONE_* bits, unshare will have to reuse bits that
> don't have anything to do with sharing resources (CSIGNAL,
> CLONE_VFORK, etc), and it doesn't seem that nice to have two different
> CLONE_* flags with the same value, different meaning, only one of
> which can actually be used in clone.

> It seems better to use UNSHARE_*, with the current bits that are
> common to unshare and clone being defined the same, i.e.
> 	#define UNSHARE_VM CLONE_VM
I indeed agree with this. With 

cg log -r v2.6.16-rc1:v2.6.16 kernel/fork.c

We can see the people involved in commits for sys_unshare (there's little 
other work in there).
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
