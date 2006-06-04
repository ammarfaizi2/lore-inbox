Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932076AbWFDUYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWFDUYm (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 16:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWFDUYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 16:24:42 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:12491 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932076AbWFDUYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 16:24:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=S2ImFp5UkgFZDLYr7aLEiGslcWeA9rjLTu9oF+0UHGVwOmrpIRRmD/Il3IGJiXwLl9IqvsE3vKCxxu6C4r8nqdHLhBLyFO17utfX/Z/LAW0cmDlbIVHRwyoG/0ysd5S3/bZ1EN1J+vpo2roTDunnyOmQ4KPmUISHxNkvK/nOEUg=
Message-ID: <4483417D.8060109@gmail.com>
Date: Mon, 05 Jun 2006 05:24:29 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, Rune Torgersen <runet@innovsys.com>,
        jgarzik@pobox.com, linuxppc-dev@ozlabs.org,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.16.16] sata_sil24: SII3124 sata driver endian problem
References: <DCEAAC0833DD314AB0B58112AD99B93B0189DDFF@ismail.innsys.innovsys.com> <DCEAAC0833DD314AB0B58112AD99B93B0189DE08@ismail.innsys.innovsys.com> <20060602163035.05ab7c71.akpm@osdl.org> <20060604161124.GA7587@martell.zuzino.mipt.ru>
In-Reply-To: <20060604161124.GA7587@martell.zuzino.mipt.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan wrote:
> Are there some other fields that should be marked?

Yeap, prot and rx_cnt of sil24_prb should also be marked __le.  Also, 
all fields of sil24_port_multiplier

Thanks.

> [PATCH] sata_sil24: endian annotations
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  drivers/scsi/sata_sil24.c |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> --- a/drivers/scsi/sata_sil24.c
> +++ b/drivers/scsi/sata_sil24.c
> @@ -37,7 +37,7 @@
>   * Port request block (PRB) 32 bytes
>   */
>  struct sil24_prb {
> -	u16	ctrl;
> +	__le16	ctrl;
>  	u16	prot;
>  	u32	rx_cnt;
>  	u8	fis[6 * 4];
> @@ -47,9 +47,9 @@ struct sil24_prb {
>   * Scatter gather entry (SGE) 16 bytes
>   */
>  struct sil24_sge {
> -	u64	addr;
> -	u32	cnt;
> -	u32	flags;
> +	__le64	addr;
> +	__le32	cnt;
> +	__le32	flags;
>  };
>  
>  /*

-- 
tejun
