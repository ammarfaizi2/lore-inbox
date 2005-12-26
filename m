Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbVLZSRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbVLZSRF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 13:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbVLZSRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 13:17:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:36748 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932081AbVLZSRE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 13:17:04 -0500
Date: Mon, 26 Dec 2005 10:15:51 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       zippel@linux-m68k.org, hch@infradead.org, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, arjanv@infradead.org, nico@cam.org,
       jes@trained-monkey.org, zwane@arm.linux.org.uk, oleg@tv-sign.ru,
       dhowells@redhat.com, bcrl@kvack.org, rostedt@goodmis.org, ak@suse.de,
       rmk+lkml@arm.linux.org.uk
Subject: Re: [patch 0/9] mutex subsystem, -V4
In-Reply-To: <1135593776.2935.5.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0512261015350.14098@g5.osdl.org>
References: <20051222114147.GA18878@elte.hu>  <20051222153014.22f07e60.akpm@osdl.org>
  <20051222233416.GA14182@infradead.org>  <200512251708.16483.zippel@linux-m68k.org>
  <20051225150445.0eae9dd7.akpm@osdl.org> <20051225232222.GA11828@elte.hu> 
 <20051226023549.f46add77.akpm@osdl.org> <1135593776.2935.5.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 26 Dec 2005, Arjan van de Ven wrote:
> 
> > hm.  16 CPUs hitting the same semaphore at great arrival rates.  The cost
> > of a short spin is much less than the cost of a sleep/wakeup.  The machine
> > was doing 100,000 - 200,000 context switches per second.
> 
> interesting.. this might be a good indication that a "spin a bit first"
> mutex slowpath for some locks might be worth implementing...

No, please don't. 

Almost always it's a huge sign that the locking is totally broken.

And yes, the fix was to _fix_ the ext3 locking. Not to make semaphores 
spin. The ext3 locking was using a semaphore for totally the wrong 
reasons, it made zero sense at all.

I think it's fixed now.

		Linus
