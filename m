Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266147AbUHaK40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266147AbUHaK40 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 06:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267806AbUHaK40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 06:56:26 -0400
Received: from web52306.mail.yahoo.com ([206.190.39.101]:63167 "HELO
	web52306.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266147AbUHaK4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 06:56:24 -0400
Message-ID: <20040831105118.85292.qmail@web52306.mail.yahoo.com>
Date: Tue, 31 Aug 2004 12:51:18 +0200 (CEST)
From: =?iso-8859-1?q?Albert=20Herranz?= <albert_herranz@yahoo.es>
Subject: Re: 2.6.9-rc1-mm1 ppc build broken
To: Roland McGrath <roland@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <200408302348.i7UNmvw0006978@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is creating a circularity on ppc that others
> don't have apparently.
> 
> >   CC      arch/ppc/kernel/asm-offsets.s
> > In file included from include/linux/mm.h:4,
> 
> >                  from include/asm/io.h:7,
> >                  from include/linux/timex.h:61,
> 
> This #include link here is the issue.  Vanilla
> linux/timex.h does not have
> the #include <asm/io.h>.  On other machines,
> <asm/io.h> does not include
> <linux/mm.h>, so you don't get into the problem with
> sched.h.

Thanks.

The #include <asm/io.h> comes from bk-ia64.patch time
interpolation logic patch from Cristoph Lameter.

I've checked that at least for the embedded port I'm
working on the linux/mm.h is *not* a must on ppc
asm/io.h so we can get rid of it (commented out).
Maybe this is also true for the rest of ppc platforms.

Now 2.6.9-rc1-mm1 builds fine.

Cheers,
Albert



		
______________________________________________
Renovamos el Correo Yahoo!: ¡100 MB GRATIS!
Nuevos servicios, más seguridad
http://correo.yahoo.es
