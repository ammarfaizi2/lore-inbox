Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278230AbRJMBJr>; Fri, 12 Oct 2001 21:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278232AbRJMBJi>; Fri, 12 Oct 2001 21:09:38 -0400
Received: from chac.inf.utfsm.cl ([200.1.19.54]:62983 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S278230AbRJMBJ2>;
	Fri, 12 Oct 2001 21:09:28 -0400
Message-Id: <200110130109.f9D19cZj023657@sleipnir.valparaiso.cl>
To: Matt_Domsch@Dell.com
cc: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Subject: Re: crc32 cleanups 
In-Reply-To: Message from Matt_Domsch@Dell.com 
   of "Fri, 12 Oct 2001 15:17:12 EST." <71714C04806CD51193520090272892178BD709@ausxmrr502.us.dell.com> 
Date: Fri, 12 Oct 2001 21:09:38 -0400
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt_Domsch@Dell.com said:
> > That leaves (a) unconditionally building 
> > it into the kernel, or (b) Makefile and Config.in rules.

> (a) is simple, but needs a 1KB malloc (or alternately, a 1KB static const
> array - I've taken the approach that the malloc is better)

Better static (less overhead in size and at runtime), initialized at build
time (you could compute it then). In case of _dire_ kernel size problems, it
can be left out anyway. AFAIU, there are now a _lot_ of copies of this
around, so you'll win overall in any case.

> (b) isn't that much harder, but requires drivers to be sure to call
> init_crc32 and cleanup_crc32.  If somehow they manage not to do that, Oops.
> I don't want to add a runtime check for the existance of the array in
> crc32().

KISS: Keep It Simple, Stupid. Unless it won't cut it, that is.
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
