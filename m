Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbUJYTod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbUJYTod (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 15:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbUJYTo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 15:44:29 -0400
Received: from web12204.mail.yahoo.com ([216.136.173.88]:29803 "HELO
	web12204.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261219AbUJYTna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 15:43:30 -0400
Message-ID: <20041025194327.88284.qmail@web12204.mail.yahoo.com>
Date: Mon, 25 Oct 2004 21:43:27 +0200 (CEST)
From: karsten wiese <annabellesgarden@yahoo.de>
Subject: Re: [PATCH]Uncompressing Linux... Out of memory: fixed by increased HEAP_SIZE
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041025143014.GA14992@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Ingo Molnar <mingo@elte.hu> schrieb: 
> 
> > booting newest 2.6.9 experimental kernels, I frequently
> encountered 
> > "Uncompressing Linux... Out of memory --System halted"
> > In some mail archive I found the (obvious ;-) solution:
> Increase HEAP_SIZE.
> > 
> > Here in line 122 of arch/i386/boot/compressed/misc.c
> this
> > 	#define HEAP_SIZE             0x4000
> > instead of 
> > 	#define HEAP_SIZE             0x3000
> > made 2.6.9-mm1-RT-U10.3 boot again.
> 
> ah! Makes sense. Did you have LATENCY_TRACE enabled? That
> compiles the
> kernel with -pg which creates a fatter stackframe.
> 
Only the malloc() called by gunzip() called by
decompress_kernel() is influenced by this HEAP_SIZE.
gunzip()'s internal work data is stored in that heap.
This only is in effect before the kernel "really" boots,
no?
LATENCY_TRACE is indeed off, ...but can gunzip()'s heap
needs be easier answered by a fatter stackframe (at
decompression time!)?

Thanks,
Karsten


	

	
		
___________________________________________________________
Gesendet von Yahoo! Mail - Jetzt mit 100MB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
