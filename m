Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262407AbUJ0MVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262407AbUJ0MVU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 08:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262414AbUJ0MVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 08:21:20 -0400
Received: from mailsc1.simcon-mt.com ([195.27.129.236]:47944 "EHLO
	mailsc1.simcon-mt.com") by vger.kernel.org with ESMTP
	id S262407AbUJ0MU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 08:20:28 -0400
Date: Wed, 27 Oct 2004 14:24:17 +0200
From: "Andrei A. Voropaev" <av@simcon-mt.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.9 byteorder/little_endian.h __le64 type not defined for iproute2
Message-ID: <20041027122417.GB10280@avorop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Compilation of iproute2 package fails on iptunnel.c because it includes
asm/byteorder.h which in turn includes linux/byteorder/little_endian.h
and in new 2.6.9 headers that declares function

static inline __le64 __cpu_to_le64p(const __u64 *p)

The __le64 type is not defined here. This happens because linux/types.h
defines this type only if __KERNEL_STRICT_NAMES is not defined. And by
default it is defined in features.h

I've tried to define it, but this creates conflicts for dev_t and other
types that are defined in sys/types.h

So, what should be the work around in this case?

Specifically the error is

make[1]: Entering directory `/tools/src/iproute2-2.6.9/ip'
gcc -D_GNU_SOURCE -O2 -Wstrict-prototypes -Wall -g -I../include -DRESOLVE_HOSTNAMES   -c -o iptunnel.o iptunnel.c
In file included from /usr/include/asm/byteorder.h:31,
                 from iptunnel.c:29:
/usr/include/linux/byteorder/little_endian.h:43: error: parse error before "__cpu_to_le64p"
/usr/include/linux/byteorder/little_endian.h: In function `__cpu_to_le64p':
/usr/include/linux/byteorder/little_endian.h:45: error: `__le64' undeclared (first use in this function)
....

Andrei
