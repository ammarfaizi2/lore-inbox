Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422879AbWJRUVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422879AbWJRUVg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422890AbWJRUVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:21:35 -0400
Received: from cantor2.suse.de ([195.135.220.15]:23425 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422901AbWJRUVe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:21:34 -0400
Date: Wed, 18 Oct 2006 22:21:23 +0200
From: Karsten Keil <kkeil@suse.de>
To: Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org,
       Karsten Keil <kkeil@suse.de>,
       Kai Germaschewski <kai.germaschewski@gmx.de>,
       Frode Isaksen <fisaksen@bewan.com>
Subject: Re: [PATCH 5/6] isdn/hisax: use bitrev8
Message-ID: <20061018202123.GA32214@pingi.kke.suse.de>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org, Karsten Keil <kkeil@suse.de>,
	Kai Germaschewski <kai.germaschewski@gmx.de>,
	Frode Isaksen <fisaksen@bewan.com>
References: <20061018164757.GE21820@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061018164757.GE21820@localhost>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.16.21-0.23-smp x86_64
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2006 at 01:47:57AM +0900, Akinobu Mita wrote:
> Use bitrev8 for hisax_st5481 driver.
> 
> Cc: Karsten Keil <kkeil@suse.de>
> Cc: Kai Germaschewski <kai.germaschewski@gmx.de>
> Cc: Frode Isaksen <fisaksen@bewan.com>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> 
>  drivers/isdn/hisax/Kconfig    |    1 +
>  drivers/isdn/hisax/isdnhdlc.c |   25 -------------------------
>  drivers/isdn/hisax/isdnhdlc.h |    2 --
>  drivers/isdn/hisax/st5481_b.c |    3 ++-
>  4 files changed, 3 insertions(+), 28 deletions(-)
> 

Acked

> Index: work-fault-inject/drivers/isdn/hisax/isdnhdlc.c
> ===================================================================
> --- work-fault-inject.orig/drivers/isdn/hisax/isdnhdlc.c
> +++ work-fault-inject/drivers/isdn/hisax/isdnhdlc.c
> @@ -35,30 +35,6 @@ MODULE_LICENSE("GPL");
>  
>  /*-------------------------------------------------------------------*/
>  
> -/* bit swap table.
> - * Very handy for devices with different bit order,
> - * and neccessary for each transparent B-channel access for all
> - * devices which works with this HDLC decoder without bit reversal.
> - */
> -const unsigned char isdnhdlc_bit_rev_tab[256] = {
> -	0x00,0x80,0x40,0xC0,0x20,0xA0,0x60,0xE0,0x10,0x90,0x50,0xD0,0x30,0xB0,0x70,0xF0,
> -	0x08,0x88,0x48,0xC8,0x28,0xA8,0x68,0xE8,0x18,0x98,0x58,0xD8,0x38,0xB8,0x78,0xF8,
> -	0x04,0x84,0x44,0xC4,0x24,0xA4,0x64,0xE4,0x14,0x94,0x54,0xD4,0x34,0xB4,0x74,0xF4,
> -	0x0C,0x8C,0x4C,0xCC,0x2C,0xAC,0x6C,0xEC,0x1C,0x9C,0x5C,0xDC,0x3C,0xBC,0x7C,0xFC,
> -	0x02,0x82,0x42,0xC2,0x22,0xA2,0x62,0xE2,0x12,0x92,0x52,0xD2,0x32,0xB2,0x72,0xF2,
> -	0x0A,0x8A,0x4A,0xCA,0x2A,0xAA,0x6A,0xEA,0x1A,0x9A,0x5A,0xDA,0x3A,0xBA,0x7A,0xFA,
> -	0x06,0x86,0x46,0xC6,0x26,0xA6,0x66,0xE6,0x16,0x96,0x56,0xD6,0x36,0xB6,0x76,0xF6,
> -	0x0E,0x8E,0x4E,0xCE,0x2E,0xAE,0x6E,0xEE,0x1E,0x9E,0x5E,0xDE,0x3E,0xBE,0x7E,0xFE,
> -	0x01,0x81,0x41,0xC1,0x21,0xA1,0x61,0xE1,0x11,0x91,0x51,0xD1,0x31,0xB1,0x71,0xF1,
> -	0x09,0x89,0x49,0xC9,0x29,0xA9,0x69,0xE9,0x19,0x99,0x59,0xD9,0x39,0xB9,0x79,0xF9,
> -	0x05,0x85,0x45,0xC5,0x25,0xA5,0x65,0xE5,0x15,0x95,0x55,0xD5,0x35,0xB5,0x75,0xF5,
> -	0x0D,0x8D,0x4D,0xCD,0x2D,0xAD,0x6D,0xED,0x1D,0x9D,0x5D,0xDD,0x3D,0xBD,0x7D,0xFD,
> -	0x03,0x83,0x43,0xC3,0x23,0xA3,0x63,0xE3,0x13,0x93,0x53,0xD3,0x33,0xB3,0x73,0xF3,
> -	0x0B,0x8B,0x4B,0xCB,0x2B,0xAB,0x6B,0xEB,0x1B,0x9B,0x5B,0xDB,0x3B,0xBB,0x7B,0xFB,
> -	0x07,0x87,0x47,0xC7,0x27,0xA7,0x67,0xE7,0x17,0x97,0x57,0xD7,0x37,0xB7,0x77,0xF7,
> -	0x0F,0x8F,0x4F,0xCF,0x2F,0xAF,0x6F,0xEF,0x1F,0x9F,0x5F,0xDF,0x3F,0xBF,0x7F,0xFF
> -};
> -
>  enum {
>  	HDLC_FAST_IDLE,HDLC_GET_FLAG_B0,HDLC_GETFLAG_B1A6,HDLC_GETFLAG_B7,
>  	HDLC_GET_DATA,HDLC_FAST_FLAG
> @@ -621,7 +597,6 @@ int isdnhdlc_encode(struct isdnhdlc_vars
>  	return len;
>  }
>  
> -EXPORT_SYMBOL(isdnhdlc_bit_rev_tab);
>  EXPORT_SYMBOL(isdnhdlc_rcv_init);
>  EXPORT_SYMBOL(isdnhdlc_decode);
>  EXPORT_SYMBOL(isdnhdlc_out_init);
> Index: work-fault-inject/drivers/isdn/hisax/isdnhdlc.h
> ===================================================================
> --- work-fault-inject.orig/drivers/isdn/hisax/isdnhdlc.h
> +++ work-fault-inject/drivers/isdn/hisax/isdnhdlc.h
> @@ -57,8 +57,6 @@ struct isdnhdlc_vars {
>  #define HDLC_CRC_ERROR         2
>  #define HDLC_LENGTH_ERROR      3
>  
> -extern const unsigned char isdnhdlc_bit_rev_tab[256];
> -
>  extern void isdnhdlc_rcv_init (struct isdnhdlc_vars *hdlc, int do_adapt56);
>  
>  extern int isdnhdlc_decode (struct isdnhdlc_vars *hdlc, const unsigned char *src, int slen,int *count,
> Index: work-fault-inject/drivers/isdn/hisax/st5481_b.c
> ===================================================================
> --- work-fault-inject.orig/drivers/isdn/hisax/st5481_b.c
> +++ work-fault-inject/drivers/isdn/hisax/st5481_b.c
> @@ -14,6 +14,7 @@
>  #include <linux/usb.h>
>  #include <linux/slab.h>
>  #include <linux/netdevice.h>
> +#include <linux/bitrev.h>
>  #include "st5481.h"
>  
>  static inline void B_L1L2(struct st5481_bcs *bcs, int pr, void *arg)
> @@ -72,7 +73,7 @@ static void usb_b_out(struct st5481_bcs 
>  					register unsigned char *dest = urb->transfer_buffer+len;
>  					register unsigned int count;
>  					for (count = 0; count < bytes_sent; count++)
> -						*dest++ = isdnhdlc_bit_rev_tab[*src++];
> +						*dest++ = bitrev8(*src++);
>  				}
>  				len += bytes_sent;
>  			} else {
> Index: work-fault-inject/drivers/isdn/hisax/Kconfig
> ===================================================================
> --- work-fault-inject.orig/drivers/isdn/hisax/Kconfig
> +++ work-fault-inject/drivers/isdn/hisax/Kconfig
> @@ -402,6 +402,7 @@ config HISAX_ST5481
>  	tristate "ST5481 USB ISDN modem (EXPERIMENTAL)"
>  	depends on USB && EXPERIMENTAL
>  	select CRC_CCITT
> +	select BITREVERSE
>  	help
>  	  This enables the driver for ST5481 based USB ISDN adapters,
>  	  e.g. the BeWan Gazel 128 USB

-- 
Karsten Keil
SuSE Labs
ISDN development
