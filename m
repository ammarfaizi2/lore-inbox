Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbTLUCfv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 21:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbTLUCfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 21:35:51 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:53211 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262074AbTLUCfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 21:35:48 -0500
Date: Sun, 21 Dec 2003 03:35:45 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, Rik van Riel <riel@surriel.com>,
       linux-tr@linuxtr.net, jschlst@samba.org, cgoos@syskonnect.de,
       mid@auk.cx, jochen@scram.de
Subject: Re: [PATCH][TRIVIAL] dep_tristate wants 3 arguments (fwd)
Message-ID: <20031221023545.GV12750@fs.tum.de>
References: <20031212222655.GH1825@fs.tum.de> <3FDA426B.1060508@pobox.com> <20031212225343.GI1825@fs.tum.de> <3FE2A29D.30608@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FE2A29D.30608@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 19, 2003 at 02:02:53AM -0500, Jeff Garzik wrote:
> Adrian Bunk wrote:
> >
> >Consider:
> >  CONFIG_TMS380TR=m
> >
> >E.g. CONFIG_TMSPCI=y shouldn't be allowed in this case.
> 
> 
> Remove the 'if' and you are correct :)

Agreed, the updated patch is below.  :-)

> 	Jeff

cu
Adrian

--- linux-2.4.24-pre1-full/drivers/net/tokenring/Config.in.old	2003-12-21 03:32:12.000000000 +0100
+++ linux-2.4.24-pre1-full/drivers/net/tokenring/Config.in	2003-12-21 03:32:53.000000000 +0100
@@ -20,12 +20,12 @@
    dep_tristate '  IBM Lanstreamer chipset PCI adapter support' CONFIG_IBMLS $CONFIG_TR $CONFIG_PCI
    dep_tristate '  3Com 3C359 Token Link Velocity XL adapter support' CONFIG_3C359 $CONFIG_TR $CONFIG_PCI
    tristate '  Generic TMS380 Token Ring ISA/PCI adapter support' CONFIG_TMS380TR
-   if [ "$CONFIG_TMS380TR" != "n" ]; then
-      dep_tristate '    Generic TMS380 PCI support' CONFIG_TMSPCI $CONFIG_PCI
-      dep_tristate '    Generic TMS380 ISA support' CONFIG_TMSISA $CONFIG_ISA
-      dep_tristate '    Madge Smart 16/4 PCI Mk2 support' CONFIG_ABYSS $CONFIG_PCI
-      dep_tristate '    Madge Smart 16/4 Ringnode MicroChannel' CONFIG_MADGEMC $CONFIG_MCA
-   fi
+
+   dep_tristate '    Generic TMS380 PCI support' CONFIG_TMSPCI $CONFIG_PCI $CONFIG_TMS380TR
+   dep_tristate '    Generic TMS380 ISA support' CONFIG_TMSISA $CONFIG_ISA $CONFIG_TMS380TR
+   dep_tristate '    Madge Smart 16/4 PCI Mk2 support' CONFIG_ABYSS $CONFIG_PCI $CONFIG_TMS380TR
+   dep_tristate '    Madge Smart 16/4 Ringnode MicroChannel' CONFIG_MADGEMC $CONFIG_MCA $CONFIG_TMS380TR
+
    if [ "$CONFIG_ISA" = "y" -o "$CONFIG_MCA" = "y" ]; then
       tristate '  SMC ISA/MCA adapter support' CONFIG_SMCTR
    fi
