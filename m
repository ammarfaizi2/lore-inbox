Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423030AbWJQDiB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423030AbWJQDiB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 23:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423028AbWJQDiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 23:38:01 -0400
Received: from rtr.ca ([64.26.128.89]:34828 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1422705AbWJQDiA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 23:38:00 -0400
Message-ID: <45345015.2010601@rtr.ca>
Date: Mon, 16 Oct 2006 23:37:57 -0400
From: Mark Lord <liml@rtr.ca>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
Cc: Jens Axboe <jens.axboe@oracle.com>, Allen Martin <AMartin@nvidia.com>,
       Jeff Garzik <jeff@garzik.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       prakash@punnoor.de
Subject: Re: [PATCH] sata_nv ADMA/NCQ support for nForce4
References: <DBFABB80F7FD3143A911F9E6CFD477B018E8171B@hqemmail02.nvidia.com> <452C7C1D.3040704@shaw.ca> <20061011103038.GK6515@kernel.dk> <452F053B.2000906@shaw.ca> <20061013080434.GE6515@kernel.dk> <45344F4D.6070703@shaw.ca>
In-Reply-To: <45344F4D.6070703@shaw.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> 
> +/* ADMA Physical Region Descriptor - one SG segment */
> +struct nv_adma_prd {
> +	__le64			addr;
> +	__le32			len;
> +	u8			flags;
> +	u8			packet_len;
> +	__le16			reserved;
> +};
..
> +/* ADMA Command Parameter Block
> +   The first 5 SG segments are stored inside the Command Parameter Block itself.
> +   If there are more than 5 segments the remainder are stored in a separate
> +   memory area indicated by next_aprd. */
> +struct nv_adma_cpb {
> +	u8			resp_flags;    //0
> +	u8			reserved1;     //1
> +	u8			ctl_flags;     //2
> +	// len is length of taskfile in 64 bit words
> + 	u8			len;           //3 
> +	u8			tag;           //4
> +	u8			next_cpb_idx;  //5
> +	__le16			reserved2;     //6-7
> +	__le16			tf[12];        //8-31
> +	struct nv_adma_prd	aprd[5];       //32-111
> +	__le64			next_aprd;     //112-119
> +	__le64			reserved3;     //120-127
> +};


Are those CPB / PRD structs endian-safe when using a big-endian CPU?

Cheers
