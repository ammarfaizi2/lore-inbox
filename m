Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbVIKK2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbVIKK2h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 06:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbVIKK2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 06:28:37 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:134 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932467AbVIKK2g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 06:28:36 -0400
Date: Sun, 11 Sep 2005 12:26:49 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 10/20] aic94xx: aic94xx_reg.c Register access
Message-ID: <20050911102649.GA2742@elf.ucw.cz>
References: <4321E3CB.2060806@adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4321E3CB.2060806@adaptec.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +/* We know that the register wanted is in the range
> + * of the sliding window.
> + */
> +#define ASD_READ_SW(ww, type, ord)                                     \
> +static inline type asd_read_##ww##_##ord (struct asd_ha_struct *asd_ha,\
> +					  u32 reg)                     \
> +{                                                                      \
> +	struct asd_ha_addrspace *io_handle = &asd_ha->io_handle[0];    \
> +	u32 map_offs=(reg - io_handle-> ww##_base )+asd_mem_offs_##ww ();\
> +	return asd_read_##ord (asd_ha, (unsigned long) map_offs);      \
> +}
> +
> +#define ASD_WRITE_SW(ww, type, ord)                                    \
> +static inline void asd_write_##ww##_##ord (struct asd_ha_struct *asd_ha,\
> +				  u32 reg, type val)                   \
> +{                                                                      \
> +	struct asd_ha_addrspace *io_handle = &asd_ha->io_handle[0];    \
> +	u32 map_offs=(reg - io_handle-> ww##_base )+asd_mem_offs_##ww ();\
> +	asd_write_##ord (asd_ha, (unsigned long) map_offs, val);       \
> +}
> +
> +ASD_READ_SW(swa, u8,  byte);
> +ASD_READ_SW(swa, u16, word);
> +ASD_READ_SW(swa, u32, dword);
> +
> +ASD_READ_SW(swb, u8,  byte);
> +ASD_READ_SW(swb, u16, word);
> +ASD_READ_SW(swb, u32, dword);
> +
> +ASD_READ_SW(swc, u8,  byte);
> +ASD_READ_SW(swc, u16, word);
> +ASD_READ_SW(swc, u32, dword);
> +
> +ASD_WRITE_SW(swa, u8,  byte);
> +ASD_WRITE_SW(swa, u16, word);
> +ASD_WRITE_SW(swa, u32, dword);
> +
> +ASD_WRITE_SW(swb, u8,  byte);
> +ASD_WRITE_SW(swb, u16, word);
> +ASD_WRITE_SW(swb, u32, dword);
> +
> +ASD_WRITE_SW(swc, u8,  byte);
> +ASD_WRITE_SW(swc, u16, word);
> +ASD_WRITE_SW(swc, u32, dword);

This is certainly nice entry into "best abuse of macros" contest. Do
you really need all those inline functions?

> +static void __asd_write_reg_byte(struct asd_ha_struct *asd_ha, u32 reg, u8 val)
> +{
> +	struct asd_ha_addrspace *io_handle=&asd_ha->io_handle[0];
> +	BUG_ON(reg >= 0xC0000000 || reg < ALL_BASE_ADDR);

Will this work correctly with 2GB/2GB split kernels?
								Pavel

-- 
if you have sharp zaurus hardware you don't need... you know my address
