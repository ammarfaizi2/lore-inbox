Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263174AbRFRAAD>; Sun, 17 Jun 2001 20:00:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263167AbRFQX7x>; Sun, 17 Jun 2001 19:59:53 -0400
Received: from hssx-sktn-167-47.sasknet.sk.ca ([142.165.167.47]:62994 "HELO
	mail.thock.com") by vger.kernel.org with SMTP id <S263165AbRFQX7k>;
	Sun, 17 Jun 2001 19:59:40 -0400
Message-ID: <3B2D446A.5C2AEEAC@bigfoot.com>
Date: Sun, 17 Jun 2001 17:59:38 -0600
From: Dylan Griffiths <Dylan_G@bigfoot.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Still some problems with UHCI driver in 2.4.5 on VIA chipsets
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another thing I was happy to find working better in 2.4.5, was USB.  I had
just dumped off ~70 high res pics (which would've taken forever via the
usual RS232 method), and was deleting the last pics when gphoto froze.  The
dmesg log has the same messages it had before when I experimented with 2.4.1
and 2.2.19.  I'm not sure if it was harder to trigger the problem now
because of improvements to 2.4.5, or if it was because the proc is 1.1Ghz
(affecting a possible race condition).

The USB controller:
  Bus  0, device   4, function  2:
    USB Controller: VIA Technologies, Inc. UHCI USB (rev 22).
      IRQ 5.
      Master Capable.  Latency=32.  
      I/O at 0xd400 [0xd41f].
  Bus  0, device   4, function  3:
    USB Controller: VIA Technologies, Inc. UHCI USB (#2) (rev 22).
      IRQ 5.
      Master Capable.  Latency=32.  
      I/O at 0xd000 [0xd01f].


dmesg log:
usb.c: registered new driver dc2xx
dc2xx.c: v1.0.0 David Brownell, <dbrownell@users.sourceforge.net>
dc2xx.c: USB Camera Driver for Kodak DC-2xx series cameras
PCI: Found IRQ 5 for device 00:04.2
PCI: The same IRQ used for device 00:04.3
uhci.c: USB UHCI at I/O 0xd400, IRQ 5
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 5 for device 00:04.3
PCI: The same IRQ used for device 00:04.2
uhci.c: USB UHCI at I/O 0xd000, IRQ 5
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
uhci.c:  Linus Torvalds, Johannes Erdfelt, Randy Dunlap, Georg Acher, Deti
Fliegl, Thomas Sailer, Roman Weissgaerber
uhci.c: USB Universal Host Controller Interface driver
hub.c: USB new device connect on bus1/2, assigned device number 2
dc2xx.c: USB Camera #0 connected, major/minor 180/80
** here is where it froze **
usb_control/bulk_msg: timeout
usb_control/bulk_msg: timeout
usb_control/bulk_msg: timeout
usb_control/bulk_msg: timeout
usb.c: USB disconnect on device 2
usb_control/bulk_msg: timeout
usb_control/bulk_msg: timeout
usb_control/bulk_msg: timeout
usb_control/bulk_msg: timeout
usb_control/bulk_msg: timeout
usb_control/bulk_msg: timeout
usb_control/bulk_msg: timeout
usb_control/bulk_msg: timeout
usb_control/bulk_msg: timeout
usb_control/bulk_msg: timeout
usb_control/bulk_msg: timeout
usb_control/bulk_msg: timeout
usb_control/bulk_msg: timeout
** rmmod the drivers **
dc2xx.c: USB Camera #0 disconnected
usb.c: USB disconnect on device 1
usb.c: USB bus 1 deregistered
usb.c: USB disconnect on device 1
usb.c: USB bus 2 deregistered
usb.c: deregistering driver dc2xx
** usbcore refuses to rmmod because its ref cnt won't decrement, this also
affected it before I had the usb_control/bulk_msg timeout/loop issues **

--
    www.kuro5hin.org -- technology and culture, from the trenches.
