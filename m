Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278229AbRJMBJh>; Fri, 12 Oct 2001 21:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278232AbRJMBJ2>; Fri, 12 Oct 2001 21:09:28 -0400
Received: from nsd.mandrakesoft.com ([216.71.84.35]:37138 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S278228AbRJMBJO>; Fri, 12 Oct 2001 21:09:14 -0400
Date: Fri, 12 Oct 2001 20:09:38 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
cc: Matt Domsch <Matt_Domsch@dell.com>, linux-kernel@vger.kernel.org
Subject: Re: crc32 cleanups 
In-Reply-To: <200110130104.f9D14e5b021424@sleipnir.valparaiso.cl>
Message-ID: <Pine.LNX.3.96.1011012200821.1405A-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Oct 2001, Horst von Brand wrote:
> Jeff Garzik <jgarzik@mandrakesoft.com> said:
> > We must consider the case where the kernel is built, and then a random
> > 3rd party module comes along that needs crc32 features.  An ar library
> > won't cut it, and neither will [the existing crc32 method of] patching
> > linux/lib/crc32.c.  That leaves (a) unconditionally building it into the
> > kernel, or (b) Makefile and Config.in rules.
> 
> (b) won't work if my kernel has no CRC32 modules, and a random 3rd party
> module needs it. So it looks like firm builtin is the only real option (a).

Sure it will.  (b) not only will work, but it is the preferred option.

lib/Makefile will contain the line
	obj-$(CONFIG_CRC32) += crc32.o

and arch/$arch/config.in will contain
	tristate 'Include crc32 library?' CONFIG_CRC32


