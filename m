Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030300AbWALLwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030300AbWALLwX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 06:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030302AbWALLwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 06:52:23 -0500
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:33140 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1030300AbWALLwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 06:52:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=yIX8ySwFzfOCX8L6TF7WbTtxplXvJ/oDgLnL1AhPuJaxDOgZZOoNRWFrBGwuDTu3ZulwY4YGuFqvxozCHB6mYbn1A3V+JUkT7ioiFyp0m3JM4C4mWQBXJkYnLUK6rkdAzZ9DIWC9J9TBEV5jobHYAaOvsARDuwdjie18qHxDLp4=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Jeff Dike <jdike@addtoit.com>
Subject: Re: + uml-sigwinch-handling-cleanup.patch added to -mm tree
Date: Thu, 12 Jan 2006 12:52:15 +0100
User-Agent: KMail/1.8.3
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <200601042323.k04NNti4021942@shell0.pdx.osdl.net> <200601052054.37512.blaisorblade@yahoo.it> <20060105222737.GA10369@ccure.user-mode-linux.org>
In-Reply-To: <20060105222737.GA10369@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601121252.16043.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 January 2006 23:27, Jeff Dike wrote:
> On Thu, Jan 05, 2006 at 08:54:37PM +0100, Blaisorblade wrote:
> > Meanwhile, the whole content of the new free_winch(), including some
> > syscalls on the host, and various other stuff, is brought back under the
> > winch_handler_lock.
>
> And?  There's no particular problem with host system calls being under
> a lock.  And the various other stuff is a kfree and a free_irq, which
> I don't think have a problem being called under a spinlock.

Indeed, right. Ok, no real objections on the patch.

> > I had carefully brought that stuff out keeping only the list access under
> > the lock, probably while fixing some "scheduling while atomic" warnings -
> > once the element is out of the list it's unreachable thus (IMHO) safely
> > accessible.
>
> Probably?  What in there is sensitive to being called under a lock?

Ok, sorry,  wrong here. I remembered doing the thing but it was for other 
reasons - reducing spinlock hold times. Doing syscalls under spinlocks is 
just (possibly) slow, not wrong. But ok, the commendment was "thou shalt not 
optimize".

> > So, list_del should be brought out from free_winch, which would then
> > become callable without the spinlock held.

> That would increase the amount of code, with no gain that I can see.
> The list_del would be duplicated, and the loop in winch_cleanup would
> have to drop and reacquire the lock around each call to free_winch.

I thought mainly to unregister_winch(); the lock in winch_cleanup() has been 
added now, I didn't see it.

> 				Jeff

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
