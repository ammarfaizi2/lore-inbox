Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267354AbTB1Aw3>; Thu, 27 Feb 2003 19:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267384AbTB1Aw3>; Thu, 27 Feb 2003 19:52:29 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61703 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267354AbTB1Aw2>; Thu, 27 Feb 2003 19:52:28 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Is the GIO_FONT ioctl() busted in Linux kernel 2.4?
Date: 27 Feb 2003 17:02:29 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b3mcf5$629$1@cesium.transmeta.com>
References: <3E5DDE8D.14024.6FCE7D82@localhost> <3E5DE0FC.29370.6FD7FC8B@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3E5DE0FC.29370.6FD7FC8B@localhost>
By author:    "Kendall Bennett" <KendallB@scitechsoft.com>
In newsgroup: linux.dev.kernel
>
> "Kendall Bennett" <KendallB@scitechsoft.com> wrote:
> 
> > From looking at the 2.4 kernel source code that comes with Red
> > Hat 8.0, it is clear that these functions are implemented on top
> > of a new console font interface that supports 512 characters and
> > up to 32x32 pixel fonts (obviously for fb consoles). 
> 
> Yep, after further investigation the problem is that the VGA console is 
> configured to run with 512 characters, yet the 'old' interface code is 
> trying to save/restore only 256 characters so it fails. It could be fixed 
> if it was changed to save/restore 512 characters, but I don't know if 
> that will break old code (it won't break mine as I always uses a 64K 
> buffer to save/restore the font tables).
> 

It will break old code.  That's why you've been supposed to use
GIO_FONTX (and GIO_UNISCRNMAP) since the 1.3.1 kernel days (which is
when 512-character support was introduced.)

You're *way* behind the times.

man 4 console_ioctl

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: cris ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
