Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130481AbQLIKOx>; Sat, 9 Dec 2000 05:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131034AbQLIKOn>; Sat, 9 Dec 2000 05:14:43 -0500
Received: from smtp4.ihug.co.nz ([203.109.252.5]:36359 "EHLO smtp4.ihug.co.nz")
	by vger.kernel.org with ESMTP id <S130481AbQLIKO2>;
	Sat, 9 Dec 2000 05:14:28 -0500
Message-ID: <3A31FEC9.B824E695@ihug.co.nz>
Date: Sat, 09 Dec 2000 22:43:37 +1300
From: Gerard Sharp <gsharp@ihug.co.nz>
Reply-To: gsharp@ihug.co.nz
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test11-ac4-smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: HPT366 + SMP = slight corruption in 2.3.99 - 2.4.0-11
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again

I have performed some tests; and reached the following conclusions
regarding this matter.
As always, UniProcessor kernels have no problems; only SMP ones.

kernel 2.2.17 + idepatches, hde (i.e., on the HPT366) at UDMA(66):
I was unable to cause any corruption despite my best efforts

kernel 2.4.0-test11-ac4, hde at UDMA(66):
Corrupted first test.

kernel 2.4.0-test11-ac4, hda at UDMA(33):
I was unable to cause any corruption despite my best efforts

kernel 2.4.0-test11-ac4, hde at UDMA(33) [i.e., using a 40 way cable]:
I was unable to cause any corruption despite my best efforts

Or, in table form:
Kernel  Controller  Mode    Status:
2.2.17	HPT366      UDMA66  WorksForMe<tm>
2.4.0   PIIX4       UDMA33  WorksForMe<tm>
2.4.0   HPT366      UDMA33  WorksForMe<tm>
2.4.0   HPT366      UDMA66  Corruption


Further details:
The drive in question is a Seagate Barracuda 7200 rpm "ata66" 13.6gig
drive
hdparm v3.6 identifies it as

/dev/hde

 Model=ST313620A, FwRev=3.07, SerialNo=7BW0QXYA
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=0(?), BuffSize=512kB, MaxMultSect=16, MultSect=off
 DblWordIO=no, OldPIO=2, DMA=yes, OldDMA=2
 CurCHS=65535/1/63, CurSects=-4128706, LBA=yes, LBAsects=26692776
 tDMA={min:120,rec:120}, DMA modes: mword0 mword1 mword2 
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, PIO modes: mode3 mode4 
 UDMA modes: mode0 mode1 *mode2 mode3 mode4 

The system is the infamous BP6, with the latest bios and two celeron 466
cpu's, clocked at 7 * 66 MHz (=466).

The "tests" I used were crude but effective;
cp -aR /usr/src/linux /usr/src/testing/one
diff -dur /usr/src/linux /usr/src/testing/one
looking for any differences (of which there should be zero)

This was repeated for a system which was very unloaded (i.e., just
booted);
then with various other tasks running - X, Netscape, a simple program
that mallocs 100 Mb. Since the machine has 128 Mb, this program should
force the computer to the edge of swap - which I have previously noted
to alter the rate of corruption.
Also two simultaneous cp's were run to further load the hdd system :)


As an interesting observation; Linux 2.4 is more "aggressive" about swap
than 2.2; 2.2 leaves all of the 100 Mb program resident, and uses ~18 Mb
of cache. 2.4 swaps some of it out, to offer more cache. 2.4 is also
more "usable" with the HDD thrashing than 2.2; response times are
snappier, etc. etc.
Well done.


Since there doesn't appear to be any corruption in UDMA66 mode in 2.2, I
don't feel the hardware to be totally broken; instead I feel the 2.4
driver is not-quite-right. I will remain at UDMA33 on the HPT controller
in 2.4 for the time being; although I am amiable to testing UDMA66 some
more :)


Goodnight And Happy Hacking
Gerard Sharp
Two Penguins at 1024x768
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
