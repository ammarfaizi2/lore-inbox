Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317340AbSFLWeY>; Wed, 12 Jun 2002 18:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317343AbSFLWeY>; Wed, 12 Jun 2002 18:34:24 -0400
Received: from radium.jvb.tudelft.nl ([130.161.82.13]:5504 "EHLO
	radium.jvb.tudelft.nl") by vger.kernel.org with ESMTP
	id <S317340AbSFLWeV>; Wed, 12 Jun 2002 18:34:21 -0400
From: "Robbert Kouprie" <robbert@radium.jvb.tudelft.nl>
To: <linux-kernel@vger.kernel.org>
Subject: The buggy APIC of the Abit BP6
Date: Thu, 13 Jun 2002 00:33:52 +0200
Message-ID: <000201c21261$3a8fde70$020da8c0@nitemare>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

First of all, I know the Abit BP6 is infamous about its APIC, but I
would like to make sure there's absolutely no solution for this except
disabling the APIC.

I am experiencing problems for a long time now, which are always related
to the NIC in the box (probably due the being a device that generates a
lot of interrupts). The NIC has changed a couple of times (from 3com 10
Mbit to Intel eepro100 to 3Com PCI 3c905B Cyclone 100baseTx now), and
it's NOT placed in the infamous (I believe 3rd) PCI slot of the board
(mentioned in the manual). Also, /proc/interrups shows NO sharing with
another device. The running kernel is 2.4.19-pre8-ac5 SMP, though many
kernels have preceded it, with the same results.

The problems appear once in a while (in order of days/weeks). They are
always interluded with an "unexpected IRQ trap at vector 7d", and then
followed within a minute by chaos in the network driver. I found the
message of the 3com driver to be the most clear one, see the snippet
below. When I boot with "noapic", the problems go away.

Is there a solution that does not require disabling the APIC as a whole
or is this just too flaky hardware?

Thanks in advance,
- Robbert Kouprie

PS. Please CC me in answers, as I'm not on the list.

Jun 12 23:47:56 radium kernel: unexpected IRQ trap at vector 7d
Jun 12 23:47:56 radium kernel: unexpected IRQ trap at vector 7d
Jun 12 23:48:29 radium kernel: NETDEV WATCHDOG: eth0: transmit timed out
Jun 12 23:48:29 radium kernel: eth0: transmit timed out, tx_status 00
status e681.
Jun 12 23:48:29 radium kernel:   diagnostics: net 0cf2 media 8880 dma
0000003a fifo 8800
Jun 12 23:48:29 radium kernel: eth0: Interrupt posted but not delivered
-- IRQ blocked by another device?
Jun 12 23:48:29 radium kernel:   Flags; bus-master 1, dirty 16264012(12)
current 16264012(12)
Jun 12 23:48:29 radium kernel:   Transmit list 00000000 vs. c133e500.
Jun 12 23:48:29 radium kernel:   0: @c133e200  length 800005cc status
000105cc
Jun 12 23:48:29 radium kernel:   1: @c133e240  length 800005cc status
000105cc
Jun 12 23:48:29 radium kernel:   2: @c133e280  length 800005cc status
000105cc
Jun 12 23:48:29 radium kernel:   3: @c133e2c0  length 800005cc status
000105cc
Jun 12 23:48:29 radium kernel:   4: @c133e300  length 8000001e status
0001001e
Jun 12 23:48:29 radium kernel:   5: @c133e340  length 800005cc status
000105cc
Jun 12 23:48:29 radium kernel:   6: @c133e380  length 80000045 status
00010045
Jun 12 23:48:29 radium kernel:   7: @c133e3c0  length 80000045 status
00010045
Jun 12 23:48:29 radium kernel:   8: @c133e400  length 80000045 status
00010045
Jun 12 23:48:29 radium kernel:   9: @c133e440  length 80000045 status
00010045
Jun 12 23:48:29 radium kernel:   10: @c133e480  length 80000045 status
80010045
Jun 12 23:48:29 radium kernel:   11: @c133e4c0  length 800005cc status
800105cc
Jun 12 23:48:29 radium kernel:   12: @c133e500  length 80000042 status
00010042
Jun 12 23:48:29 radium kernel:   13: @c133e540  length 80000042 status
00010042
Jun 12 23:48:29 radium kernel:   14: @c133e580  length 80000042 status
00010042
Jun 12 23:48:29 radium kernel:   15: @c133e5c0  length 80000042 status
00010042
Jun 12 23:48:29 radium kernel: eth0: Resetting the Tx ring pointer.
Jun 12 23:48:29 radium kernel: NETDEV WATCHDOG: eth0: transmit timed out


