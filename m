Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269964AbRHEOYJ>; Sun, 5 Aug 2001 10:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269965AbRHEOX7>; Sun, 5 Aug 2001 10:23:59 -0400
Received: from pD9504018.dip.t-dialin.net ([217.80.64.24]:34033 "HELO
	ozean.schottelius.org") by vger.kernel.org with SMTP
	id <S269964AbRHEOXs>; Sun, 5 Aug 2001 10:23:48 -0400
Message-ID: <3B6D56C5.1AA10E84@pcsystems.de>
Date: Sun, 05 Aug 2001 16:23:01 +0200
From: Nico Schottelius <nicos@pcsystems.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 3c509: broken(verified)
In-Reply-To: <E15TNpL-0007rV-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> > The driver for the 3c509 of 2.4.7 is broken:
> > It is impossible to set the transmitter type.
> > modprobe 3c509 xcvr=X, where X is
> > 0,1,2,3,4 doesn't make a difference.
>
> Looking at the code it should set the type fine. The only bug I can see is
> that it will report the default type set in the eeprom not the type you
> asked.
>
> If thats the case (please check) then its trivial to fix

While I tried to setup the driver I always let one machine
outside ping it.

It is not just the message.

ozean:~ # modprobe 3c509 ; ifconfig eth1 192.168.4.17 up

eth1: 3c5x9 at 0x360, BNC port, address  00 60 97 39 43 b9, IRQ 5.
3c509.c:1.18 12Mar2001 becker@scyld.com
http://www.scyld.com/network/3c509.html

- the light on the hub keeps off, no ping answer

ozean:~ # ifconfig eth1 down ; rmmod 3c509;

ozean:~ # modprobe 3c509 xcvr=4 debug=4

## xcvr=4 is TP (found on scyld.com/network/3c509.html)


3c509.c:1.18 12Mar2001 becker@scyld.com
http://www.scyld.com/network/3c509.html
eth1: Setting Rx mode to 1 addresses.
  3c509 EEPROM word 7 0x6d50.
  3c509 EEPROM word 0 0x0060.
  3c509 EEPROM word 1 0x9739.
  3c509 EEPROM word 2 0x43b9.
  3c509 EEPROM word 8 0xc096.
  3c509 EEPROM word 9 0x5000.

eth1: 3c5x9 at 0x360, BNC port, address  00 60 97 39 43 b9, IRQ 5.
3c509.c:1.18 12Mar2001 becker@scyld.com
http://www.scyld.com/network/3c509.html
  3c509 EEPROM word 7 0xffff.
eth1: Opening, IRQ 5     status@36e 0000.
eth1: Opened 3c509  IRQ 5  status 2000.
eth1: Setting Rx mode to 1 addresses.

ozean:~ # ifconfig eth1 192.168.4.17 up

- ping does not work, no light is seen


That's it! The cable & the hub are okay.


Nico


