Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130812AbRACMMc>; Wed, 3 Jan 2001 07:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131306AbRACMMW>; Wed, 3 Jan 2001 07:12:22 -0500
Received: from smtp1.mail.yahoo.com ([128.11.69.60]:41489 "HELO
	smtp1.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S130812AbRACMMI>; Wed, 3 Jan 2001 07:12:08 -0500
X-Apparently-From: <quintaq@yahoo.co.uk>
From: quintaq@yahoo.co.uk
To: linux-kernel@vger.kernel.org
Subject: Fw: UDMA on 815e chipset
X-Mailer: Sylpheed version 0.4.9 (GTK+ 1.2.8; Linux 2.2.16; i686)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20010103121218Z130812-439+8159@vger.kernel.org>
Date: Wed, 3 Jan 2001 07:12:08 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings Gurus,

Have I found a tiny, perhaps irrelevant, bug ?

I have recently installed SuSE 7.0 with the supplied 2.2.16 kernel on my
homebuilt dual-boot machine, which has an 815e chipset (Asus CuSL2 board), plus
30GB IBM Deskstar 75GXP HDD (hda).  As I understand it both of these support UDMA modes4 and 5 / ATA 66 and 100.

The bios will not allow UDMA mode 5 to be set unless the correct cable is
detected.  At boot-time under Windows the bios reports that UDMA Mode 5
has been set.

I decided to tweak the HDD performance under linux.  I began with ATA 33 by adding the following to my boot.local : /sbin/hdparm -c1 -m16 -d1 -X66 /dev/hda

This line causes no problems and hparm reports UDMA mode 2 set with cache reads at 139.13 MB/sec and disk reads at 12.87 MB/sec.

I then try increasing to ATA 66 by substituting -X68 for X66.

At linux boot-time I now see that XF68 has been set, but then I see the error
message : "ide0: speed warning UDMA /3/4/5 is not functional".  As I understand it, this means that the kernel has tested for the correct cable, but sees a negative response.

Even though I see the error message, I think that UDMA 4 / ATA 66 must actually have been set, because hdparm now reports cache reads at 143.82 MB/sec and disk reads at 15.76 MB/Ssec. hdparm also reports that the HDD is in UDMA mode 4.

Much the same thing happens if I try for ATA 100 / UDMA 5 by substituting -X69.  hdparm now reports that the drive is in UDMA mode 5, but I do not see any improvement in transfer speeds, from which I assume that my kernel cannot go higher than ATA 66.

I assume (unwisely ?), from all this that for some reason the kernel's
check for the correct UDMA cabling on this chipset / motherboard is
failing, but that it is actually succeding in setting UDMA mode 5 and is happily running at ATA 66. Hence my "possibly irrelevant" bug report.

I have carried out all of the tests I mention above with a substitute cable, but the results are the same. I have not (yet) suffered any loss of data or other problems by ignoring the speed warning.

I am not subscribed to this list (perhaps I have revealed enough ignorance
above to explain why not), but I do not know where else I should report
the "problem", or where else I might get some feedback.  If anyone can be
bothered to respond, then I would be very grateful if you could CC the reply
to me.

Thanks

Geoff

"Scattered we were when the long night was breaking:
But in bright morning converse again"

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
