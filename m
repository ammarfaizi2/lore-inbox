Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132526AbRDKIMb>; Wed, 11 Apr 2001 04:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132521AbRDKIMV>; Wed, 11 Apr 2001 04:12:21 -0400
Received: from die-macht.oph.RWTH-Aachen.DE ([137.226.147.190]:23080 "EHLO
	die-macht") by vger.kernel.org with ESMTP id <S132526AbRDKIMK>;
	Wed, 11 Apr 2001 04:12:10 -0400
Message-ID: <3AD411D6.1A8774A8@die-macht.oph.rwth-aachen.de>
Date: Wed, 11 Apr 2001 10:12:06 +0200
From: Stefan Becker <stefan@die-macht.oph.rwth-aachen.de>
Reply-To: stefan@oph.rwth-aachen.de
Organization: OPH
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 8139too.c and 2.4.4-pre1 kernel burp
In-Reply-To: <3AD118F4.3050507@xmission.com> <3AD11A13.6E52A515@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Jeff Garzik wrote:
> How often does this occur?  A lot, or just once or twice?

For example, after getting ~3MB of package information form
ftp.debian.org
I find this in /var/log/syslog:

Apr 11 09:56:26 unknown kernel: eth0: Too much work at interrupt,
IntrStatus=0x0001. 
Apr 11 09:57:24 unknown kernel: eth0: Too much work at interrupt,
IntrStatus=0x0001. 
Apr 11 09:58:31 unknown last message repeated 7 times 
Apr 11 09:59:35 unknown last message repeated 5 times 
Apr 11 09:59:58 unknown kernel: eth0: Too much work at interrupt,
IntrStatus=0x0001.

This is 2.4.4pre1. 

[root@unknown:~ ] lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
(rev 03)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 40)
00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:04.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
(rev 40)
00:04.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio
Controller (rev 50)
00:0b.0 Multimedia video controller: Brooktree Corporation Bt878 (rev
02)
00:0b.1 Multimedia controller: Brooktree Corporation Bt878 (rev 02)
00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139
(rev 10)
00:11.0 Unknown mass storage controller: Promise Technology, Inc. 20265
(rev 02)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP
(rev 03)

[root@unknown:~ ] cat /proc/interrupts
           CPU0
  0:   17760753          XT-PIC  timer
  1:      37659          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:    1991785          XT-PIC  eth0
  4:       1623          XT-PIC  via82cxxx
  8:          1          XT-PIC  rtc
 10:       2066          XT-PIC  bttv
 12:    1104400          XT-PIC  PS/2 Mouse
 14:     291752          XT-PIC  ide0
 15:          4          XT-PIC  ide1
NMI:          0
ERR:          0

[root@unknown:~ ] cat /usr/src/linux/.config|grep 8139
CONFIG_8139TOO=y
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set

[root@unknown:~ ] mii-tool -v
eth0: negotiated 100baseTx-FD, link ok
  product info: vendor 00:00:00, model 0 rev 0
  basic mode:   autonegotiation enabled
  basic status: autonegotiation complete, link ok
  capabilities: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
  advertising:  100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
  link partner: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD

Greetings,
Stefan Becker
