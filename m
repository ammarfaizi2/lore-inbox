Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317552AbSFIEqL>; Sun, 9 Jun 2002 00:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317557AbSFIEqK>; Sun, 9 Jun 2002 00:46:10 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:52485 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S317552AbSFIEqJ>;
	Sun, 9 Jun 2002 00:46:09 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200206090446.g594k8u492544@saturn.cs.uml.edu>
Subject: Re: [patch] fat/msdos/vfat crud removal
To: hirofumi@mail.parknet.co.jp (OGAWA Hirofumi)
Date: Sun, 9 Jun 2002 00:46:08 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org, chaffee@cs.berkeley.edu
In-Reply-To: <87hekddqc4.fsf@devron.myhome.or.jp> from "OGAWA Hirofumi" at Jun 09, 2002 01:32:43 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi writes:
> "Albert D. Cahalan" <acahalan@cs.uml.edu> writes:

>> - * Conversion from and to little-endian byte order. (no-op on i386/i486)
>> - *
>> - * Naming: Ca_b_c, where a: F = from, T = to, b: LE = little-endian,
>> - * BE = big-endian, c: W = word (16 bits), L = longword (32 bits)
>> - */
>> -
>> -#define CF_LE_W(v) le16_to_cpu(v)
>> -#define CF_LE_L(v) le32_to_cpu(v)
>> -#define CT_LE_W(v) cpu_to_le16(v)
>> -#define CT_LE_L(v) cpu_to_le32(v)
>
> Personally I think this patch makes code readable. But please don't
> remove Cx_LE_x macros. Cx_LE_x is used from dosfsck.

Then the macros should be put in dosfsck, which is not
part of the kernel.

> -	logical_sector_size =
> -		le16_to_cpu(get_unaligned((unsigned short *) &b->sector_size));
> +	logical_sector_size = le16_to_cpu(get_unaligned((u16*)&b->sector_size));

I notice lots of casts in the code. It would be better to
use the correct types to begin with.
