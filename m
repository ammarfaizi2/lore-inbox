Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277696AbRJICPp>; Mon, 8 Oct 2001 22:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277699AbRJICPf>; Mon, 8 Oct 2001 22:15:35 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:65038 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S277696AbRJICPa>;
	Mon, 8 Oct 2001 22:15:30 -0400
Message-ID: <20011009041618.A6135@win.tue.nl>
Date: Tue, 9 Oct 2001 04:16:18 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: Radovan Garabik <garabik@melkor.dnp.fmph.uniba.sk>,
        linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] dead keys in unicode console mode
In-Reply-To: <20011008215313.A11879@melkor.dnp.fmph.uniba.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20011008215313.A11879@melkor.dnp.fmph.uniba.sk>; from Radovan Garabik on Mon, Oct 08, 2001 at 09:53:13PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2001 at 09:53:13PM +0200, Radovan Garabik wrote:
> FWIW, this little patch makes it possible to
> use dead keys in unicode console mode.
> It is against 2.4.10, but should apply cleanly in
> broader range of kernel versions.

>  struct kbdiacr {
> -        unsigned char diacr, base, result;
> +        unsigned char diacr, base;
> +        unsigned short int result; /* holds UCS2 value */
>  };

And now all existing binaries that use the KDGKBDIACR ioctl
dump core? And all existing binaries that use the KDSKBDIACR
ioctl do very strange things?

If you want to do something like this, a new ioctl and a new
structure are necessary. If you design something new, keep
examples like Vietnamese in mind (with several accents on
one symbol). We do support that now in the 8-bit world,
but complete support of the 16-bit world still requires
some work. (And in the meantime Unicode has already gone beyond.)
