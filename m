Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265447AbTFZIix (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 04:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265449AbTFZIix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 04:38:53 -0400
Received: from remt29.cluster1.charter.net ([209.225.8.39]:4493 "EHLO
	remt29.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S265447AbTFZIis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 04:38:48 -0400
Subject: Re: Problems with IDE on GA-7VAXP motherboard
From: Tim McGrath <misty-@charter.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Bernd Schubert <bernd-schubert@web.de>, andre@linux-ide.org,
       linux-kernel@vger.kernel.org, despair@adelphia.net
In-Reply-To: <20030620114030.GA11827@charter.net>
References: <200306191429.40523.bernd-schubert@web.de>
	 <20030619193118.GA32406@charter.net> <20030620075249.GA7833@charter.net>
	 <20030620105853.A16743@ucw.cz>  <20030620114030.GA11827@charter.net>
Content-Type: text/plain
Message-Id: <1056612565.27426.37.camel@roll>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 26 Jun 2003 03:29:25 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To my astonishment, everything is working now that I've had time to sort
out all the problems.

What I had to do: First off, the WD drive was causing a lot of strange
problems all by itself. Removing it from my computer made everything
work a lot better - both maxtors have their DMA modes correctly detected
and turned on at boot time, although I still manually prefer to turn
them on and do small amounts of tuning myself using hdparm once the
kernel starts.

Weird problems I've noticed include that the kernel and motherboard
disagree with the CHS attributes of my larger disk, a 120GB maxtor 7200
rpm drive. I'm pretty sure the kernel is right, mostly because using the
CHS settings the motherboard insists on cause braindamage in DOS,
including but not limited to the partition table being misdetected, the
files on the disk I copied there from linux to dos going missing, 6mb of
'bad sectors' when I try formatting the partition (Which goes away when 
I enter linux.) and when linux fscks the disk, it can find DOS's files
and believes the disk has enormous filesystem corruption. Oddly enough,
the 40GB maxtor hard disk I have (That incidentally originally came with
the ps2 linux kit) is correctly detected.

I haven't yet tried fiddling with the motherboard's settings for the
first hard disk - everything is still on auto, but I'm pretty sure there
is nothing I can do to manually set the CHS, which will be a problem if
I want to boot dos correctly. :( I've checked with maxtor's site, but
their maxblast program only works in windows according to it, which is a
pity since I don't have that installed here. I'll likely be forced to
use dosemu, although right now I can neither get sound nor VGA/SVGA to
work in it. *shrugs* I'm sure given enough time I can nail this too,
although I'd love suggestions. ... Hmm, just had a thought. Worst case,
I can make the 40GB disk have a dos partition and tell lilo to swap the
disk appearance for dos when I want to run dos. ... I might go with
that, actually.

Things that I've tried and haven't worked, include manually setting the
CHS in lilo's append command - obviously this only works for the linux
kernel. I've tried using grub as well, and it fixes the braindamage by
itself - problem is according to what little I've read of grub's
documentation there is no way to boot dos using it that I can see. If
I'm wrong, please inform me where the documentation for doing it is
located?

So. Problems with the Gigabyte GA-7VAXP motherboard I've found with
linux and it's F11 variant of the bios include:

Western Digital drives go absofuckinglutely insane in linux, which
actually isn't abnormal from what I've read - seems to be an issue more
with the disk being insane in the first place, and telling the BIOS it
can do things it not only can't do, but won't do, nor will the disk
complain when you try to do them. If you have one of these disks, the
only thing I can really say to you is to force dma OFF and experiment
with PIO mode. Mode 4 worked on my hard disk, but yours might be
different from mine, keep this in mind. Also note PIO mode is *slow* -
unbelievably slow compared to DMA. If you are stuck with one of these
disks, if you can return it and get your money back - do it. Otherwise,
you might consider getting a different manufacturers hard disk - from
what I've read using google.com about western digital disks and linux,
they just plain don't work with dma in linux, and the company seems to
have no plans on fixing this problem.

Large hard disks have their CHS values incorrectly detected.

Not including this, I've noted that the onboard fan that came with the
board which cools the agp chipset (at least I think it does - has a 'AGP
8x' sticker on it) is starting to wear out. I'm sure I can find a
replacement for it at radio shack, but I think it's a little silly for
it to be wearing out already.

I can't really recommend this board to other people, especially as I
haven't even tried enabling the other hard disk controller (which uses a
promise bios and can do ATA/RAID) and the problems I've had with this
motherboard were really absurd at some points. Also one of the things
you WON'T see on websites trying to sell you this board is that the bios
doesn't let you change important things - like memory timings, wether or
not dma should be totally turned OFF to hard disks, among other things.
I've not investigated yet, but I have a feeling I'm not going to be able
to manually set the CHS either, which would be a pity. None of these
things really makes a difference in linux, but on the other hand it
makes it a lot easier to track down problems if you can force the bios
to do the hard work for you when you're trying to figure out what's
wrong with the machine. Trying to fix problems on this motherboard makes
me feel half the time like I've got a hand tied behind my back. Another
thing is that the manual tends to be in engrish, so it's a little hard
to read at times. I won't be buying a gigabyte motherboard next time -
they're nice and slick, have pretty pictures, have a easy to use bios,
so long as you don't do things it doesn't understand, but although I
like having an 'autodetect' mode, I also like being able to manually set
the bios to do things. I had and still have this same type of problem
with my IBM PS/1 2155-78C(SL-B) which was built almost ten years ago -
it's silly to see people still building motherboards that don't have the
ability for the user to set settings manually.

Timothy C. McGrath

