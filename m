Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286188AbSBKB37>; Sun, 10 Feb 2002 20:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286207AbSBKB3t>; Sun, 10 Feb 2002 20:29:49 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:44040 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286188AbSBKB3c>; Sun, 10 Feb 2002 20:29:32 -0500
Subject: Re: [PATCH-2.4] drivers/char/pcwd.c
To: rob@osinvestor.com (Rob Radez)
Date: Mon, 11 Feb 2002 01:43:10 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0202101956510.26027-100000@pita.lan> from "Rob Radez" at Feb 10, 2002 08:07:33 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16a5Us-00055V-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> a) backports a 2.5 fix that closes what looks like a very small/minor
> race opportunity

I don't know what that "2.5 fix" is but I suggest someone replaces it 
with code that might actually work. Whoever put the 2.5 patch in please
fix it, or pull it back out again.

>  	case WDIOC_GETSUPPORT:
> -		i = copy_to_user((void*)arg, &ident, sizeof(ident));
> -		return i ? -EFAULT : 0;
> +		return copy_to_user((void*)arg, &ident, sizeof(ident)) ? -EFAULT : 0;

Ugly pointless change

> -	is_open = 0;
> +	set_bit(0, &open_allowed);

You can't mix set_bit with atomic operations

Alan
