Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262668AbSJBWEV>; Wed, 2 Oct 2002 18:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262669AbSJBWEV>; Wed, 2 Oct 2002 18:04:21 -0400
Received: from host194.steeleye.com ([66.206.164.34]:56073 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S262668AbSJBWEU>; Wed, 2 Oct 2002 18:04:20 -0400
Message-Id: <200210022209.g92M9kh02253@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Alessandro Amici <alexamici@tiscali.it>
cc: linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com
Subject: Re: 2.5.37+ i386 arch split broke external module builds 
In-Reply-To: Message from Alessandro Amici <alexamici@tiscali.it> 
   of "Wed, 02 Oct 2002 12:39:32 +0200." <20021002103932.C35A21EA74@alan.localdomain> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 02 Oct 2002 18:09:46 -0400
From: James Bottomley <James.Bottomley@HansenPartnership.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alexamici@tiscali.it said:
> comments are welcome, 

-#include "irq_vectors.h"
+#ifdef CONFIG_VISWS
+#include <asm/mach-visws/irq_vectors.h>
+#else
+#include <asm/mach-generic/irq_vectors.h>
+#endif

I'm afraid the whole purpose of the code was to get away from this type of 
#ifdef problem.  If you do this, every new mach-type added to i386 has to 
modify a bunch of kernel headers.

dwmw2@infradead.org said:
>  make -C /lib/modules/`uname -r`/build SUBDIRS=`pwd` modules 

This looks like a clean solution to me, since most kernel packages install 
this module build directory.

James


