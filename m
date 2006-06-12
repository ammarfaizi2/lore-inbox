Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbWFLRG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWFLRG4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 13:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWFLRG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 13:06:56 -0400
Received: from xenotime.net ([66.160.160.81]:63723 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751211AbWFLRGz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 13:06:55 -0400
Date: Mon, 12 Jun 2006 10:09:42 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Ivo van Doorn <ivdoorn@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CRC ITU-T V.41
Message-Id: <20060612100942.62ad4d0e.rdunlap@xenotime.net>
In-Reply-To: <200606121617.08791.IvDoorn@gmail.com>
References: <200606121617.08791.IvDoorn@gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2006 16:17:04 +0200 Ivo van Doorn wrote:

> This will add the CRC calculation according
> to the CRC ITU-T V.41 to the kernel lib/ folder.
> 
> This code has been derived from the rt2x00 driver,
> currently found only in the wireless-dev tree, but
> this library is generic and could be used by more
> drivers who currently use their own implementation.

so the rt2x00 driver will be converted to use this lib/ code?

> Signed-off-by Ivo van Doorn <IvDoorn@gmail.com>
> ---
> 
> diff --git a/include/linux/crc-itu-t.h b/include/linux/crc-itu-t.h
> new file mode 100644
> index 0000000..84920f3
> --- /dev/null
> +++ b/include/linux/crc-itu-t.h
> @@ -0,0 +1,28 @@
> +/*
> + *	crc-itu-t.h - CRC ITU-T V.41 routine
> + *
> + * Implements the standard CRC ITU-T V.41:
> + *   Width 16
> + *   Poly  0x0x1021 (x^16 + x^12 + x^15 + 1)

what does 0x0x.... mean?  and aren't poly exponents usually
listed in descending order?  or should the 15 be 5?

> + *   Init  0
> + *
> + * This source code is licensed under the GNU General Public License,
> + * Version 2. See the file COPYING for more details.
> + */

> diff --git a/lib/crc-itu-t.c b/lib/crc-itu-t.c
> new file mode 100644
> index 0000000..b4d4a21
> --- /dev/null
> +++ b/lib/crc-itu-t.c
> @@ -0,0 +1,68 @@
> +
> +/**
> + * Compute the CRC-ITU-T for the data buffer

Please use Linux kernel-doc format.  See
Documentation/kernel-doc-nano-HOWTO.txt.  Basically:

 * crc_itu_t - compute the CRC-ITU-T for the data buffer

and make parameter changes below:

> + *
> + * @param crc     previous CRC value
> + * @param buffer  data pointer
> + * @param len     number of bytes in the buffer

 * @crc:	previous CRC value
 * @buffer:	data pointer
 * @len:	number of bytes in the buffer
 *
 * Returns the updated CRC value.

> + * @return        the updated CRC value
> + */
> +u16 crc_itu_t(u16 crc, const u8 *buffer, size_t len)
> +{


---
~Randy
