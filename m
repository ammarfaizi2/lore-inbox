Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270434AbTGZQBo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 12:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269225AbTGZP6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 11:58:46 -0400
Received: from inerv.net ([213.41.139.94]:61644 "EHLO cat")
	by vger.kernel.org with ESMTP id S268559AbTGZP4n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 11:56:43 -0400
To: linux-kernel@vger.kernel.org
Subject: Compilation problems under Sparc64
From: Sylvain <thefunny@hosting42.com>
Date: 26 Jul 2003 18:12:53 +0200
Message-ID: <7x65lp2rne.fsf@sheena.arpej.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

        I have try to compile  the 2.6.0-test1 under sparc64, I have a
        ultra5 and  i obtain some  compilation problem with  floppy in
        include/asm/floppy.h (asm-sparc64). I fix this problem with :

217c217
< extern irqreturn_t floppy_hardint(int irq, void *unused, struct pt_regs *regs);
---
> extern void floppy_hardint(int irq, void *unused, struct pt_regs *regs);
280c280
< extern irqreturn_t floppy_interrupt(int irq, void *dev_id, struct pt_regs *regs);
---
> extern void floppy_interrupt(int irq, void *dev_id, struct pt_regs *regs);

        First are mine, and the second the orignal.

        I had  also a tv card, a  bt878, but it's need  i2c support in
        order to run correctly so  i make this change in configuration
        menu (arch/sparc64/Kconfig)

747,788d746
< menu "I2C support"
< 
< config I2C
< 	tristate "I2C support"
< 	---help---
< 	  I2C (pronounce: I-square-C) is a slow serial bus protocol used in
< 	  many micro controller applications and developed by Philips.  SMBus,
< 	  or System Management Bus is a subset of the I2C protocol.  More
< 	  information is contained in the directory <file:Documentation/i2c/>,
< 	  especially in the file called "summary" there.
< 
< 	  Both I2C and SMBus are supported here. You will need this for
< 	  hardware sensors support, and also for Video For Linux support.
< 	  Specifically, if you want to use a BT848 based frame grabber/overlay
< 	  boards under Linux, say Y here and also to "I2C bit-banging
< 	  interfaces", below.
< 
< 	  If you want I2C support, you should say Y here and also to the
< 	  specific driver for your bus adapter(s) below.  If you say Y to
< 	  "/proc file system" below, you will then get a /proc interface which
< 	  is documented in <file:Documentation/i2c/proc-interface>.
< 
< 	  This I2C support is also available as a module.  If you want to
< 	  compile it as a module, say M here and read
< 	  <file:Documentation/modules.txt>.
< 	  The module will be called i2c-core.
< 
< config I2C_ALGOBIT
< 	tristate "I2C bit-banging interfaces"
< 	depends on I2C
< 	help
< 	  This allows you to use a range of I2C adapters called bit-banging
< 	  adapters.  Say Y if you own an I2C adapter belonging to this class
< 	  and then say Y to the specific driver for you adapter below.
< 
< 	  This support is also available as a module.  If you want to compile
< 	  it as a module, say M here and read
< 	  <file:Documentation/modules.txt>.
< 	  The module will be called i2c-algo-bit.
< 
< endmenu
< 
810c768
< 	depends on PCI && VIDEO_DEV && I2C_ALGOBIT
---
> 	depends on PCI && VIDEO_DEV
824,842d781
< config VIDEO_TUNER
< 	tristate
< 	default y if VIDEO_BT848=y
< 	default m if VIDEO_BT848=m
< 	depends on VIDEO_DEV
< 
< config VIDEO_BUF
< 	tristate
< 	default y if VIDEO_BT848=y
< 	default m if VIDEO_BT848=m
< 	depends on VIDEO_DEV
< 
< config VIDEO_VIDEOBUF
< 	tristate
< 	default y if VIDEO_BT848=y
< 	default m if VIDEO_BT848=m
< 	depends on VIDEO_DEV
< 
< 


        And also this small fix on driver/media/video/bttv-risc.h :
        
32d31
< #include <asm/io.h>


        After making test, bttv seems to work well with it.

        You  need also  to active  input event  support not  to having
        unresolved symbol at the end of compilation.

        And for the end, my keybord  and my mouse doesn't work at all,
        and i  must use my computer  with ssh with  this kernel, don't
        you have  any idea  about this ?  (in console and  with Xfree,
        it's the same)
        
        If you know want to do for it, i would be happy to know too !

        Thank you and excuse me for my bad english. 


-- 
Viollon Sylvain						
		 Qui sème le vent récolte l'ouragan.
GNU FingerPrint : 052D 6BA2 34FF 6A39 150B  3EB8 BC84 1785 FA5D 5C97

