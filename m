Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265640AbUAKBat (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 20:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265694AbUAKBat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 20:30:49 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:45527 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265640AbUAKBaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 20:30:46 -0500
Date: Sun, 11 Jan 2004 02:30:43 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andreas Haumer <andreas@xss.co.at>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       linux-net@vger.kernel.org
Subject: [2.4 patch] disallow modular CONFIG_COMX
Message-ID: <20040111013043.GY25089@fs.tum.de>
References: <Pine.LNX.4.58L.0312311109131.24741@logos.cnet> <3FF2EAB3.1090001@xss.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FF2EAB3.1090001@xss.co.at>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 31, 2003 at 04:26:43PM +0100, Andreas Haumer wrote:
>...
> Hi!

Hi Andreas!

>...
> Here's a first report:
>...
> *) Unresolved symbol in kernel/drivers/net/wan/comx.o: proc_get_inode
>...

CONFIG_COMX=m always gave an unresolved symbol in kernel 2.4, and it
seems noone is interested in properly fixing it.

The patch below disallows a modular CONFIG_COMX.

cu
Adrian

--- linux-2.4.25-pre4-modular/drivers/net/wan/Config.in.old	2004-01-11 01:38:08.000000000 +0100
+++ linux-2.4.25-pre4-modular/drivers/net/wan/Config.in	2004-01-11 01:39:20.000000000 +0100
@@ -23,7 +23,7 @@
 # COMX drivers
 #
 
-   tristate '  MultiGate (COMX) synchronous serial boards support' CONFIG_COMX
+   bool '  MultiGate (COMX) synchronous serial boards support' CONFIG_COMX
    if [ "$CONFIG_COMX" != "n" ]; then
       dep_tristate '    Support for COMX/CMX/HiCOMX boards' CONFIG_COMX_HW_COMX $CONFIG_COMX
       dep_tristate '    Support for LoCOMX board' CONFIG_COMX_HW_LOCOMX $CONFIG_COMX
--- linux-2.4.25-pre4-modular/Documentation/Configure.help.old	2004-01-11 01:39:35.000000000 +0100
+++ linux-2.4.25-pre4-modular/Documentation/Configure.help	2004-01-11 01:40:14.000000000 +0100
@@ -11149,9 +11149,6 @@
   You must say Y to "/proc file system support" (CONFIG_PROC_FS) to
   use this driver.
 
-  If you want to compile this as a module, say M and read
-  <file:Documentation/modules.txt>.  The module will be called comx.o.
-
 Support for COMX/CMX/HiCOMX boards
 CONFIG_COMX_HW_COMX
   Hardware driver for the 'CMX', 'COMX' and 'HiCOMX' boards from the
