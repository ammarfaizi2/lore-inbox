Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261773AbTCZQrZ>; Wed, 26 Mar 2003 11:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261776AbTCZQrZ>; Wed, 26 Mar 2003 11:47:25 -0500
Received: from ip68-13-105-80.om.om.cox.net ([68.13.105.80]:19584 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S261773AbTCZQrY>; Wed, 26 Mar 2003 11:47:24 -0500
Date: Wed, 26 Mar 2003 10:58:25 -0600 (CST)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@localhost.localdomain
To: Thomas Schlichter <schlicht@uni-mannheim.de>
cc: jsimmons@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: fbcon sleeping function call from illegal context
In-Reply-To: <200303261548.45370.schlicht@uni-mannheim.de>
Message-ID: <Pine.LNX.4.44.0303261049490.1347-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Mar 2003, Thomas Schlichter wrote:

Running with the patch as posted by Mr. Simmons I didn't get any further 
instances of the sleeping function call from illegal context messages I 
reported before, until screenblanking went into effect.  I then got the 
following:

Mar 26 10:45:03 dad kernel: Debug: sleeping function called from illegal 
context at mm/slab.c:1723
Mar 26 10:45:03 dad kernel: Call Trace:
Mar 26 10:45:03 dad kernel:  [<c011d7bf>] __might_sleep+0x4f/0x90
Mar 26 10:45:03 dad kernel:  [<c0149611>] kmalloc+0x1a1/0x1c0
Mar 26 10:45:03 dad kernel:  [<c0233b65>] accel_cursor+0xd5/0x320
Mar 26 10:45:03 dad kernel:  [<c0233edf>] fbcon_cursor+0x12f/0x160
Mar 26 10:45:03 dad kernel:  [<c011b74a>] __wake_up_common+0x3a/0x60
Mar 26 10:45:03 dad kernel:  [<c01ef99b>] clear_selection+0x1b/0x60
Mar 26 10:45:03 dad kernel:  [<c01f2623>] hide_cursor+0x63/0xa0
Mar 26 10:45:03 dad kernel:  [<c01f65df>] timer_do_blank_screen+0x4f/0x1b0
Mar 26 10:45:03 dad kernel:  [<c01f6870>] blank_screen+0x0/0x20
Mar 26 10:45:03 dad kernel:  [<c01f688a>] blank_screen+0x1a/0x20
Mar 26 10:45:03 dad kernel:  [<c012ab32>] run_timer_softirq+0x132/0x3c0
Mar 26 10:45:03 dad kernel:  [<c0125de1>] do_softirq+0xa1/0xb0
Mar 26 10:45:03 dad kernel:  [<c010bdec>] do_IRQ+0x1fc/0x320
Mar 26 10:45:03 dad kernel:  [<c0109fdc>] common_interrupt+0x18/0x20
Mar 26 10:45:03 dad kernel:  [<c0116c1b>] apm_bios_call_simple+0x7b/0xa0
Mar 26 10:45:03 dad kernel:  [<c0116d99>] apm_do_idle+0x29/0x80
Mar 26 10:45:03 dad kernel:  [<c0116ead>] apm_cpu_idle+0x7d/0x150
Mar 26 10:45:03 dad kernel:  [<c0116e30>] apm_cpu_idle+0x0/0x150
Mar 26 10:45:03 dad kernel:  [<c0106fc0>] default_idle+0x0/0x30
Mar 26 10:45:03 dad kernel:  [<c0107061>] cpu_idle+0x31/0x40
Mar 26 10:45:03 dad kernel:  [<c0105000>] rest_init+0x0/0x30


