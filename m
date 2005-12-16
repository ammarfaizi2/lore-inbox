Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbVLPNr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbVLPNr6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 08:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbVLPNr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 08:47:58 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:17128 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932258AbVLPNr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 08:47:58 -0500
Date: Fri, 16 Dec 2005 13:47:54 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: akpm@osdl.org, wein@de.ibm.com, Horst.Hummel@de.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 3/3] s390: dasd extended error reporting module.
Message-ID: <20051216134754.GA23964@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, akpm@osdl.org,
	wein@de.ibm.com, Horst.Hummel@de.ibm.com,
	linux-kernel@vger.kernel.org
References: <20051216132953.GD8877@skybase.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051216132953.GD8877@skybase.boeblingen.de.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2005 at 02:29:53PM +0100, Martin Schwidefsky wrote:
> From: Stefan Weinhuber <wein@de.ibm.com>
> 
> [patch 3/3] s390: dasd extended error reporting module.
> 
> The DASD extended error reporting is a facility that allows to
> get detailed information about certain problems in the DASD I/O.
> This information can be used to implement fail-over applications
> that can recover these problems.
> 
> Signed-off-by: Stefan Weinhuber <wein@de.ibm.com>
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> ---
> 
>  arch/s390/kernel/compat_ioctl.c    |    2 
>  drivers/s390/block/Kconfig         |   14 
>  drivers/s390/block/Makefile        |    2 
>  drivers/s390/block/dasd.c          |   76 ++
>  drivers/s390/block/dasd_3990_erp.c |    5 
>  drivers/s390/block/dasd_eckd.h     |    3 
>  drivers/s390/block/dasd_eer.c      | 1091 +++++++++++++++++++++++++++++++++++++
>  drivers/s390/block/dasd_int.h      |   37 +
>  include/asm-s390/dasd.h            |   15 
>  9 files changed, 1237 insertions(+), 8 deletions(-)
> 
> diff -urpN linux-2.6/arch/s390/kernel/compat_ioctl.c linux-2.6-patched/arch/s390/kernel/compat_ioctl.c
> --- linux-2.6/arch/s390/kernel/compat_ioctl.c	2005-12-16 10:56:42.000000000 +0100
> +++ linux-2.6-patched/arch/s390/kernel/compat_ioctl.c	2005-12-16 10:57:24.000000000 +0100
> @@ -63,6 +63,8 @@ COMPATIBLE_IOCTL(BIODASDSATTR)
>  COMPATIBLE_IOCTL(BIODASDCMFENABLE)
>  COMPATIBLE_IOCTL(BIODASDCMFDISABLE)
>  COMPATIBLE_IOCTL(BIODASDREADALLCMB)
> +COMPATIBLE_IOCTL(BIODASDEERSET)
> +COMPATIBLE_IOCTL(BIODASDEERGET)

Nack, now new ioctls in compat_ioctl.c, please.  In fact that file is
gone in -mm, so please submit this patch ontop of the -mm tree.


And is there a chance for a better interface than the notifier lists?
The code looks rather awkward because of it.
