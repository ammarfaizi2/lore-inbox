Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261685AbRESIGE>; Sat, 19 May 2001 04:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261687AbRESIFz>; Sat, 19 May 2001 04:05:55 -0400
Received: from www.wen-online.de ([212.223.88.39]:26120 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S261685AbRESIFm>;
	Sat, 19 May 2001 04:05:42 -0400
Date: Sat, 19 May 2001 10:05:29 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Peter Zaitsev <pz@spylog.ru>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.4 folks
In-Reply-To: <24243045671.20010519105201@spylog.ru>
Message-ID: <Pine.LNX.4.33.0105190922100.668-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 19 May 2001, Peter Zaitsev wrote:

> Hello linux-kernel,
>
>   I've trying to move some of my servers to 2.4.4 kernel from 2.2.x.
>   Everything goes fine, notable perfomance increase occures, but the
>   problem is I'm really often touch the following problem:

<allocation failures snipped>

> The problem is the systems this happens on are not short of memory.
> Here is the free output for the system I had this happened this
> morning:

free doesn't show any info about allocator state at allocation failure
time.  If you were to modify mm/page_alloc.c:__alloc_pages() to do a
show_mem() along with the printk, you'd likely see that you're close
to being completely oom at that moment.

> Does anyone has any ideas about this problem ?

Posting /proc/slabinfo content might give the vm wizards an idea where
your memory is sitting.

If you see any indications of a sustained leak, I can provide you with
a 2.4.4 ikd patch (toolkit.. contains a memory leak detector) to try on
a non-mission-critical box.  It's large, 731003 uncompressed.

	-Mike

