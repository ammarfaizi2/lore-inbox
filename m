Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbWICVwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWICVwI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 17:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWICVwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 17:52:08 -0400
Received: from wx-out-0506.google.com ([66.249.82.226]:30957 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750802AbWICVwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 17:52:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=B7aZ2Ub2nguUEGuBl6EKgiKc5BCE+zm5Khlstcmhrjl5nYTuy2VJWna6XmwR/LUNNE6b8IozphXPxI7A4HED/85RmXq0RVsOg1x4+jIGJPO+21MWQ4+saOLGLeWExy/bN02HB9A++UVa7Gzbt1PpPuVpD9slHIgrPd/BbnS0L3U=
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: Alon Bar-Lev <alon.barlev@gmail.com>, Andi Kleen <ak@suse.de>,
       Matt Domsch <Matt_Domsch@dell.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johninsd@san.rr.com,
       davej@codemonkey.org.uk, Riley@williams.name, trini@kernel.crashing.org,
       davem@davemloft.net, ecd@brainaid.de, jj@sunsite.ms.mff.cuni.cz,
       anton@samba.org, wli@holomorphy.com, lethal@linux-sh.org,
       lethal@linux-sh.org, rc@rc0.org.uk, spyro@f2s.com, spyro@f2s.com,
       rth@twiddle.net, avr32@atmel.com, hskinnemoen@atmel.com,
       starvik@axis.com, ralf@linux-mips.org, matthew@wil.cx,
       grundler@parisc-linux.org, geert@linux-m68k.org, zippel@linux-m68k.org,
       paulus@samba.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
       uclinux-v850@lsi.nec.co.jp, chris@zankel.net
Subject: [PATCH 00/26] Dynamic kernel command-line
Date: Mon, 4 Sep 2006 00:50:11 +0300
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609040050.13410.alon.barlev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Current implementation stores a static command-line
buffer allocated to COMMAND_LINE_SIZE size. Most
architectures stores two copies of this buffer, one
for future reference and one for parameter parsing.

In order to allow a greater command-line size, these
buffers should be dynamically allocated or marked
as init disposable buffers, so unused memory can be
released.

This patch renames the static saved_command_line
variable into boot_command_line adding __initdata
attribute, so that it can be disposed after
initialization. This rename is required so applications
that use saved_command_line will not be affected
by this change.

It reintroduces saved_command_line as dynamically
allocated buffer to match the data in boot_command_line.

It also mark secondary command-line buffer as __initdata,
and copies it to dynamically allocated static_command_line
buffer components may hold reference to it after
initialization.

This patch is for linux-2.6.18-rc5-mm1 and is divided to
target each architecture. I could not check this in any
architecture so please forgive me if I got it wrong.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

-- 
VGER BF report: U 0.5
