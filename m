Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272991AbRINSRO>; Fri, 14 Sep 2001 14:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273369AbRINSRE>; Fri, 14 Sep 2001 14:17:04 -0400
Received: from w2.euroseek.net ([212.209.54.39]:48270 "EHLO w2.euroseek.net")
	by vger.kernel.org with ESMTP id <S272991AbRINSQq>;
	Fri, 14 Sep 2001 14:16:46 -0400
Date: Fri, 14 Sep 2001 20:17:05 +0200 (MET DST)
From: jurij@euroseek.com
Message-Id: <200109141817.UAA00924@w2.euroseek.net>
To: linux-kernel@vger.kernel.org
Subject: VIA IDE and SMP do not work together (2.2.19   ide patch)
X-Originating-IP: 130.237.25.178
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Recently we've been trying to install linux on a machine with 
Tyan S2507 Tiger 230 2-processor motherboard with a VIA Apollo
Pro 133A chipset (particularly, VIA IDE controller VT82C686B). 
We have tried 2.2.19 kernel with ide patch dated 05042001 from 
 
http://www.kernel.org/pub/linux/kernel/people/hedrick/ide-2.2.19/

It turns out, that when both the support for VIA82CXXXX chipset
and SMP are enabled, the machine refuses to boot, it hangs right
after the lines

hda: IC35L060AVER07-0, ATA DISK drive
hdb: SAMSUNG CD-ROM SC-152C, ATAPI CDROM drive
hdc: IC35L060AVER07-0, ATA DISK drive

(I am not quite sure, which line is actually the last, but I could
check that if needed)

However, if one disables either SMP or VIA82CXXXX chipset support
(keeping "Generic PCI IDE chipset support", "Generic PCI bus-master
DMA support" and "Use DMA by default when available"), then the
machine boots ok. In the latter case one still can achieve full
disk performance by issuing "hdparm -c1d1X69 /dev/hda", after that
"hdparm -t" reports around 32-33 MB/sec, however a message like
"ide0: Speed warnings UDMA 3/4/5 is not functional." appears in the
logs. Full dmesg from such a boot is available at

http://www.theophys.kth.se/~jurijus/dmesg

Another strange feature is a message 

"WARNING: unexpected IO-APIC, please mail to linux-smp@vger.kernel.org"

Thus, few questions arise:

1. Should one try some other version of kernel/patch/whatever to make
VIA82CXXXX and SMP work together?
2. Is it worth it? What's the advantage of using VIA82CXXXX chipset 
support? It seems like we are getting maximum disk performance even
without it, just with "Generic PCI IDE chipset support" provided by
the patch.
3. What's that "Speed warnings" message from hdparm?
4. Should one worry about the "unexpected IO-APIC"? It does not seem to
affect the SMP functionality, what does it actually mean?

Best regards and TIA,

Jurij.

P.S. Please CC the responses to me, because I'm not subscribed.

______________________________________________________
Get Your Free Email at http://mail.euroseek.com
