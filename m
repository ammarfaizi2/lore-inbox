Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262331AbVAUK00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbVAUK00 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 05:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262333AbVAUKXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 05:23:42 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:7952 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262321AbVAUKIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 05:08:53 -0500
Date: Fri, 21 Jan 2005 11:08:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
Cc: kernel-janitors <kernel-janitors@lists.osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] generic_serial.h: kill incorrect gs_debug reference
Message-ID: <20050121100852.GF3209@stusta.de>
References: <20050120220402.GB22673@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120220402.GB22673@ens-lyon.fr>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 11:04:03PM +0100, Benoit Boissinot wrote:

> Hi,
> 
> the following patch (against latest -mm), correct compilation errors with
> gcc-4.0 (snapshot 20050116).
> 
> please correct me if i did something wrong, this is my first patch
> with the linux kernel.
> 
> Benoit
> 
> diff -Naurp --exclude=ctags linux-clean/drivers/char/generic_serial.c linux-2.6-mm-test/drivers/char/generic_serial.c
> --- linux-clean/drivers/char/generic_serial.c	2005-01-20 22:12:57.000000000 +0100
> +++ linux-2.6-mm-test/drivers/char/generic_serial.c	2005-01-20 21:27:11.000000000 +0100
> @@ -36,7 +36,7 @@
>  static char *                  tmp_buf; 
>  static DECLARE_MUTEX(tmp_buf_sem);
>  
> -static int gs_debug;
> +int gs_debug;
>...

This part seems to be wrong.

Correct patch below.


<--  snip  -->


generic_serial.h contained an incorrect extern reference to the static 
variable gs_debug (Benoit Boissinot reported that gcc 4.0 rejects this).


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc1-mm2-full/include/linux/generic_serial.h.old	2005-01-20 23:26:07.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/include/linux/generic_serial.h	2005-01-20 23:26:20.000000000 +0100
@@ -93,6 +93,4 @@
 int  gs_getserial(struct gs_port *port, struct serial_struct __user *sp);
 void gs_got_break(struct gs_port *port);
 
-extern int gs_debug;
-
 #endif

