Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267411AbUIMOhZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267411AbUIMOhZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 10:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267566AbUIMOd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 10:33:58 -0400
Received: from aun.it.uu.se ([130.238.12.36]:64682 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S267568AbUIMOb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 10:31:56 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16709.44428.954085.884545@alkaid.it.uu.se>
Date: Mon, 13 Sep 2004 16:24:12 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, ipslinux@adaptec.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: 2.4.28-pre3: broken ips update
In-Reply-To: <20040913070334.GD1937@fs.tum.de>
References: <20040911220117.GA4669@logos.cnet>
	<20040913070334.GD1937@fs.tum.de>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk writes:
 > On Sat, Sep 11, 2004 at 07:01:17PM -0300, Marcelo Tosatti wrote:
 > >...
 > > Summary of changes from v2.4.28-pre2 to v2.4.28-pre3
 > > ============================================
 > >...
 > > Jack Hammer:
 > >   o ServeRAID driver (ips) Version 7.10.18
 > >...
 > 
 > <--  snip  -->
 > 
 > ...
 > gcc-3.4 -D__KERNEL__ 
 > -I/home/bunk/linux/kernel-2.4/linux-2.4.28-pre3-full/include -Wall 
 > -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
 > -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon 
 > -fno-unit-at-a-time   -nostdinc -iwithprefix include 
 > -DKBUILD_BASENAME=ips  -c -o ips.o ips.c
 > In file included from ips.c:190:
 > ips.h:101: error: redefinition of typedef 'irqreturn_t'
 > /home/bunk/linux/kernel-2.4/linux-2.4.28-pre3-full/include/linux/interrupt.h:16: 
 > error: previous declaration of 'irqreturn_t' was here
 > make[3]: *** [ips.o] Error 1
 > make[3]: Leaving directory `/home/bunk/linux/kernel-2.4/linux-2.4.28-pre3-full/drivers/scsi'

I posted a patch yesterday fixing this very issue.
The compat definitions in ips.h are in conflict with the
kernel's own compat definitions in interrupt.h. The
workaround is to disable ips.h's irqreturn_t etc emulation
for kernels >= 2.4.23.

/Mikael
