Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287748AbSBCUrv>; Sun, 3 Feb 2002 15:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287751AbSBCUrm>; Sun, 3 Feb 2002 15:47:42 -0500
Received: from inet-mail3.oracle.com ([148.87.2.203]:13555 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S287748AbSBCUrb>; Sun, 3 Feb 2002 15:47:31 -0500
Message-ID: <3C5DA20E.6D503E66@oracle.com>
Date: Sun, 03 Feb 2002 21:48:14 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: modular floppy broken in 2.5.3
In-Reply-To: <3C5B4326.856A09E6@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alessandro Suardi wrote:
> 
> Trying to modprobe it yields
> 
> [root@dolphin root]# modprobe floppy
> /lib/modules/2.5.3/kernel/drivers/block/floppy.o: init_module: Device or resource busy
> Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters
> /lib/modules/2.5.3/kernel/drivers/block/floppy.o: insmod /lib/modules/2.5.3/kernel/drivers/block/floppy.o failed
> /lib/modules/2.5.3/kernel/drivers/block/floppy.o: insmod floppy failed
> 
>  and dmesg says
> 
> inserting floppy driver for 2.5.3
> Floppy drive(s): fd0 is 1.44M
> floppy0: Floppy io-port 0x03f0 in use
> 

A simple but nice hint by Pierre Rousselet suggested the I/O port
 is in use - I plain assumed it broke because I have been loading
 modular floppy for the last 36 months or so without specifying
 any parameters...

It turns out this is due to the new PnPBIOS kernel config option:

[asuardi@dolphin asuardi]$ grep PnPBIOS /proc/ioports 
03f0-03f1 : PnPBIOS PNP0c01
0600-067f : PnPBIOS PNP0c01
0680-06ff : PnPBIOS PNP0c01
  0800-083f : PnPBIOS PNP0c01
  0840-084f : PnPBIOS PNP0c01
0880-088f : PnPBIOS PNP0c01
f400-f4fe : PnPBIOS PNP0c01

But since modular floppy was working before without setting any
 ioport parameter I'm not entirely sure this is a "feature".


Thanks,

--alessandro

 "this machine will, will not communicate
   these thoughts and the strain I am under
  be a world child, form a circle before we all go under"
                         (Radiohead, "Street Spirit [fade out]")
