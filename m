Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030325AbVIVU4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030325AbVIVU4T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 16:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030261AbVIVU4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 16:56:18 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:7017 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1030325AbVIVU4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 16:56:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=MRmPMSwIfOfdy5NTHU5eYGZvT2DLdezABDL9WZwGHOZKMONmU6cGafbXS3/aQSmdGYUJbhwZofLu63jdcei58bQ0XSmm8TjQ8aBJ18ZPOxFNHjUnH1E719FE2796rtRqNiHINm3FwJ5azIbA0U2zARY3arNQQgOv/kono7UECr4=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] [PATCH 06/10] uml: run mconsole "sysrq" in process context
Date: Thu, 22 Sep 2005 22:48:21 +0200
User-Agent: KMail/1.8.2
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <200509211923.21861.blaisorblade@yahoo.it> <200509222120.20922.blaisorblade@yahoo.it> <20050922203743.GA11648@ccure.user-mode-linux.org>
In-Reply-To: <20050922203743.GA11648@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509222248.21339.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 September 2005 22:37, Jeff Dike wrote:
> On Thu, Sep 22, 2005 at 09:20:20PM +0200, Blaisorblade wrote:
> > sysrq t is broken (and stays),

> There's a fix on the way for that.
Already found? Nice.
> This has nothing to do with interrupt 
> context anyway.

> > but additionally there are some warnings from
> > some commands (enable sleep inside spinlock checking and spinlock
> > debugging), which go to the down_read inside handle_page_fault IIRC. So
> > try to run in process context.

> Which ones?  They should be fixed.
Ok, will drop this patch and retry again to look at the messages.
> It is fairly fundamental to sysrq that it work from interrupt context.  You
> may be diagnosing a system which can't context switch any more.

Ok, I felt a bit uncertain about this, but didn't realize this very problem.

> This patch should be dropped, and the real problems fixed.
Ok, that's nice for me. I'll look into this. Possibly, the

if (in_atomic()) don't take semaphore in handle_page_fault was the right fix 
for this. I'll have a look soon.
> 				Jeff

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com
