Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131976AbRDWVEW>; Mon, 23 Apr 2001 17:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131979AbRDWVEM>; Mon, 23 Apr 2001 17:04:12 -0400
Received: from bzq-128-3.bezeqint.net ([212.179.127.3]:23050 "HELO arava.co.il")
	by vger.kernel.org with SMTP id <S131976AbRDWVEC>;
	Mon, 23 Apr 2001 17:04:02 -0400
Date: Tue, 24 Apr 2001 00:03:26 +0300 (IDT)
From: Matan Ziv-Av <matan@svgalib.org>
Reply-To: Matan Ziv-Av <matan@svgalib.org>
To: David Woodhouse <dwmw2@infradead.org>
cc: Russell King <rmk@arm.linux.org.uk>, mythos <papadako@csd.uoc.gr>,
        linux-kernel@vger.kernel.org
Subject: Re: Can't compile 2.4.3 with agcc 
In-Reply-To: <24644.988041173@redhat.com>
Message-ID: <Pine.LNX.4.21_heb2.09.0104232359390.2200-100000@matan.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 23 Apr 2001, David Woodhouse wrote:

> --- include/asm/bugs.h	2001/01/18 13:56:53	1.2.2.16
> +++ include/asm/bugs.h	2001/04/23 15:45:28
> @@ -80,8 +80,10 @@
>  	 * Verify that the FXSAVE/FXRSTOR data will be 16-byte aligned.
>  	 */
>  	if (offsetof(struct task_struct, thread.i387.fxsave) & 15) {
> -		extern void __buggy_fxsr_alignment(void);
> -		__buggy_fxsr_alignment();
> +		printk(KERN_EMERG "ERROR: FXSAVE data are not 16-byte aligned in task_struct.\n");
> +		printk(KERN_EMERG "This is usually caused by a buggy compiler (perhaps pgcc?)\n");
> +		printk(KERN_EMERG "Cannot continue.\n");
> +		for (;;) ;

This is known at compile time, right?
Would it not be better to replace the printk with #error ? Why do I need
to boot the bad kernel to find out that it does not work, when it is
known when compiling? 



-- 
Matan Ziv-Av.                         matan@svgalib.org


