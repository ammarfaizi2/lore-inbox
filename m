Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130485AbRC3UD5>; Fri, 30 Mar 2001 15:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130532AbRC3UDt>; Fri, 30 Mar 2001 15:03:49 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:7432 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S130485AbRC3UD3>; Fri, 30 Mar 2001 15:03:29 -0500
Message-Id: <200103302001.f2UK1MMv024840@pincoya.inf.utfsm.cl>
To: Keith Owens <kaos@ocs.com.au>
cc: "Chris Funderburg" <chris@directcommunications.net>,
   "Linux-Kernel" <linux-kernel@vger.kernel.org>,
   "Justin T. Gibbs" <gibbs@scsiguy.com>
Subject: Re: memcpy in 2.2.19 
In-Reply-To: Message from Keith Owens <kaos@ocs.com.au> 
   of "Thu, 29 Mar 2001 23:28:37 PST." <7717.985937317@ocs3.ocs-net> 
Date: Fri, 30 Mar 2001 16:01:22 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au> said:
> On Fri, 30 Mar 2001 08:04:17 +0100, 
> "Chris Funderburg" <chris@directcommunications.net> wrote:
> >drivers/scsi/scsi.a(aic7xxx.o): In function `aic7xxx_load_seeprom':
> >aic7xxx.o(.text+0x116bf): undefined reference to `memcpy'

> Under some circumstances gcc will generate an internal call to
> memcpy().  Alas this bypasses the pre-processor so memcpy is not
> converted to the kernel's internal memcpy code.  The cause is normally
> a structure assignment, probably this line.
> 
>   struct seeprom_config *sc = (struct seeprom_config *) scarray;

Just a pointer initialization.

[...]

> The other possibility I can see is
> 
>     p->sc = *sc;
> 
> try
> 
>     memcpy(&(p->sc), sc, sizeof(*sc));
-- 
Dr. Horst H. von Brand                       mailto:vonbrand@inf.utfsm.cl
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
