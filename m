Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264473AbUATCMC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 21:12:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264394AbUATCIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 21:08:52 -0500
Received: from dp.samba.org ([66.70.73.150]:20646 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265233AbUATCHP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 21:07:15 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] fix/improve modular IDE (Re: [PATCH] modular IDE for 2.6.1 ugly but working fix) 
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-reply-to: Your message of "Sat, 17 Jan 2004 14:22:06 BST."
             <200401171422.06211.bzolnier@elka.pw.edu.pl> 
Date: Tue, 20 Jan 2004 13:01:02 +1100
Message-Id: <20040120020710.837CE2C226@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200401171422.06211.bzolnier@elka.pw.edu.pl> you write:
> +static int __init ide_generic_init(void)
> +{
> +	MOD_INC_USE_COUNT;
> +	if (ide_hwifs[0].io_ports[IDE_DATA_OFFSET])
> +		ide_get_lock(NULL, NULL); /* for atari only */
> +
> +	(void)ideprobe_init();
> +
> +	if (ide_hwifs[0].io_ports[IDE_DATA_OFFSET])
> +		ide_release_lock();	/* for atari only */
> +
> +#ifdef CONFIG_PROC_FS
> +	create_proc_ide_interfaces();
> +#endif
> +	return 0;
> +}
> +
> +static void __exit ide_generic_exit(void)
> +{
> +}

If you don't want to be unloadable, just don't have a module_exit() at
all.

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
