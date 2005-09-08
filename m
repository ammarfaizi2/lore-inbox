Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932564AbVIHCN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbVIHCN0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 22:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932563AbVIHCN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 22:13:26 -0400
Received: from mail.dvmed.net ([216.237.124.58]:52609 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932508AbVIHCNZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 22:13:25 -0400
Message-ID: <431F9E41.5010701@pobox.com>
Date: Wed, 07 Sep 2005 22:13:21 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [SCSI] qla1280: endianess annotations
References: <200509080111.j881BbNm032480@hera.kernel.org>
In-Reply-To: <200509080111.j881BbNm032480@hera.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> diff --git a/drivers/scsi/qla1280.c b/drivers/scsi/qla1280.c
> --- a/drivers/scsi/qla1280.c
> +++ b/drivers/scsi/qla1280.c
> @@ -1546,7 +1546,7 @@ qla1280_return_status(struct response * 
>  	int host_status = DID_ERROR;
>  	uint16_t comp_status = le16_to_cpu(sts->comp_status);
>  	uint16_t state_flags = le16_to_cpu(sts->state_flags);
> -	uint16_t residual_length = le16_to_cpu(sts->residual_length);
> +	uint16_t residual_length = le32_to_cpu(sts->residual_length);
>  	uint16_t scsi_status = le16_to_cpu(sts->scsi_status);
[...]
> +	__le16 status_flags;	/* Status flags. */
> +	__le16 time;		/* Time. */
> +	__le16 req_sense_length;/* Request sense data length. */
> +	__le32 residual_length;	/* Residual transfer length. */
> +	__le16 reserved[4];
>  	uint8_t req_sense_data[32];	/* Request sense data. */

This isn't merely an endian annotation.

Is this a size fix, from 16 to 32, or a typo?  If its not a typo, 
shouldn't the variable be declared 'uint32_t residual_length'?

	Jeff


