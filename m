Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262130AbSJNSPc>; Mon, 14 Oct 2002 14:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262131AbSJNSPc>; Mon, 14 Oct 2002 14:15:32 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:36480 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S262130AbSJNSPa>;
	Mon, 14 Oct 2002 14:15:30 -0400
Date: Mon, 14 Oct 2002 20:21:17 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Anton Altaparmakov <aia21@cantab.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, acme@conectiva.com.br
Subject: Re: [PATCH-2.5] Compile fix for net/llc
Message-ID: <20021014182117.GA16629@vana.vc.cvut.cz>
References: <E181972-00029d-00@storm.christs.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E181972-00029d-00@storm.christs.cam.ac.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 06:34:40PM +0100, Anton Altaparmakov wrote:
> Linus,
> 
> I needed the below patchlet to complete compilation of net/llc in your
> current bk tree.

What about adding #include <linux/init.h> ? bttv-driver.c has same problem:

diff -urdN linux/drivers/media/video/bttv-driver.c linux/drivers/media/video/bttv-driver.c
--- linux/drivers/media/video/bttv-driver.c	2002-10-14 13:51:01.000000000 +0000
+++ linux/drivers/media/video/bttv-driver.c	2002-10-14 14:08:55.000000000 +0000
@@ -32,6 +32,7 @@
 #include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/kdev_t.h>
+#include <linux/init.h>
 
 #include <asm/io.h>
 

... and while I'm talking about bttv:

Change this debug printk() priority from default to debug. It should not be printed
by default on system console.

diff -urdN linux/drivers/media/video/bttv-driver.c linux/drivers/media/video/bttv-driver.c
--- linux/drivers/media/video/bttv-driver.c	2002-10-14 13:51:01.000000000 +0000
+++ linux/drivers/media/video/bttv-driver.c	2002-10-14 14:08:55.000000000 +0000
@@ -812,7 +813,7 @@
 	i2c_mux = mux = (btv->audio & AUDIO_MUTE) ? AUDIO_OFF : btv->audio;
 	if (btv->opt_automute && !signal && !btv->radio_user)
 		mux = AUDIO_OFF;
-	printk("bttv%d: amux: mode=%d audio=%d signal=%s mux=%d/%d irq=%s\n",
+	printk(KERN_DEBUG "bttv%d: amux: mode=%d audio=%d signal=%s mux=%d/%d irq=%s\n",
 	       btv->nr, mode, btv->audio, signal ? "yes" : "no",
 	       mux, i2c_mux, in_interrupt() ? "yes" : "no");
 
 
> Best regards,
> 
> 	Anton
> -- 
> Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
> Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
> WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/
> 
> --- tng/net/llc/llc_proc.c.old	2002-10-14 18:29:25.000000000 +0100
> +++ tng/net/llc/llc_proc.c	2002-10-14 18:29:15.000000000 +0100
> @@ -258,7 +258,7 @@ out_socket:
>  	goto out;
>  }
>  
> -void __exit llc_proc_exit(void)
> +void llc_proc_exit(void)
>  {
>  	remove_proc_entry("socket", llc_proc_dir);
>  	remove_proc_entry("core", llc_proc_dir);
> @@ -270,7 +270,7 @@ int __init llc_proc_init(void)
>  	return 0;
>  }
>  
> -void __exit llc_proc_exit(void)
> +void llc_proc_exit(void)
>  {
>  }
>  #endif /* CONFIG_PROC_FS */
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
