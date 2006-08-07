Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbWHGVTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbWHGVTt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 17:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbWHGVTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 17:19:48 -0400
Received: from mail0.lsil.com ([147.145.40.20]:36808 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S932384AbWHGVTr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 17:19:47 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] megaraid: Use the proper type to hold the irq number.
Date: Mon, 7 Aug 2006 15:19:39 -0600
Message-ID: <890BF3111FB9484E9526987D912B261932E31D@NAMAIL3.ad.lsil.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] megaraid: Use the proper type to hold the irq number.
Thread-Index: Aca6NtobSslnKNRdR9GY9LYKxzjT0QAL0mzw
From: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Andrew Morton" <akpm@osdl.org>
Cc: "Kolli, Neela" <Neela.Kolli@engenio.com>, <linux-scsi@vger.kernel.org>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 07 Aug 2006 21:19:40.0131 (UTC) FILETIME=[317CFB30:01C6BA67]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
> This patches fixes that problem and the driver now appears
> to work.
> 
> The ioctl interface appears fundamentally broken as it exports
> the irq number to user space in an unsigned char.
Thank you for your findings.
As you mentioned above, driver needs more changes besides your patch.
I will submit a patch covers all required changes, soon.

Thank you again,

Seokmann

> -----Original Message-----
> From: linux-scsi-owner@vger.kernel.org 
> [mailto:linux-scsi-owner@vger.kernel.org] On Behalf Of Eric 
> W. Biederman
> Sent: Monday, August 07, 2006 11:29 AM
> To: Andrew Morton
> Cc: Kolli, Neela; linux-scsi@vger.kernel.org; Protasevich, 
> Natalie; linux-kernel@vger.kernel.org
> Subject: [PATCH] megaraid: Use the proper type to hold the irq number.
> 
> 
> When testing on a Unisys machine it was discovered that
> the megaraid driver would not initialize as it was
> requesting irq 162 instead of irq 1442 it was assigned.
> The problem was the irq number had been truncated by being
> stored in an unsigned char.
> 
> This patches fixes that problem and the driver now appears
> to work.
> 
> The ioctl interface appears fundamentally broken as it exports
> the irq number to user space in an unsigned char. 
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
>  drivers/scsi/megaraid/mega_common.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/scsi/megaraid/mega_common.h 
> b/drivers/scsi/megaraid/mega_common.h
> index 8cd0bd1..b50e27e 100644
> --- a/drivers/scsi/megaraid/mega_common.h
> +++ b/drivers/scsi/megaraid/mega_common.h
> @@ -175,7 +175,7 @@ typedef struct {
>  	uint8_t			max_lun;
>  
>  	uint32_t		unique_id;
> -	uint8_t			irq;
> +	int			irq;
>  	uint8_t			ito;
>  	caddr_t			ibuf;
>  	dma_addr_t		ibuf_dma_h;
> -- 
> 1.4.2.rc3.g7e18e
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
