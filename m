Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278949AbRJ3IgP>; Tue, 30 Oct 2001 03:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278961AbRJ3IgG>; Tue, 30 Oct 2001 03:36:06 -0500
Received: from baana-bisnes1-213-139-168-106.suomi.net ([213.139.168.106]:7435
	"EHLO mail.softers.net") by vger.kernel.org with ESMTP
	id <S278949AbRJ3Ifs>; Tue, 30 Oct 2001 03:35:48 -0500
Message-ID: <3BDE6699.86FFF44F@softers.net>
Date: Tue, 30 Oct 2001 10:36:41 +0200
From: Jarmo =?iso-8859-1?Q?J=E4rvenp=E4=E4?= 
	<Jarmo.Jarvenpaa@softers.net>
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Intel EEPro 100 with kernel drivers
In-Reply-To: <20011029021339.B23985@stud.ntnu.no>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Langås wrote:
> 
> Hi!
> 
> We've got a lot of machines with the eepro 100 from intel onboard, and when
> we try to stress-test the network (running bonnie++ on a nfs-shared
> directory on a machine), the network-card says "eth0: Card reports no
> resources" to dmesg, and then the "line" appear dead for some time (one
> minutte or more). What can be done to remove this error? NFS timesout with
> this error (obviously)...
> 
> --
> Thomas

We have almost the same problem, except it totally locks up the
computer. Light network utilization is ok, but heavy traffic does the
effect.
No syslog reports, even keyboards leds won't light up (numlock, etc).
Rebooting helps for a while. We had to install another network card for
a workaround. I've tried kernels 2.4.10 and 2.4.12.

The network card is integrated at the motherboard.

dmesg:
----
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
<saw@saw.sw.com.sg> and others
PCI: Found IRQ 11 for device 01:08.0
eth1: Intel Corporation 82801BA(M) Ethernet, 00:03:47:A2:F8:81, IRQ 11.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
-----
[obelix:/root]> eepro100-diag -ee -f -vv
eepro100-diag.c:v2.05 6/13/2001 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a Intel i82562 Pro/100 V adapter at 0xde80.
i82557 chip registers at 0xde80:
  00000000 00000000 00000000 00080002 183f0000 00000000
  No interrupt sources are pending.
   The transmit unit state is 'Idle'.
   The receive unit state is 'Idle'.
  This status is unusual for an activated interface.
EEPROM contents, size 64x16:
    00: 0300 a247 81f8 1a03 0000 0201 4701 0000
  0x08: 0000 0000 49b0 3013 8086 007f ffff ffff
  0x10: ffff ffff ffff ffff ffff ffff ffff ffff
  0x18: ffff ffff ffff ffff ffff ffff ffff ffff
  0x20: ffff ffff ffff ffff ffff ffff ffff ffff
  0x28: ffff ffff ffff ffff ffff ffff ffff ffff
  0x30: 0000 ffff ffff ffff ffff ffff ffff ffff
  0x38: ffff ffff ffff 0000 ffff ffff ffff 35dd
 The EEPROM checksum is correct.
Intel EtherExpress Pro 10/100 EEPROM contents:
  Station address 00:03:47:A2:F8:81.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
 MII PHY #1 transceiver registers:
  3100 7809 02a8 0330 05e1 0000 0000 0000
  0000 0000 0000 0000 0000 0000 0000 0000
  2004 0000 0000 0000 0000 0000 0000 0000
  0000 0000 0ce0 0000 0010 0000 0000 0000.
[obelix:/root]>
----
Oh, eepro100-diag reported 'Sleep mode is enabled', which could do
something like this -> I disabled it, but no positive effect.


Any similar problems?


Thanks,
Jarmo
