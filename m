Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265100AbSJaBuc>; Wed, 30 Oct 2002 20:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265101AbSJaBuc>; Wed, 30 Oct 2002 20:50:32 -0500
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:21161 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S265100AbSJaBub>; Wed, 30 Oct 2002 20:50:31 -0500
Date: Wed, 30 Oct 2002 20:56:57 -0500
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.45
Message-ID: <20021031015657.GA25211@ravel.coda.cs.cmu.edu>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021031013436.GG23438@vitelus.com> <Pine.GSO.4.21.0210302041380.13031-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0210302041380.13031-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2002 at 08:44:22PM -0500, Alexander Viro wrote:
> > Now running 'make oldconfig' or 'make menuconfig' requires a Qt
> > installation. I believe that this is a bug because these still work
> > fine without Qt when the -k flag is passed to make.
> 
> Remove "false" from the rule that spits out annoying shit about absence
> of QT (_yes_, I _know_ that I don't have that shite installed, thank
> you very much for reminder).
> 
> Doesn't solve the annoyance problem, though.

This patch got rid if the annoying warning for me. It might have broken
the xconfig stuff, but at least oldconfig/config/menuconfig don't depend
on having QT installed anymore.

Jan


--- linux-2.5.45/Makefile	2002-10-30 20:53:08.000000000 -0500
+++ linux/Makefile	2002-10-30 20:54:12.000000000 -0500
@@ -635,7 +635,7 @@
 .PHONY: oldconfig xconfig menuconfig config \
 	make_with_config
 
-scripts/kconfig/conf scripts/kconfig/mconf scripts/kconfig/qconf: scripts/fixdep FORCE
+scripts/kconfig/conf scripts/kconfig/mconf: scripts/fixdep FORCE
 	+@$(call descend,scripts/kconfig,$@)
 
 xconfig: scripts/kconfig/qconf
