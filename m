Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbWGBBKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbWGBBKt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 21:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWGBBKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 21:10:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:28543 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750891AbWGBBKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 21:10:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=Ek4Vb1UQMwyhWM98QQy4ZuWNOxrhUSWOedKAgn0BnKGHa0u/siImXgmGCXYuOHlhwyeIeCHVYMg6/WsBVKbXmOb3nti03gQ/wluk2JjkOMeCa1Yt1pqHTIhES9fphWpIo0EUusVN0aHKuuhIWOO+fTxrxHPZOafES0EbBHB6kXk=
Message-ID: <9929d2390607011810t53bfe61cw1a1f117f81f0af82@mail.gmail.com>
Date: Sat, 1 Jul 2006 18:10:46 -0700
From: "Jeff Kirsher" <jeffrey.t.kirsher@intel.com>
To: "Eric Sesterhenn" <snakebyte@gmx.de>
Subject: Re: [Patch] Typo in drivers/net/e1000/e1000_hw.c
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1151524043.26393.4.camel@alice>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1151524043.26393.4.camel@alice>
X-Google-Sender-Auth: 429227e5e6f5bc29
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/06, Eric Sesterhenn <snakebyte@gmx.de> wrote:
> hi,
>
> spotted by coverity (id #539), we should use the define
> with which the array is defined. We use min_agc as index
> for e1000_igp_2_cable_length_table[IGP02E1000_AGC_LENGTH_TABLE_SIZE]
> This patch also adds the -1 to make it safe so that we dont read
> past the end of the array.
>
> Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
>
> --- linux-2.6.17-git11/drivers/net/e1000/e1000_hw.c.orig        2006-06-28 21:46:55.000000000 +0200
> +++ linux-2.6.17-git11/drivers/net/e1000/e1000_hw.c     2006-06-28 21:47:07.000000000 +0200
> @@ -6012,7 +6012,7 @@ e1000_get_cable_length(struct e1000_hw *
>  {
>      int32_t ret_val;
>      uint16_t agc_value = 0;
> -    uint16_t cur_agc, min_agc = IGP01E1000_AGC_LENGTH_TABLE_SIZE;
> +    uint16_t cur_agc, min_agc = IGP02E1000_AGC_LENGTH_TABLE_SIZE - 1;
>      uint16_t max_agc = 0;
>      uint16_t i, phy_data;
>      uint16_t cable_length;
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

NACK.  This is corrected in the latest patch series that Auke
submitted to the kernel.  The correction is in [PATCH 18/21] e1000:
integrate ich8 support into driver.

-- 
Cheers,
Jeff
