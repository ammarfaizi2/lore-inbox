Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317759AbSGPHqU>; Tue, 16 Jul 2002 03:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317773AbSGPHqT>; Tue, 16 Jul 2002 03:46:19 -0400
Received: from mtiwmhc21.worldnet.att.net ([204.127.131.46]:31892 "EHLO
	mtiwmhc21.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S317759AbSGPHqS>; Tue, 16 Jul 2002 03:46:18 -0400
Date: Tue, 16 Jul 2002 03:54:37 -0400
To: linux-kernel@vger.kernel.org
Cc: miles@megapathdsl.net, lostlogic@gentoo.org
Subject: Re: Linux 2.4.19-rc1-ac5 -- Build error in mpparse.c (possible fix)
Message-ID: <20020716075437.GA9226@lnuxlab.ath.cx>
References: <200207152148.g6FLm7Q24750@devserv.devel.redhat.com> <1026792066.1417.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1026792066.1417.19.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
From: khromy@lnuxlab.ath.cx (khromy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2002 at 09:01:06PM -0700, Miles Lane wrote:
<snip>
> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686   -nostdinc -I /usr/lib/gcc-lib/i686-pc-linux-gnu/3.1.1/include -DKBUILD_BASENAME=mpparse  -c -o mpparse.o mpparse.c
> In file included from mpparse.c:25:
> /usr/src/linux/include/asm/smp.h:45:1: warning: "INT_DELIVERY_MODE" redefined
> /usr/src/linux/include/asm/smp.h:42:1: warning: this is the location of the previous definition
> mpparse.c:72: parse error before numeric constant
> mpparse.c:76: parse error before numeric constant
> mpparse.c:77: parse error before numeric constant
> mpparse.c:78: parse error before numeric constant
> mpparse.c:79: parse error before numeric constant
> mpparse.c: In function `smp_read_mpc':
> mpparse.c:601: invalid lvalue in assignment
<snip>

I don't know how correct the following patch might be, but it allows
mpparse.c to compile.

(diff against 2.4.19-rc1-ac5)

--- include/asm-i386/smp.h.old	Tue Jul 16 03:21:52 2002
+++ include/asm-i386/smp.h	Tue Jul 16 03:39:00 2002
@@ -34,11 +34,6 @@
 #define		INT_DEST_ADDR_MODE		1     /* logical delivery */
 # endif
 #else
-#define		clustered_apic_mode		(0)
-#define		clustered_apic_logical		(0)
-#define		clustered_apic_physical		(0)
-#define		apic_broadcast_id		(APIC_BROADCAST_ID_APIC)
-#define		esr_disable			(0)
 #define		INT_DELIVERY_MODE		1     /* logical delivery */
 #define		TARGET_CPUS			0x01
 #define		INT_DEST_ADDR_MODE		1     /* logical delivery */

-- 
L1:	khromy		;khromy(at)lnuxlab.ath.cx
