Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269295AbRGaNmc>; Tue, 31 Jul 2001 09:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269292AbRGaNmZ>; Tue, 31 Jul 2001 09:42:25 -0400
Received: from fm4.freemail.hu ([194.38.105.14]:25862 "HELO fm4.freemail.hu")
	by vger.kernel.org with SMTP id <S269296AbRGaNmL>;
	Tue, 31 Jul 2001 09:42:11 -0400
Date: Tue, 31 Jul 2001 15:42:04 +0200 (CEST)
From: Boszormenyi Zoltan <zboszor@freemail.hu>
Subject: used-once really works?
To: linux-kernel@vger.kernel.org
Message-ID: <freemail.20010631154204.52946@fm5.freemail.hu>
X-Originating-IP: [212.40.102.60]
X-HTTP-User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.8-pre3 i686; en-US; rv:0.9.1) Gecko/20010620
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi!

I freshly compiled 2.4.8-pre3 and I thought
I give it a try.

The machine is a dual P3 with 384MB memory and one
15 GB IDE disk, distro is RedHat 6.2 with official
upgrades and e2fsprogs-1.22 and GNOME-1.4.

In X, I had mozilla, and 3 gnome-terminals running.
In one terminal, I run 'top', in one other
'dd if=/dev/hda of=/dev/null bs=4096'.

'top' showed that the system buffer cache filled up
and soon the machine started swapping. It seemed to swap
out mozilla and parts of the X server. Otherwise the
system remained responsive.

I tried other more experimental patches, too:
o_direct-10 and blkdev-pagecache-5. There was a one-liner
reject in mm/vmscan.c after applying blkdev-pagecache-5.

I fixed this and booted this new kernel, I tried the same.
This time the page cache started to fill up but
no swapping occured. Hm...

During 'dd' starting new (I mean: not yet in the page cache)
programs were slow as hell. Starting them second time was
fast as expected. I tried glade with a large project file,
loading it / looking into directories was slow at first,
was fast second time. Since ext2 directories are in the
page cache, this is perfectly understandable.

So it seems that the used-once patch works.
The only comments is that I didn't expect it
to start swapping with the stock pre3.
I supposed it frees the "used-once" pages more quickly.
Anyway I am not a VM expert and don't flame me about
my non relevant comments. 2.4.8 seems promising :-)

Regards,
Zoltan Boszormenyi <zboszor@mail.externet.hu>



