Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262686AbUAMA7H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 19:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262795AbUAMA7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 19:59:07 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:41681 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262686AbUAMA7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 19:59:00 -0500
Date: Tue, 13 Jan 2004 01:58:57 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andreas Haumer <andreas@xss.co.at>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       linux-net@vger.kernel.org
Subject: [2.4 patch] simplify COMX_PROTO_LAPB dependencies
Message-ID: <20040113005857.GY9677@fs.tum.de>
References: <Pine.LNX.4.58L.0312311109131.24741@logos.cnet> <3FF2EAB3.1090001@xss.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FF2EAB3.1090001@xss.co.at>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 31, 2003 at 04:26:43PM +0100, Andreas Haumer wrote:
> 
> Hi!

Hi Andreas!

>...
> Here's a first report:
>...
>    - Double (but deactivated) entry in config dialog for
>...
>      + "Wan Interfaces" / "Support for LAPB protocol on MultiGate boards"
>...

Thanks for this report.

The patch below fixes this issue, and as a side effect it's also a great
simplification (while remaining semantically equivalent with the
original dependencies).

cu
Adrian

--- linux-2.4.25-pre4-full/drivers/net/wan/Config.in.old	2004-01-13 01:48:47.000000000 +0100
+++ linux-2.4.25-pre4-full/drivers/net/wan/Config.in	2004-01-13 01:49:51.000000000 +0100
@@ -30,12 +30,7 @@
       dep_tristate '    Support for MixCOM board' CONFIG_COMX_HW_MIXCOM $CONFIG_COMX
       dep_tristate '    Support for MUNICH based boards: SliceCOM, PCICOM (WelCOM)' CONFIG_COMX_HW_MUNICH $CONFIG_COMX
       dep_tristate '    Support for HDLC and syncPPP protocols on MultiGate boards' CONFIG_COMX_PROTO_PPP $CONFIG_COMX
-      if [ "$CONFIG_LAPB" = "y" ]; then
-	 dep_tristate '    Support for LAPB protocol on MultiGate boards' CONFIG_COMX_PROTO_LAPB $CONFIG_COMX
-      fi
-      if [ "$CONFIG_LAPB" = "m" ]; then
-	 dep_tristate '    Support for LAPB protocol on MultiGate boards' CONFIG_COMX_PROTO_LAPB $CONFIG_LAPB
-      fi
+      dep_tristate '    Support for LAPB protocol on MultiGate boards' CONFIG_COMX_PROTO_LAPB $CONFIG_LAPB $CONFIG_COMX
       dep_tristate '    Support for Frame Relay on MultiGate boards' CONFIG_COMX_PROTO_FR $CONFIG_COMX
    fi
 
