Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263095AbSJBMtE>; Wed, 2 Oct 2002 08:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263096AbSJBMtE>; Wed, 2 Oct 2002 08:49:04 -0400
Received: from 200-171-183-235.dsl.telesp.net.br ([200.171.183.235]:12046 "EHLO
	techlinux.com.br") by vger.kernel.org with ESMTP id <S263095AbSJBMtC>;
	Wed, 2 Oct 2002 08:49:02 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carlos E Gorges <carlos@techlinux.com.br>
To: linux-kernel@vger.kernel.org
Subject: (PATCH) Re: 2.5.40: make menuconfig error
Date: Wed, 2 Oct 2002 09:54:19 -0300
X-Mailer: KMail [version 1.4]
References: <200210021403.00305.fredi@e-salute.it> <20021002144444.A1369@mars.ravnborg.org>
In-Reply-To: <20021002144444.A1369@mars.ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200210020954.19757.carlos@techlinux.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Quarta 02 Outubro 2002 09:44, Sam Ravnborg wrote:
> On Wed, Oct 02, 2002 at 02:03:00PM +0200, Frederik Nosi wrote:
> > Please CC me because I'm not in the list
> > Here it is:
> >
> >
> > Menuconfig has encountered a possible error in one of the kernel's
> > configuration files and is unable to continue.  Here is the error
> > report:
> >
> >  Q> ./scripts/Menuconfig: MCmenu74: command not found
> >

The following patch fix it

--- linux-2.5.40/sound/Config.in	Tue Oct  1 04:06:30 2002
+++ linux-2.5/sound/Config.in	Wed Oct  2 07:27:04 2002
@@ -31,10 +31,7 @@
 if [ "$CONFIG_SND" != "n" -a "$CONFIG_ARM" = "y" ]; then
   source sound/arm/Config.in
 fi
-if [ "$CONFIG_SND" != "n" -a "$CONFIG_SPARC32" = "y" ]; then
-  source sound/sparc/Config.in
-fi
-if [ "$CONFIG_SND" != "n" -a "$CONFIG_SPARC64" = "y" ]; then
+if [ "$CONFIG_SND" != "n" -a "$CONFIG_SPARC32" = "y" ] || [ "$CONFIG_SND" != "n" -a "$CONFIG_SPARC64" = "y" ];then
   source sound/sparc/Config.in
 fi
 
--

-- 
	 _________________________
	 Carlos E Gorges          
	 (carlos@techlinux.com.br)
	 Tech informática LTDA
	 Brazil                   
	 _________________________


