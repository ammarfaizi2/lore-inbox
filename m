Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267624AbUJDOlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267624AbUJDOlh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 10:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267916AbUJDOlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 10:41:36 -0400
Received: from CPE-144-131-116-152.nsw.bigpond.net.au ([144.131.116.152]:56305
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S267624AbUJDOlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 10:41:07 -0400
Message-ID: <416160FE.2090107@eyal.emu.id.au>
Date: Tue, 05 Oct 2004 00:41:02 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel list <linux-kernel@vger.kernel.org>
Subject: 2.6.9-rc3-mm2: error: `u64' used prior to declaration
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   CC [M]  drivers/media/dvb/bt8xx/dvb-bt8xx.o
In file included from drivers/media/dvb/bt8xx/dvb-bt8xx.c:22:
include/asm/bitops.h:543: error: parse error before "rol64"
include/asm/bitops.h:543: error: parse error before "x"
include/asm/bitops.h:543: warning: return type defaults to `int'
include/asm/bitops.h:543: warning: function declaration isn't a prototype
include/asm/bitops.h: In function `rol64':
include/asm/bitops.h:544: error: `num' undeclared (first use in this function)
include/asm/bitops.h:544: error: (Each undeclared identifier is reported only on
ce
include/asm/bitops.h:544: error: for each function it appears in.)
include/asm/bitops.h:545: error: `u64' undeclared (first use in this function)
include/asm/bitops.h:545: error: parse error before "vv"
include/asm/bitops.h:545: error: `vv' undeclared (first use in this function)
include/asm/bitops.h:547: error: `x' undeclared (first use in this function)
include/asm/bitops.h: At top level:
include/asm/bitops.h:549: error: parse error before "ror64"
include/asm/bitops.h:549: error: parse error before "x"
include/asm/bitops.h:549: warning: return type defaults to `int'
include/asm/bitops.h:549: warning: function declaration isn't a prototype
include/asm/bitops.h: In function `ror64':
include/asm/bitops.h:550: error: `num' undeclared (first use in this function)
include/asm/bitops.h:551: error: `u64' undeclared (first use in this function)
include/asm/bitops.h:551: error: parse error before "vv"
include/asm/bitops.h:551: error: `vv' undeclared (first use in this function)
include/asm/bitops.h:552: error: `x' undeclared (first use in this function)
In file included from include/linux/types.h:14,
                  from include/linux/capability.h:16,
                  from include/linux/sched.h:7,
                  from include/linux/module.h:10,
                  from drivers/media/dvb/bt8xx/dvb-bt8xx.c:23:
include/asm/types.h: At top level:
include/asm/types.h:50: error: `u64' used prior to declaration
make[4]: *** [drivers/media/dvb/bt8xx/dvb-bt8xx.o] Error 1
make[3]: *** [drivers/media/dvb/bt8xx] Error 2
make[2]: *** [drivers/media/dvb] Error 2
make[1]: *** [drivers/media] Error 2
make: *** [drivers] Error 2

I just added
	#include <asm/types.h>
to the top of
	include/asm/bitops.h
and the build finished


BTW, I also see tons of warnings like:

drivers/media/dvb/b2c2/skystar2.c:2069: warning: passing arg 1 of `readl' makes pointer from integer without a cast
drivers/media/dvb/b2c2/skystar2.c:2086: warning: passing arg 2 of `writel' makes pointer from integer without a cast

drivers/atm/iphase.c:1017: warning: passing arg 1 of `readw' makes pointer from integer without a cast
drivers/atm/iphase.c:1070: warning: passing arg 2 of `writew' makes pointer from integer without a cast
drivers/isdn/hisax/teles0.c:35: warning: passing arg 1 of `readb' makes pointer from integer without a cast
drivers/isdn/hisax/teles0.c:41: warning: passing arg 2 of `writeb' makes pointer from integer without a cast
drivers/isdn/hisax/telespci.c:50: warning: passing arg 1 of `readl' makes pointer from integer without a cast
drivers/isdn/hisax/telespci.c:53: warning: passing arg 2 of `writel' makes pointer from integer without a cast


--
Eyal Lebedinsky	 (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
