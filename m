Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbUCLGmG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 01:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261993AbUCLGmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 01:42:06 -0500
Received: from smtprelay02.ispgateway.de ([62.67.200.157]:46009 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S262008AbUCLGl4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 01:41:56 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] per-backing dev unplugging #2
Date: Fri, 12 Mar 2004 07:41:16 +0100
User-Agent: KMail/1.6
Cc: Jens Axboe <axboe@suse.de>
References: <20040311083619.GH6955@suse.de>
In-Reply-To: <20040311083619.GH6955@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200403120741.18455.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Jens,

On Thursday 11 March 2004 09:36, Jens Axboe wrote:
> diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.4-mm1/kernel/power/pmdisk.c linux-2.6.4-mm1/kernel/power/pmdisk.c
> --- /opt/kernel/linux-2.6.4-mm1/kernel/power/pmdisk.c	2004-03-11 03:55:28.000000000 +0100
> +++ linux-2.6.4-mm1/kernel/power/pmdisk.c	2004-03-11 09:07:12.000000000 +0100
> @@ -859,7 +859,6 @@
>  
>  static void wait_io(void)
>  {
> -	blk_run_queues();
>  	while(atomic_read(&io_done))
>  		io_schedule();
>  }
> @@ -895,6 +894,7 @@
>  		goto Done;
>  	}
>  
> +	rw |= BIO_RW_SYNC;
>  	if (rw == WRITE)
>  		bio_set_pages_dirty(bio);
>  	start_io();

These last 3 lines look bogus. The condition will never trigger. 
Maybe you meant to move the assignment either down or change bio->bi_rw
instead of rw.

Regards

Ingo Oeser

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAUVuMU56oYWuOrkARAlxlAJ0Su6cddbBEu6j4lg9s880ZGI7YhQCgiXYU
zxumQHLdGy/UcBIbx56IG1k=
=vbeO
-----END PGP SIGNATURE-----
