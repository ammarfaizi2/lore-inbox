Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273333AbRJ2NFB>; Mon, 29 Oct 2001 08:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273385AbRJ2NEk>; Mon, 29 Oct 2001 08:04:40 -0500
Received: from nydalah028.sn.umu.se ([130.239.118.227]:23427 "EHLO
	x-files.giron.wox.org") by vger.kernel.org with ESMTP
	id <S273333AbRJ2NEh>; Mon, 29 Oct 2001 08:04:37 -0500
Message-ID: <04b801c1607a$947dbef0$0201a8c0@HOMER>
From: "Martin Eriksson" <nitrax@giron.wox.org>
To: <linux-kernel@vger.kernel.org>
Subject: via-rhine and MMIO
Date: Mon, 29 Oct 2001 14:06:53 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have done some changes to the via-rhine driver in 2.4.13 to be able to run
with MMIO. I know it isn't really needed but I do it mainly for fun &
learning.

The most important change was to enable memory-mapped mode within the rhine
chip by a standard port-io call. I have got it all to work, and it works
under stress test too, but there is a section in the code that I wonder
about:

(drivers/net/via-rhine.c)
...
/* Reload the station address from the EEPROM. */
writeb(0x20, ioaddr + MACRegEEcsr);
/* Typically 2 cycles to reload. */
for (i = 0; i < 150; i++)
    if (! (readb(ioaddr + MACRegEEcsr) & 0x20))
        break;
...

If I run this code when I'm using MMIO, I get a hardware adress of
"ff:ff:ff:ff:ff:ff" instead of the right one (and everything craps up). But
when I comment out this part all is fine. So what's it needed for anyway?

_____________________________________________________
|  Martin Eriksson <nitrax@giron.wox.org>
|  MSc CSE student, department of Computing Science
|  Umeå University, Sweden


