Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312375AbSDJBvM>; Tue, 9 Apr 2002 21:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312380AbSDJBvL>; Tue, 9 Apr 2002 21:51:11 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:54776
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S312375AbSDJBvL>; Tue, 9 Apr 2002 21:51:11 -0400
Date: Tue, 9 Apr 2002 18:53:11 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        "David S. Miller" <davem@redhat.com>, Andrew Morton <akpm@zip.com.au>
Subject: [BUG] DEADLOCK when removing a bridge on 2.4.19-pre6
Message-ID: <20020410015311.GA31952@matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	"David S. Miller" <davem@redhat.com>,
	Andrew Morton <akpm@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

*read below for a problem report against the tulip network driver[1]

It looks like the bridging feature of the kernel has changed between 2.4.17
and 18.

I have a machine running 2.4.16 running as a bride without problem.  While
testing the network cards for another bridge I had to restart.
Unfortunately, it didn't complete.  Nothing would respond except for sysrq.
I was able to sync, unmount, and reboot successfully.

Debian does this for you automatically, but if you do it manually it does
the same thing.

o Setup a bridge like normal
o start it up
o ifconfig br0 down
o brctl delbr br0
*boom*

2.4.16,17 work just fine, but 2.4.18 does not.  Looking through the
changelog, 2.4.18-pre4, or 5 look suspect.  Also, it is not fixed in
2.4.19-pre6.  I can test the 2.4.18-pre kernels if you'd like, just let me
know.

[1] Also several times I was able to get my tulip network card to stop
forwarding packets after a soft-reboot from the lockup mentioned above.  I
was able to reproduce this in 2.4.17, 2.4.18, 2.4.19-pre3-ac4 (possibly
2.4.19-pre5-ac3 though didn't check to make sure but I used it several times
during my testing), and 2.4.19-pre6.  None of the other network cards in
this machine did this (3c509-isa, pcnet32-pci, eepro100-pci)

I don't have a serial cable ATM but I could buy one in a few days if a
ksymoopsed sysrq-t would help.

00:00.0 Host bridge: Intel Corp. 430HX - 82439HX TXC [Triton II] (rev 03)
00:01.0 ISA bridge: Intel Corp. 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
00:01.1 IDE interface: Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II]
00:01.2 USB Controller: Intel Corp. 82371SB PIIX3 USB [Natoma/Triton II] (rev 01)
00:06.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
00:07.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 02)
00:08.0 VGA compatible controller: S3 Inc. 86c764/765 [Trio32/64/64V+] (rev 54)
00:0b.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet LANCE] (rev 16)

Mike
