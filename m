Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263673AbRFCRTz>; Sun, 3 Jun 2001 13:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263683AbRFCREX>; Sun, 3 Jun 2001 13:04:23 -0400
Received: from isis.lip6.fr ([132.227.60.2]:23300 "EHLO isis.lip6.fr")
	by vger.kernel.org with ESMTP id <S263656AbRFCREI>;
	Sun, 3 Jun 2001 13:04:08 -0400
X-pt: isis.lip6.fr
Date: Sun, 3 Jun 2001 19:04:05 +0200
From: Jean-Paul CHAPUT <jpc@asim.lip6.fr>
To: linux-kernel@vger.kernel.org
Cc: Jean-Paul CHAPUT <jpc@asim.lip6.fr>
Subject: Tulip driver advertising bug.
Message-ID: <20010603190405.A4884@melon.lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    Hello Mr Kernel,


    I've found a bug in the tulip driver in the advertising step. 

    As you can see at the end of this kernel message log, the driver
    switch to advertise 0001 (which is buggy) instead of 01e1 (the
    correct value for my card). 0001 means that the MII transceiver
    have no capabilities (neither 10baseT, 100baseT, AUI or anything
    else), so the switch shut down the link!
      I've found where this bug occurs in the kernel sources :

    drivers/net/tulip/tulip_core.c at line 1360

      the function tulip_parse_eeprom() overwrite the value of
    tp->to_advertise to 0x0001. This is strange (at least for me) because
    tp->to_advertise has just been previously set to the correct value.


    The kernel message :

Linux Tulip driver version 0.9.14 (February 20, 2001)
PCI: Found IRQ 11 for device 00:09.0
eth0: Digital DS21140 Tulip rev 32 at 0xe800, 00:00:C0:EF:EE:E9, IRQ 11.
eth0:  EEPROM default media type Autosense.
eth0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
eth0:  MII transceiver #3 config 3100 status 7809 advertising 01e1.
eth0:  Advertising 0001 on PHY 3, previously advertising 01e1.
eth0:  Advertising 0001 (to advertise is 0001).


    My system is a standart RedHat 7.1 distribution.



                                         Thanks a lot for Linux.

-- 

    J e a n - P a u l   C h a p u t
                  |
                  |-- e-mail : Jean-Paul.Chaput@lip6.fr
                  `-- Tel    : (33) 01.44.27.52.53
                                    06.66.25.35.55

    U P M C   Universite Pierre & Marie Curie
    L I P 6   Laboratoire d'Informatique de Paris VI
    A S I M   Architecture des Systemes Integres et Micro-electronique
