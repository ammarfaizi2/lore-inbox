Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267739AbTBRJHo>; Tue, 18 Feb 2003 04:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267740AbTBRJHn>; Tue, 18 Feb 2003 04:07:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26377 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267739AbTBRJHm>;
	Tue, 18 Feb 2003 04:07:42 -0500
Message-ID: <3E51FA1C.7060807@pobox.com>
Date: Tue, 18 Feb 2003 04:17:16 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: sam@ravnborg.org, kai@tp1.ruhr-uni-bochum.de, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] klibc for 2.5.59 bk
References: <20030209125759.GA14981@kroah.com>                                                                <Pine.LNX.4.44.0302162057200.5217-100000@chaos.physics.uiowa.edu>                                                                <20030217180246.GA26112@mars.ravnborg.org>        <1911.212.181.176.76.1045505249.squirrel@www.zytor.com>        <3E512BCB.1010000@pobox.com> <1144.62.20.229.212.1045558700.squirrel@www.zytor.com>
In-Reply-To: <1144.62.20.229.212.1045558700.squirrel@www.zytor.com>
Content-Type: multipart/mixed;
 boundary="------------060808040303090105010500"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060808040303090105010500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

H. Peter Anvin wrote:
> However, I can personally vouch for that it's *not* fixed for the main
> kernel build as of 2.5.61.


Well, if I had a Transmeta-powered laptop or handheld, I'm sure that 
would be fixed too ;-)

Can you give the attached patch a quick once-over?  It's obvious enough 
but I would rather the patch got tested nonetheless.

	Jeff



--------------060808040303090105010500
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1051  -> 1.1052 
#	  arch/i386/Makefile	1.44    -> 1.45   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/02/18	jgarzik@redhat.com	1.1052
# [ia32] fix Crusoe CFLAGS on newer gcc versions
# --------------------------------------------
#
diff -Nru a/arch/i386/Makefile b/arch/i386/Makefile
--- a/arch/i386/Makefile	Tue Feb 18 04:15:39 2003
+++ b/arch/i386/Makefile	Tue Feb 18 04:15:39 2003
@@ -39,7 +39,8 @@
 cflags-$(CONFIG_MK6)		+= $(call check_gcc,-march=k6,-march=i586)
 cflags-$(CONFIG_MK7)		+= $(call check_gcc,-march=athlon,-march=i686 -malign-functions=4)
 cflags-$(CONFIG_MK8)		+= $(call check_gcc,-march=k8,$(call check_gcc,-march=athlon,-march=i686 -malign-functions=4))
-cflags-$(CONFIG_MCRUSOE)	+= -march=i686 -malign-functions=0 -malign-jumps=0 -malign-loops=0
+cflags-$(CONFIG_MCRUSOE)	+= -march=i686
+cflags-$(CONFIG_MCRUSOE)	+= $(call check_gcc,-falign-functions=0 -falign-jumps=0 -falign-loops=0,-malign-functions=0 -malign-jumps=0 -malign-loops=0)
 cflags-$(CONFIG_MWINCHIPC6)	+= $(call check_gcc,-march=winchip-c6,-march=i586)
 cflags-$(CONFIG_MWINCHIP2)	+= $(call check_gcc,-march=winchip2,-march=i586)
 cflags-$(CONFIG_MWINCHIP3D)	+= -march=i586

--------------060808040303090105010500--

