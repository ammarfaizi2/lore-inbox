Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266944AbTBCSMT>; Mon, 3 Feb 2003 13:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266948AbTBCSMS>; Mon, 3 Feb 2003 13:12:18 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32786 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266944AbTBCSMR>; Mon, 3 Feb 2003 13:12:17 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 32bit dev_t
Date: 3 Feb 2003 10:21:19 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b1mbuv$fkf$1@cesium.transmeta.com>
References: <UTC200301242204.h0OM4jU09451.aeb@smtp.cwi.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <UTC200301242204.h0OM4jU09451.aeb@smtp.cwi.nl>
By author:    Andries.Brouwer@cwi.nl
In newsgroup: linux.dev.kernel
> 
> The main point to decide would be the external dev_t format.
> Of course the format must be compatible with existing filesystems
> and binaries. For example,
> 
> #define MAJOR(dev)      ((unsigned int)(((dev) & 0xffff0000) \
> 	? ((dev) >> 16) & 0xffff : ((dev) >> 8) & 0xff))
> #define MINOR(dev)      ((unsigned int)(((dev) & 0xffff0000) \
> 	? ((dev) & 0xffff) : ((dev) & 0xff)))
> #define MKDEV(ma,mi)    ((dev_t)((((ma) & ~0xff) == 0 && ((mi) & ~0xff) == 0) \
> 	? (((ma) << 8) | (mi)) : (((ma) << 16) | (mi))))
> 
> This is 1-1 on nonzero majors (and zero major, 8-bit minor).
> 

I thought we had already decided:

	12 bits major : 20 bits minor

The zero major is used for dev_t compatibility, of course.

I personally still prefer 32:32, but I got voted down.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: cris ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
