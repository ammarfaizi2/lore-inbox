Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271892AbTHRQSE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 12:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272277AbTHRQSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 12:18:04 -0400
Received: from [63.247.75.124] ([63.247.75.124]:22672 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S271892AbTHRQSB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 12:18:01 -0400
Date: Mon, 18 Aug 2003 12:18:00 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       Jes Sorensen <jes@wildopensource.com>
Subject: Re: Qla1280 update to 3.23.24
Message-ID: <20030818161800.GE24693@gtf.org>
References: <200308181606.h7IG6utZ021778@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308181606.h7IG6utZ021778@hera.kernel.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 14, 2003 at 11:16:27PM +0000, Linux Kernel Mailing List wrote:
> diff -Nru a/drivers/scsi/qla1280.h b/drivers/scsi/qla1280.h
> --- a/drivers/scsi/qla1280.h	Mon Aug 18 09:07:03 2003
> +++ b/drivers/scsi/qla1280.h	Mon Aug 18 09:07:03 2003
> @@ -1111,7 +1111,11 @@
>  /*
>   *  Linux - SCSI Driver Interface Function Prototypes.
>   */
> +#if LINUX_VERSION_CODE < 0x020600
>  int qla1280_proc_info(char *, char **, off_t, int, int, int);
> +#else
> +int qla1280_proc_info(struct Scsi_Host *, char *, char **, off_t, int, int);
> +#endif

Since we have people _constantly_ screwing this up (but of course, never
you, Jes :)), please use the KERNEL_VERSION() macro instead of
open-coding the kernel version you are testing.  It makes these tests
not only harder to screw up, but easier to read, too.

	Jeff



