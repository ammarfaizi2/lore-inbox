Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbRBHKki>; Thu, 8 Feb 2001 05:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129297AbRBHKkS>; Thu, 8 Feb 2001 05:40:18 -0500
Received: from [202.212.27.182] ([202.212.27.182]:62727 "HELO antiopikon")
	by vger.kernel.org with SMTP id <S129033AbRBHKkO>;
	Thu, 8 Feb 2001 05:40:14 -0500
Date: Thu, 8 Feb 2001 19:41:56 +0900
From: Augustin Vidovic <vido@ldh.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eepro100.c, kernel 2.4.1
Message-ID: <20010208194156.A19161@ldh.org>
Reply-To: vido@ldh.org
In-Reply-To: <200102080742.f187gqK01498@devserv.devel.redhat.com> <Pine.LNX.4.30.0102072348550.29514-100000@age.cs.columbia.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0102072348550.29514-100000@age.cs.columbia.edu>; from ionut@cs.columbia.edu on Wed, Feb 07, 2001 at 11:59:05PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 07, 2001 at 11:59:05PM -0800, Ion Badulescu wrote:
> I don't think it fixes *this* bug. However, the bug workaround effectively
> reinitializes the chip, so it might serve as a generic 'reset and try
> again' kind of workaround. In that case, we might as well enable it
> unconditionally... but I don't see it as a good solution. It's a stop-gap 
> measure at best.
> 
> We need to find out what exactly happens. Until he tells us more about how 
> his boxes "were failing before", there really isn't much we can diagnose.


Ok, then let's go into a bit more details.

First, the part of the dmesg concerning the network interfaces:

eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
PCI: Found IRQ 5 for device 00:0c.0
PCI: The same IRQ used for device 00:0d.0
eth0: PCI device 8086:1229, 00:D0:B7:00:BE:00, IRQ 5.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
  Receiver lock-up workaround activated.
PCI: Found IRQ 5 for device 00:0d.0
PCI: The same IRQ used for device 00:0c.0
eth1: PCI device 8086:1229, 00:D0:B7:00:BE:01, IRQ 5.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
  Receiver lock-up workaround activated.


Please note: the "Receiver lock-up workaround activated." message is printed
now only since I applied my patch. Before, only the "enabling work-around." part
appeared, which is a bit tricky.

Second, attached to this mail is an mrtg graph png. Beware that the timeline goes
from right to left. This covers the past week. Every day the big peak is the
midnight "masturbation rush" when nearly everyone connects at the same time to
browse pr0n sites. You'll notice that the midnight peak is castrated suddenly
last friday. This accident happened 3 times the previous week. Kind of frustrating.

You can see a kind of sudden blackout which lasts about 3 hours, and then the
situation resumes to normality.

At the same time, the /var/log/messages receives thousands of messages from the
NET: subsystem.

A rather long research on the various mailing lists and newsgroups about networking
shows that this behavior is shown the same way on systems using a bugged Intel EtherExpress
Pro 100 network card.

Since the dmesg of the kernel tells about a work-around for such a bug, I was assuming
that the work around was activated, but I had a doubt and after looking at the source,
I discovered that it wasn't.

On saturday I patched the kernels, and since the midnight peaks are no longer
broken, there is no more desperate messages from the NET subsystem in the logs,
so maybe the problem has been fixed.

Now, as Ion says, maybe it is not the "receiver lock-up bug" itself which is
worked-around, frankly I don't know.


-- 
Augustin Vidovic                   http://www.vidovic.org/augustin/
"Nous sommes tous quelque chose de naissance, musicien ou assassin,
 mais il faut apprendre le maniement de la harpe ou du couteau."

--HcAYCG3uE/tztfnV
Content-Type: image/png
Content-Disposition: attachment; filename="mrtg.png"
Content-Transfer-Encoding: base64

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

--HcAYCG3uE/tztfnV--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
