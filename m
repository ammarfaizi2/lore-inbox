Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280998AbRKOTNI>; Thu, 15 Nov 2001 14:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280999AbRKOTM6>; Thu, 15 Nov 2001 14:12:58 -0500
Received: from postfix2-1.free.fr ([213.228.0.9]:36754 "HELO
	postfix2-1.free.fr") by vger.kernel.org with SMTP
	id <S280998AbRKOTMt> convert rfc822-to-8bit; Thu, 15 Nov 2001 14:12:49 -0500
Date: Thu, 15 Nov 2001 17:27:38 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Anton Blanchard <anton@samba.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] small sym-2 fix
In-Reply-To: <20011115153654.E22552@krispykreme>
Message-ID: <20011115172204.B1589-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 15 Nov 2001, Anton Blanchard wrote:

>
> Hi,
>
> I tested the sym-2 driver on ppc64 and found that hcb_p can be > 1 page
> but __sym_malloc fails for allocations over 1 page. This means we
> die in sym_attach.

The driver should not need more than 4096 bytes for a single allocation.
If the ppc64 page size is smaller, your patch is ok, otherwise something
may have to be fixed, likely in the driver. I cannot access to kernel
source immediately but I will check what kind of page size ppc64 is using
asap.

> With this patch the sym-2 works on ppc64. BTW so far it looks solid :)

Great!

Thanks for your report.

Regards,
  Gérard.
>
> Anton
>
> diff -urN 2.4.15-pre4/drivers/scsi/sym53c8xx_2/sym_glue.h linuxppc_2_4_devel_work/drivers/scsi/sym53c8xx_2/sym_glue.h
> --- 2.4.15-pre4/drivers/scsi/sym53c8xx_2/sym_glue.h	Thu Nov 15 13:38:02 2001
> +++ linuxppc_2_4_devel_work/drivers/scsi/sym53c8xx_2/sym_glue.h	Tue Nov 13 18:03:07 2001
> @@ -526,7 +526,7 @@
>   *  couple of things related to the memory allocator.
>   */
>  typedef u_long m_addr_t;	/* Enough bits to represent any address */
> -#define SYM_MEM_PAGE_ORDER 0	/* 1 PAGE  maximum */
> +#define SYM_MEM_PAGE_ORDER 1	/* 2 PAGE  maximum */
>  #define SYM_MEM_CLUSTER_SHIFT	(PAGE_SHIFT+SYM_MEM_PAGE_ORDER)
>  #ifdef	MODULE
>  #define SYM_MEM_FREE_UNUSED	/* Free unused pages immediately */
>
>

