Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318301AbSG3Oeq>; Tue, 30 Jul 2002 10:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318304AbSG3Oeq>; Tue, 30 Jul 2002 10:34:46 -0400
Received: from jalon.able.es ([212.97.163.2]:53926 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S318301AbSG3Oep>;
	Tue, 30 Jul 2002 10:34:45 -0400
Date: Tue, 30 Jul 2002 16:36:57 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19rc3aa4
Message-ID: <20020730143657.GA2224@junk.cps.unizar.es>
References: <20020730060218.GB1181@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20020730060218.GB1181@dualathlon.random>; from andrea@suse.de on mar, jul 30, 2002 at 08:02:18 +0200
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20020730 Andrea Arcangeli wrote:
> 
> Only in 2.4.19rc3aa3: 10_sched-o1-hyperthreading-1
> Only in 2.4.19rc3aa4: 10_sched-o1-hyperthreading-2
> 

It works fine this time....

BTW, are you aware of this in -aa ? I need this patch:

--- linux/include/asm-i386/processor.h   Fri Jul 19 00:37:45 2002
+++ linux/include/asm-i386/processor.h~  Fri Jul 19 00:38:48 2002
@@ -401,7 +401,7 @@
 	{ [0 ... 7] = 0 },	/* debugging registers */	\
 	0, 0, 0,						\
 	{ { 0, }, },		/* 387 state */			\
-	0,0,0,0,0,0,						\
+	0,0,0,0,0,						\
 	0,{~0,}			/* io permissions */		\
 }
 
to shut up gcc and match the struct definition:

/* floating point info */
    union i387_union    i387;
/* virtual 86 mode info */
    struct vm86_struct  * vm86_info;
    unsigned long       screen_bitmap;
    unsigned long       v86flags, v86mask, saved_esp0;
/* IO permissions */
    int     ioperm;
    unsigned long   io_bitmap[IO_BITMAP_SIZE+1];

Coud be serious to have io_bitmap == 0 instead of == ~0 ??

-- 
J.A. Magallon                           \                 Software is like sex:
junk.able.es                             \           It's better when it's free
Mandrake Linux release 9.0 (Cooker) for i586
Linux 2.4.19-rc3-jam4 (gcc 3.2 (Mandrake Linux 9.0 3.2-0.2mdk))
