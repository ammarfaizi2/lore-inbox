Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271131AbTGQQEH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 12:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271138AbTGQQEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 12:04:07 -0400
Received: from H143.C231.tor.velocet.net ([216.138.231.143]:19363 "EHLO
	mjfrazer.org") by vger.kernel.org with ESMTP id S271131AbTGQQEF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 12:04:05 -0400
Date: Thu, 17 Jul 2003 12:18:59 -0400
From: Mark Frazer <mark@mjfrazer.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19 -> 2.4.22-pre6 module version include redefines
Message-ID: <20030717121859.A26584@mjfrazer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Message-Flag: Outlook not so good.
Organization: Detectable, well, not really
X-Fry: Leela, Bender, we're going grave-robbing.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am getting warnings along the lines of
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon   -nostdinc -iwithprefix include -DKBUILD_BASENAME=exec_domain  -DEXPORT_SYMTAB -c exec_domain.c
In file included from /usr/src/linux/include/linux/modversions.h:113,
                 from /usr/src/linux/include/linux/module.h:21,
                 from exec_domain.c:14:
/usr/src/linux/include/linux/modules/hdlc_generic.ver:3:1: warning: "__ver_register_hdlc_device" redefined
In file included from /usr/src/linux/include/linux/modversions.h:112,
                 from /usr/src/linux/include/linux/module.h:21,
                 from exec_domain.c:14:
/usr/src/linux/include/linux/modules/hdlc.ver:3:1: warning: this is the location of the previous definition

$ grep __ver_register_hdlc_device include/linux/modules/hdlc*.ver
include/linux/modules/hdlc.ver:#define __ver_register_hdlc_device       smp_f4a3504f
include/linux/modules/hdlc_generic.ver:#define __ver_register_hdlc_device      smp_69f92d43

I only see this on my dual athlon box, not on my single x86.  These errors
are also seen in 2.4.19, 2.4.20 & 2.4.21.

.config and build output at http://mjfrazer.org/~mjfrazer/linux/

-mark
-- 
Like most of life's problems, this one can be solved with bending. - Bender
