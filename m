Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030405AbWD1Nyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030405AbWD1Nyj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 09:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030406AbWD1Nyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 09:54:39 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:63659 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1030405AbWD1Nyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 09:54:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=Rnf/9Edqd1hQI2rgF9UcaiKXhUpcGUyr5cefYqn61INzXyyi/I+NFTz2/naAgn7T3pr1SMm5f37w7yija2hsUMft8xOUfUvtLO+hUForenqDILHLARgwXAPo/tWoXPn33rdcqdyi9ST1ps9shVfGNLwTm/DnJy1VeXpsbAOkAHI=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: [RFC] PATCH 0/4 - Time virtualization
Date: Fri, 28 Apr 2006 15:54:31 +0200
User-Agent: KMail/1.8.3
Cc: user-mode-linux-devel@lists.sourceforge.net,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org
References: <200604131719.k3DHJcZG004674@ccure.user-mode-linux.org> <200604281333.41358.blaisorblade@yahoo.it> <20060428114823.GA3641@ccure.user-mode-linux.org>
In-Reply-To: <20060428114823.GA3641@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604281554.32665.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 April 2006 13:48, Jeff Dike wrote:
> On Fri, Apr 28, 2006 at 01:33:40PM +0200, Blaisorblade wrote:
> > > So, maybe it belongs in clone as a "backwards" flag similar to
> > > CLONE_NEWNS.

> > I must note that currently every (?) flag allowed for unshare is also
> > allowed for clone, so you need to do that anyway.

> Currently.  We are running out of CLONE_ bits - in mainline, there are
> three left, and two of them are likely to be used by CLONE_TIME and
> CLONE_UTSNAME (or whatever that turns out to be called).

> And why should there be any overlap between clone flags and unshare
> flags?  Isn't
> 	clone(CLONE_TIME);
> the same as
> 	clone();
> 	unshare(CLONE_TIME);
> ?

Now that unshare() exists, you're right, the current situation is just due to 
unshare() being an afterthought; the second form (clone() + unshare()) is 
actually more similar to the classical fork() API conceptually (i.e. you 
don't need a call with thousands of parameters to create a process, you can 
specify everything later).

So we get back to Eric's objection (which I haven't understood but that's my 
problem).

Additionally, if this flag ever goes into clone, it mustn't be named 
CLONE_TIME, but CLONE_NEWTIME (or CLONE_NEWUTS). And given CLONE_NEWNS, it's 
IMHO ok to have unshare(CLONE_NEWTIME) to mean "unshare time namespace", even 
if it's incoherent with unshare(CLONE_FS) - the incoherency already exists 
with CLONE_NEWNS.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
