Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261547AbUKIPEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261547AbUKIPEO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 10:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbUKIPEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 10:04:06 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:25612 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261547AbUKIPEA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 10:04:00 -0500
To: lsr@neapel230.server4you.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] Move check for invalid chars to
 vfat_valid_longname()
References: <41901DD1.mail5VX1GOOYK@lsrfire.ath.cx>
	<20041109013524.GB6835@neapel230.server4you.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 10 Nov 2004 00:03:35 +0900
In-Reply-To: <20041109013524.GB6835@neapel230.server4you.de> (lsr@neapel230.server4you.de's
 message of "Tue, 9 Nov 2004 02:35:24 +0100")
Message-ID: <87actr5ak8.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lsr@neapel230.server4you.de writes:

> +	/* check for invalid characters */
> +	for (p = name; p < name + len; p++) {
> +		if (*p < 0x0020 || strchr("*?<>|\":\\", *p) != NULL)
> +			return 0;
> +	}
> +
>  	return 1;
>  }
>  
> @@ -636,10 +627,6 @@ static int vfat_build_slots(struct inode
>  	if (res < 0)
>  		goto out_free;
>  
> -	res = vfat_is_used_badchars(uname, ulen);
> -	if (res < 0)
> -		goto out_free;
> -
>  	res = vfat_create_shortname(dir, sbi->nls_disk, uname, ulen,
>  				    msdos_name, &lcase);
>  	if (res < 0)

Some encodings is using the area of ascii code as second byte.
So, it can't.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
