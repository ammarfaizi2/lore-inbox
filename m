Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWDPKnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWDPKnZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 06:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbWDPKnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 06:43:25 -0400
Received: from mx2.mail.ru ([194.67.23.122]:16763 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S1750703AbWDPKnZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 06:43:25 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: zhiyi huang <hzy@cs.otago.ac.nz>
Subject: Re: Slab corruption after unloading a module
Date: Sun, 16 Apr 2006 14:43:20 +0400
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604161443.21653.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> There was no problem if I just load and unload the module. But if I
> write to the device using "ls > /dev/temp" and then unload the
> module, I would get slab corruption.

you return different value as what has really been consumed:

>         if (*f_pos + count > MAX_DSIZE)
>                 count1 = MAX_DSIZE - *f_pos;
>
>         if (copy_from_user (temp_dev->data+*f_pos, buf, count1)) {
>                 rv = -EFAULT;
>                 goto wrap_up;
>         }
>         up (&temp_dev->sem);
>         *f_pos += count1;
>         return count;

may be it confuses the rest of kernel a bit?

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEQh/JR6LMutpd94wRAgn/AKCapb6QcSSeHn1X7qD1TxLBs2OCSACgnGg7
o7fTn3l6DTnLEr5EwqL7hjk=
=bHLf
-----END PGP SIGNATURE-----
