Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277396AbRJOLXr>; Mon, 15 Oct 2001 07:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277395AbRJOLXi>; Mon, 15 Oct 2001 07:23:38 -0400
Received: from mailhost.teleline.es ([195.235.113.141]:22588 "EHLO
	tsmtp3.ldap.isp") by vger.kernel.org with ESMTP id <S277396AbRJOLXc>;
	Mon, 15 Oct 2001 07:23:32 -0400
Message-Id: <5.1.0.14.0.20011015122840.03169d50@pop3.terra.es>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 15 Oct 2001 13:23:57 +0200
To: linux-kernel@vger.kernel.org
From: Vadim <vadim_t@teleline.es>
Subject: Linux hangs when DMA is used
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary="==---=-==-=--=--=----=---==-=-=-====-=---==-----";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==---=-==-=--=--=----=---==-=-=-====-=---==-----
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed

This is one of the most puzzling issues I've ever seen. I'm posting here 
because since Win98 works (that is, doesn't crash more than usual), and DMA 
is enabled...
It is a recently installed Mandrake 8.0 system, and I'm using kernel 
2.4.12. I installed it on a P166MMX,  because it hangs during the install 
on this one. Then I moved the hard disk.

The oddest thing is that this used to work! When I upgraded my computer, 
Linux worked just fine (I think the last kernel I was running was 2.4.9). 
Then I unfortunately lost my partition due to the damned ATI Rage Pro 
Turbo, which made the computer crash all the time (windows too). The new 
card works fine. Win98 works, but Linux and Win2K hang during the 
installation. I tried the old S3 Virge, but that doesn't change anything...

My hardware:
Duron 850
Transcend AKT4/B (With the VIA 686B chip)
256MB RAM
RealTek RTL8139
Sound Blaster Live! Value
ATI Rage IIC AGP

Here are some things that happened on my screen after booting the system:
Found IRQ 11 for device 00:07:3  (USB)
Sharing IRQ 11 with 00:07:2  (USB)
Sharing IRQ 11 with 00:14:0  (NIC - RealTek RTL8139)
Spurious 8259A interrupt: IRQ7 (LPT1, the printer is off)
reiserfs: checking transaction log (device 03:01)
Warning, log replay starting on readonly filesystem

There is some disk access, then it hangs. When I pressed a key the monitor 
switched to standby mode!
Reboot.

NET4: Unix domain sockets 1.0/SMP for Linux NET4.0
ds: no socket drivers loaded!

It hangs with the disk light on.
Reboot. This time I take out the SBLive and the network card, and disable 
IRQ for USB and video card. This seems to make it behave better, but the 
spurious interrupt message still happens on every boot

ds: no socket drivers loaded!
reiserfs: checking transaction log (device 03:01)
Warning, log replay starting on readonly filesystem

Again, it hangs. I turn the system off completely, turn it on and the 
monitor is in standby and the computer doesn't boot!
I turn off the system again, wait longer, it works.

  I try hdparm and disable absolutely everything (DMA, readahead, etc)
everything seems to work just fine. hdparm -Tt says 2.3mb/s, yuck.

I enable 32 bit access, test again, it works.
I enable DMA, test, and it hangs.

The odd thing is that for the test I used "find / > /dev/null" and "grep 
'spurious' -r *" (in the kernel source) and it actually worked for a while.
I see find showing folders, and grep working just fine, the disk is busy... 
and then suddenly it hangs. Somehow, when it boots, even if DMA is used it 
seems to work. I can easily chdir/ls or read howtos without problems, but 
as soon as I try something that uses the disk a lot, like find, grep, or 
hdparm -Tt, it hangs.


--==---=-==-=--=--=----=---==-=-=-====-=---==-----
Content-Type: application/pgp-signature

-----BEGIN PGP MESSAGE-----
Version: PGPfreeware 7.0.3 for non-commercial use <http://www.pgp.com>

iQA/AwUBO8rHTSyPo7V0lSpHEQJJ2gCZAaCEf15R3vDXLCjlY+gb9xtsX/AAn2Wz
E2r45KZvcLDU5EdxMUet7pkS
=p+SZ
-----END PGP MESSAGE-----

--==---=-==-=--=--=----=---==-=-=-====-=---==-------

