Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbUBYKrB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 05:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbUBYKrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 05:47:01 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:62980 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261251AbUBYKq4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 05:46:56 -0500
Date: Wed, 25 Feb 2004 21:46:22 +1100
To: Olivier Berger <olberger@club-internet.fr>, 234631@bugs.debian.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: Bug#234631: kernel-source-2.6.3: kernel fails to compile : radeon_setup_i2c_bus etc.
Message-ID: <20040225104621.GA7893@gondor.apana.org.au>
References: <E1AvlK2-00060c-00@rms> <20040225100458.GC3535@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <20040225100458.GC3535@gondor.apana.org.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tags 234631 pending
quit

On Wed, Feb 25, 2004 at 09:04:58PM +1100, herbert wrote:
> On Tue, Feb 24, 2004 at 11:46:38PM +0100, Olivier Berger wrote:
> > Package: kernel-source-2.6.3
> > Version: 2.6.3-2
> > Severity: normal
> > 
> > I can provide the .config corresponding to this kernel if useful.
> 
> Please do.  Please also let me know how you arrived at the config
> file, i.e., whether you used oldconfig/menuconfig/gconfig.

Never mind, I've found the problem.  RADEON is selecting I2C_ALGOBIT
but as kconfig currently does not propagate selects up the dependency
chain (that is according to Roman), this can leave I2C as m while
I2C_ALGOBIT is y.

This patch fixes it by explicitly selecting I2C.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: kernel-2.5/drivers/video/Kconfig
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/video/Kconfig,v
retrieving revision 1.11
diff -u -r1.11 Kconfig
--- kernel-2.5/drivers/video/Kconfig	19 Feb 2004 09:55:58 -0000	1.11
+++ kernel-2.5/drivers/video/Kconfig	25 Feb 2004 10:46:06 -0000
@@ -463,6 +463,7 @@
 	tristate "Matrox acceleration"
 	depends on FB && PCI
 	select I2C_ALGOBIT if FB_MATROX_I2C
+	select I2C if FB_MATROX_I2C
 	---help---
 	  Say Y here if you have a Matrox Millennium, Matrox Millennium II,
 	  Matrox Mystique, Matrox Mystique 220, Matrox Productiva G100, Matrox
@@ -628,6 +629,7 @@
 	tristate "ATI Radeon display support"
 	depends on FB && PCI
 	select I2C_ALGOBIT if FB_RADEON_I2C
+	select I2C if FB_RADEON_I2C
 	help
 	  Choose this option if you want to use an ATI Radeon graphics card as
 	  a framebuffer device.  There are both PCI and AGP versions.  You

--fdj2RfSjLxBAspz7--
