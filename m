Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129097AbQKOKfm>; Wed, 15 Nov 2000 05:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129272AbQKOKfd>; Wed, 15 Nov 2000 05:35:33 -0500
Received: from green.mif.pg.gda.pl ([153.19.42.8]:57101 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129097AbQKOKfW>; Wed, 15 Nov 2000 05:35:22 -0500
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200011151005.LAA20027@green.mif.pg.gda.pl>
Subject: PCI configuration changes
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Wed, 15 Nov 2000 11:05:07 +0100 (CET)
Cc: linux-kernel@vger.kernel.org (kernel list)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   Looking at the latest drivers/net/Config.in changes I noticed, that
two (modified earlier) lines are buggy:

      dep_tristate '    3c523 "EtherLink/MC" support' CONFIG_ELMC $CONFIG_MCA
      dep_tristate '    3c527 "EtherLink/MC 32" support (EXPERIMENTAL)' CONFIG_ELMC_II $CONFIG_MCA $CONFIG_EXPERIMENTAL

Note, that as CONFIG_MCA is defined only for i386 the dependencies on 
$CONFIG_MCA are no-op for other architectures (in Configure/Menuconfig).
Either CONFIG_MCA should be defined for all architectures or there should be
if ... fi around these lines.

BTW, is there any reason for not replacing 

   bool '  Other ISA cards' CONFIG_NET_ISA

by

  dep_bool '  Other ISA cards' CONFIG_NET_ISA $CONFIG_ISA

to eliminate more drivers from non-ISA arch configs ?

Andrzej

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
