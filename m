Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271994AbRH2P15>; Wed, 29 Aug 2001 11:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271995AbRH2P1s>; Wed, 29 Aug 2001 11:27:48 -0400
Received: from erm1.u-strasbg.fr ([130.79.74.61]:32263 "HELO erm1.u-strasbg.fr")
	by vger.kernel.org with SMTP id <S271994AbRH2P1j>;
	Wed, 29 Aug 2001 11:27:39 -0400
Date: Wed, 29 Aug 2001 17:39:17 +0200
To: linux-kernel@vger.kernel.org
Subject: setpci without any effect?
Message-ID: <20010829173917.A3012@erm1.u-strasbg.fr>
Mail-Followup-To: bboett@erm1.u-strasbg.fr,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
From: bboett@erm1.u-strasbg.fr (Bruno Boettcher)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello!
the bttv card has again problems, complaining about irq probs:
cat /proc/interrupts 
           CPU0       
  0:      28068          XT-PIC  timer
  1:        620          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:      17567          XT-PIC  nvidia
  8:          1          XT-PIC  rtc
  9:       2827          XT-PIC  es1371, bttv
 10:       1372          XT-PIC  eth0
 11:      13513          XT-PIC  aic7xxx
 12:       4276          XT-PIC  PS/2 Mouse
 14:        897          XT-PIC  ide0
even if the bttv shares interrupt with the sound card and notthe scsi
card i get the following:

Aug 29 17:23:23 kalman kernel: bttv0: irq: OCERR risc_count=1eee1030
Aug 29 17:23:23 kalman kernel: bttv0: aiee: error loops
Aug 29 17:23:38 kalman kernel: bttv0: resetting chip
Aug 29 17:23:38 kalman kernel: bttv0: PLL: 28636363 => 35468950 ... ok
Aug 29 17:23:38 kalman kernel: scsi0: PCI error Interrupt at seqaddr = 0x8
Aug 29 17:23:38 kalman kernel: scsi0: Data Parity Error Detected during address or write data phase
Aug 29 17:23:38 kalman kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
Aug 29 17:23:38 kalman kernel: scsi0: Data Parity Error Detected during addre


i tryed the following:
setpci -v -s 00:0b.* INTERRUPT_LINE
00:0b.1:3c = 09
00:0b.0:3c = 09

setpci -v -s 00:0b.* INTERRUPT_LINE=7
00:0b.1:3c = 07
00:0b.0:3c = 07

but lspci persists in thinking that the IRQ is 9 and from the
functionality it appears that nothing changed... so where did i made the
error??

-- 
ciao bboett
==============================================================
bboett@earthling.net
http://inforezo.u-strasbg.fr/~bboett http://erm1.u-strasbg.fr/~bboett
===============================================================
the total amount of intelligence on earth is constant.
human population is growing....
