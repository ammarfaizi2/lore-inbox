Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWIYOr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWIYOr2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 10:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbWIYOr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 10:47:28 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:17798 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750700AbWIYOr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 10:47:27 -0400
Message-ID: <4517EBF7.4020508@torque.net>
Date: Mon, 25 Sep 2006 10:47:19 -0400
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix idiocy in asd_init_lseq_mdp()
References: <20060925015722.GF29920@ftp.linux.org.uk>
In-Reply-To: <20060925015722.GF29920@ftp.linux.org.uk>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> To whoever had written that code:
> 
> a) priority of >> is higher than that of &
> b) priority of typecast is higher than that of any binary operator
> c) learn the fscking C

Al,
On the assumption that you have hardware that uses this
driver, did you notice any improvement with your patch
applied?

Several of us have reported a degenerate mode, that
I term as "tmf timeout", in which a aic94xx based card
becomes inoperable. Alas, the same hardware running another
OS does not exhibit that problem (or at least not as much).

> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  drivers/scsi/aic94xx/aic94xx_seq.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/scsi/aic94xx/aic94xx_seq.c b/drivers/scsi/aic94xx/aic94xx_seq.c
> index d9b6da5..56e4b3b 100644
> --- a/drivers/scsi/aic94xx/aic94xx_seq.c
> +++ b/drivers/scsi/aic94xx/aic94xx_seq.c
> @@ -764,7 +764,7 @@ static void asd_init_lseq_mdp(struct asd
>  	asd_write_reg_word(asd_ha, LmSEQ_FIRST_INV_SCB_SITE(lseq),
>  			   (u16)last_scb_site_no+1);
>  	asd_write_reg_word(asd_ha, LmSEQ_INTEN_SAVE(lseq),
> -			    (u16) LmM0INTEN_MASK & 0xFFFF0000 >> 16);
> +			    (u16) ((LmM0INTEN_MASK & 0xFFFF0000) >> 16));
>  	asd_write_reg_word(asd_ha, LmSEQ_INTEN_SAVE(lseq) + 2,
>  			    (u16) LmM0INTEN_MASK & 0xFFFF);
>  	asd_write_reg_byte(asd_ha, LmSEQ_LINK_RST_FRM_LEN(lseq), 0);

BTW Luben was pointing out that the call you patched
and the following call can be combined into a less
trouble prone asd_write_reg_dword() call.

Doug Gilbert

