Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262509AbTC0MbM>; Thu, 27 Mar 2003 07:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262534AbTC0MbM>; Thu, 27 Mar 2003 07:31:12 -0500
Received: from relay.uni-heidelberg.de ([129.206.100.212]:59629 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S262509AbTC0MbL>; Thu, 27 Mar 2003 07:31:11 -0500
From: Bernd Schubert <bernd-schubert@web.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: 2.4.21pre6: make xconfig 
Date: Thu, 27 Mar 2003 13:42:01 +0100
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303271342.01813.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

make xconfig doesn't work:

gcc -o tkparse tkparse.o tkcond.o tkgen.o
cat header.tk >> ./kconfig.tk
./tkparse < ../arch/i386/config.in >> kconfig.tk
drivers/net/Config.in: 188: unknown command
make[1]: *** [kconfig.tk] Error 1
make[1]: Leaving directory `/tmpa/bernd/kernel/linux-2.4.20/scripts'
make: *** [xconfig] Error 2


This was already an issue for 2.4.21pre5 and someone also already posted 
this patch:


--- linux-2.4.20/drivers/net/Config.in.old      2003-03-27 13:31:50.000000000 +0100
+++ linux-2.4.20/drivers/net/Config.in  2003-03-27 13:30:37.000000000 +0100
@@ -185,7 +185,7 @@
       dep_tristate '    Davicom DM910x/DM980x support' CONFIG_DM9102 $CONFIG_PCI
       dep_tristate '    EtherExpressPro/100 support (eepro100, original Becker driver)' CONFIG_EEPRO100 $CONFIG_PCI
       if [ "$CONFIG_VISWS" = "y" ]; then
-         define_mbool CONFIG_EEPRO100_PIO y
+         define_bool CONFIG_EEPRO100_PIO y
       else
          dep_mbool '      Use PIO instead of MMIO' CONFIG_EEPRO100_PIO $CONFIG_EEPRO100
       fi


Best regards,
	Bernd
