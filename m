Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbUCRFM2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 00:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbUCRFM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 00:12:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:60363 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262389AbUCRFMZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 00:12:25 -0500
Date: Wed, 17 Mar 2004 21:12:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Marinos J. Yannikos" <mjy@geizhals.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PREEMPT and server workloads
Message-Id: <20040317211227.6f32f307.akpm@osdl.org>
In-Reply-To: <40591EC1.1060204@geizhals.at>
References: <40591EC1.1060204@geizhals.at>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Marinos J. Yannikos" <mjy@geizhals.at> wrote:
>
> we upgraded a few production boxes from 2.4.x to 2.6.4 recently and the 
> default .config setting was CONFIG_PREEMPT=y. To get straight to the 
> point: according to our measurements, this results in severe performance 
> degradation with our typical and some artificial workload. By "severe" I 
> mean this:

You're the first to report this.  On a little 256MB P4-HT box here, running
2.6.5-rc1:

preempt:

	make -j3 vmlinux  272.49s user 16.32s system 196% cpu 2:26.77 total

non-preempt:

	make -j3 vmlinux  271.64s user 15.65s system 195% cpu 2:27.25 total

> If not, shouldn't there be a big warning sticker somewhere that says 
> "DON'T EVEN THINK ABOUT KEEPING THIS DEFAULT SETTING UNLESS ALL YOU WANT 
> TO DO IS LISTEN TO MP3 AUDIO WHILE USING XFREE86!"?

Dude, chill ;) Something seems to be pretty busted there.  Is the machine
swapping at all?  Under any sort of memory stress?  How does it compare
with 2.4 running the same workloads?

Suggest you run some simple IO benchmarks (straight dd, hdparm -t,
bonnie++, tiobench, etc) and compute-intensive tasks, etc.  Try to narrow
down exactly what part of the kernel's operation is being impacted.  Is it
context switches, I/O rates, disk fragmentation, etc, etc.  

If you can distill to regression down to the most simple test then we can
identify its cause more easily.

