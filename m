Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263288AbTDVRFe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 13:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263300AbTDVRFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 13:05:34 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55818 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263288AbTDVRFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 13:05:32 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] new system call mknod64
Date: 22 Apr 2003 10:17:13 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b83tep$ap2$1@cesium.transmeta.com>
References: <UTC200304220102.h3M126n06187.aeb@smtp.cwi.nl> <20030422020153.GA18141@mail.jlokier.co.uk> <3EA4AE54.80607@zytor.com> <20030422060013.GO16934@pegasys.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030422060013.GO16934@pegasys.ws>
By author:    jw schultz <jw@pegasys.ws>
In newsgroup: linux.dev.kernel
>
> On Mon, Apr 21, 2003 at 07:52:04PM -0700, H. Peter Anvin wrote:
> > Jamie Lokier wrote:
> > >>
> > >>The main advantage with making it a struct is that it keep people from
> > >>doing stupid stuff like (int)dev where dev is a kdev_t...  There is
> > >>all kinds of shit like that in the kernel...
> > > 
> > > If you want that good quality 64-bit code, try making it a struct
> > > containing just a u64 :)
> > > 
> > 
> > Perhaps:
> > 
> > #if BITS_PER_LONG == 64
> > typedef struct { u64 val; } kdev_t;
> > 
> > /* Macros for major minor mkdev */
> > #else
> > typedef struct { u32 major, minor; } kdev_t;
> > 
> > /* Macros... */
> > #endif
> > 
> 
> or a union?
> typedef union { u64 dev; struct { u32 major, minor; } d; } kdev_t;
> 

No... what I want to avoid, again, are idiots^Wpeople doing:

      foo = (int) dev->dev;

... or something like that.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
