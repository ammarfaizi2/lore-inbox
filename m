Return-Path: <linux-kernel-owner+w=401wt.eu-S1751524AbXAHNSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbXAHNSZ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 08:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751521AbXAHNSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 08:18:25 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:63228 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbXAHNSZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 08:18:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=RKGd8IsofzYKnZNsJlhP469snDM328m8xS7QdwprvgMJRjyNSmK9JjaGroaAtiRDcUkmgZFlIwyuQmSAzdILsC79NYIS9hr3oYHmd+Ms/F2VyJroCDyoNmUF/skNmWU/PprSoR6CMuK8h+ml6oiGTaUdXKUZNLW/reTi7Gu41b4=
Message-ID: <8bf247760701080518s3f58f5aax4250bca4a43e9d59@mail.gmail.com>
Date: Mon, 8 Jan 2007 18:48:23 +0530
From: Ram <vshrirama@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: kernel compilation - errors
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   Im using linux-2.6.14-omap2430.

   Im using TI omap 2430 SDP.

   When i compile it with the eldk toolchain.

   I get an error listed at the end of this mail.

  The error is simple - case values should be constants, However, the
toolchain gcc 4.0
  is complaining that case values are not constant.

  Actually, the some of the case values are defined as -

  case (u32)&CM_ICLKEN_WKUP:
  case (u32)&CM_FCLKEN_WKUP:

 However, the same code compiles with some other compilers (lower
versions of gcc).

  I think all compilers should give the same error

  Why the difference in behaviour?.

Not sure, if the source located at linux.omap.com/pub is broken.
Couldnt find the sources of linux kernel for omap2430 with higher
versions of the linux kernel higher than 2.6.14.


Please advice,


Regards,
sriram

Error:

    CHK     include/linux/version.h
make[1]: `include/asm-arm/mach-types.h' is up to date.
  CHK     include/linux/compile.h
  CHK     usr/initramfs_list
  CC      arch/arm/mach-omap2/clock24xx.o
arch/arm/mach-omap2/clock24xx.c:47: error: static declaration of
'clockfw_lock' follows non-static declaration
include/asm/arch/clock.h:53: error: previous declaration of
'clockfw_lock' was here
arch/arm/mach-omap2/clock24xx.c: In function 'do_omap_set_performance':
arch/arm/mach-omap2/clock24xx.c:579: warning: no return statement in
function returning non-void
arch/arm/mach-omap2/clock24xx.c: In function 'clk_safe':
arch/arm/mach-omap2/clock24xx.c:1223: error: case label does not
reduce to an integer constant
arch/arm/mach-omap2/clock24xx.c:1224: error: case label does not
reduce to an integer constant
arch/arm/mach-omap2/clock24xx.c:1228: error: case label does not
reduce to an integer constant
arch/arm/mach-omap2/clock24xx.c:1229: error: case label does not
reduce to an integer constant
arch/arm/mach-omap2/clock24xx.c:1236: error: case label does not
reduce to an integer constant
arch/arm/mach-omap2/clock24xx.c:1237: error: case label does not
reduce to an integer constant
arch/arm/mach-omap2/clock24xx.c:1241: error: case label does not
reduce to an integer constant
arch/arm/mach-omap2/clock24xx.c:1242: error: case label does not
reduce to an integer constant
arch/arm/mach-omap2/clock24xx.c:1246: error: case label does not
reduce to an integer constant
arch/arm/mach-omap2/clock24xx.c:1250: error: case label does not
reduce to an integer constant
arch/arm/mach-omap2/clock24xx.c:1254: error: case label does not
reduce to an integer constant
arch/arm/mach-omap2/clock24xx.c:1255: error: case label does not
reduce to an integer constant
arch/arm/mach-omap2/clock24xx.c:1259: error: case label does not
reduce to an integer constant
arch/arm/mach-omap2/clock24xx.c:1260: error: case label does not
reduce to an integer constant
make[1]: *** [arch/arm/mach-omap2/clock24xx.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2


code is :
 switch((u32)(clk->enable_reg)){
                case (u32)&CM_ICLKEN_MDM:
                case (u32)&CM_FCLKEN_MDM:
                        pReg = &CM_IDLEST_MDM;
                        off = 0x0;
                        break;
                case (u32)&CM_ICLKEN_DSP:
                case (u32)&CM_FCLKEN_DSP:
                        pReg = &CM_IDLEST_DSP;
                        if(enbit == 1)
                                off = 0;
                        else
                                off = enbit;
                        break;
                case (u32)&CM_ICLKEN_WKUP:
                case (u32)&CM_FCLKEN_WKUP:
                        pReg = &CM_IDLEST_WKUP;
                        off = enbit;
                        break;
                case (u32)&CM_ICLKEN_GFX:
                case (u32)&CM_FCLKEN_GFX:
                        pReg = &CM_IDLEST_GFX;
                        off = 0x0;
                        break;
                case (u32)&CM_ICLKEN4_CORE:
                         pReg = &CM_IDLEST4_CORE;
                         off = enbit;
                         break;
                case (u32)&CM_ICLKEN3_CORE:
                         pReg = &CM_IDLEST3_CORE;
