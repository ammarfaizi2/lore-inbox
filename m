Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267235AbTBLP2a>; Wed, 12 Feb 2003 10:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267241AbTBLP2a>; Wed, 12 Feb 2003 10:28:30 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:22799 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267235AbTBLP23>; Wed, 12 Feb 2003 10:28:29 -0500
Date: Wed, 12 Feb 2003 15:38:18 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Osamu Tomita <tomita@cinet.co.jp>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCHSET] PC-9800 subarch. support for 2.5.60 (13/34) NIC
Message-ID: <20030212153818.B10171@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Osamu Tomita <tomita@cinet.co.jp>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Jeff Garzik <jgarzik@pobox.com>
References: <20030212131737.GA1551@yuzuki.cinet.co.jp> <20030212134520.GN1551@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030212134520.GN1551@yuzuki.cinet.co.jp>; from tomita@cinet.co.jp on Wed, Feb 12, 2003 at 10:45:20PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#ifdef CONFIG_X86_PC9800
> +#undef __ISAPNP__
> +#endif

Don't do s.th. like that!

> +#ifndef CONFIG_X86_PC9800
>  	/* Select an open I/O location at 0x1*0 to do contention select. */
>  	for ( ; id_port < 0x200; id_port += 0x10) {
>  		if (check_region(id_port, 1))
> @@ -438,6 +447,9 @@
>  		printk(" WARNING: No I/O port available for 3c509 activation.\n");
>  		return -ENODEV;
>  	}
> +#else
> +	id_port = 0x71d0;
> +#endif

use ifdef, not ifndef here

>  	/* Next check for all ISA bus boards by sending the ID sequence to the
