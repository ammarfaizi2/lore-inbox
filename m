Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276032AbRJBROn>; Tue, 2 Oct 2001 13:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276030AbRJBROd>; Tue, 2 Oct 2001 13:14:33 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:48401 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S276000AbRJBROZ>; Tue, 2 Oct 2001 13:14:25 -0400
Message-ID: <3BB9F4DC.423EC6B7@zip.com.au>
Date: Tue, 02 Oct 2001 10:09:48 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Crutcher Dunnavant <crutcher@datastacks.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: printk while interrupts are disabled
In-Reply-To: <3BB9A6F4.6BDDAA81@berlin.de>,
		<3BB9A6F4.6BDDAA81@berlin.de>; from n.roos@berlin.de on Tue, Oct 02, 2001 at 01:37:24PM +0200 <20011002102210.B1630@mueller.datastacks.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Crutcher Dunnavant wrote:
> 
> ++ 02/10/01 13:37 +0200 - Norbert Roos:
> > Hello!
> >
> > Simple question: Do printk()s get printed while interrupts are disabled
> > (after cli)?
> 
> They get stuffed into a buffer to be printed later. It is possible to
> overflow that buffer, and lose some of your printk messages.

Not quite - a printk from cli() or hardirq context will normally
come out immediately.  The only time the deferred buffering
thing happens is if the console semaphore is found to be already held on
entry to printk().  ie: there is already a printk in progress on another CPU
or on this CPU in non-interrupt context.

The buffered printk output will be printed by the current console-sem
owner before it releases the semaphore.
