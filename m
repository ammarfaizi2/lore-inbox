Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278685AbRKDUo0>; Sun, 4 Nov 2001 15:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278818AbRKDUoR>; Sun, 4 Nov 2001 15:44:17 -0500
Received: from mail.scsiguy.com ([63.229.232.106]:28433 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S278685AbRKDUn5>; Sun, 4 Nov 2001 15:43:57 -0500
Message-Id: <200111042043.fA4KhpY70612@aslan.scsiguy.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: linux-kernel@vger.kernel.org, groudier@club-internet.fr
Subject: Re: Adaptec vs Symbios performance 
In-Reply-To: Your message of "Sun, 04 Nov 2001 20:56:58 +0100."
             <20011104205658.3ac97e2d.skraw@ithnet.com> 
Date: Sun, 04 Nov 2001 13:43:51 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>See:
>
>Date:	Wed, 31 Oct 2001 16:45:39 +0100
>From:	Stephan von Krawczynski <skraw@ithnet.com>
>To:	linux-kernel <linux-kernel@vger.kernel.org>
>Subject: The good, the bad & the ugly (or VM, block devices, and SCSI :-)
>Message-Id: <20011031164539.29c04ee0.skraw@ithnet.com>

<Sigh> I don't read all of the LK list and the mail was not cc'd
to me, so I did not see this thread.

>> A full dmesg would be better.  Right now I have no idea what kind
>> of aic7xxx controller you are using,
>
>Adaptec A29160 (see above mail). Remarkably is I have a 32 bit PCI bus, no 64
>bit. This is an Asus CUV4X-D board.

*Please stop editing things*.  I need the actual boot messages from
the detection of the aic7xxx card.  It would also be nice to see
the output of /proc/scsi/aic7xxx/<card #>

>> the speed and type of CPU,
>
>2 x PIII 1GHz

Dmesg please.

>Sorry, misunderstanding. What I meant was: how fast can you read data
>from your cd-rom attached to some adaptec controller?

I'll run some tests tomorrow at work.  I'm sure the results will
be dependent on the cdrom in question but they may show something.

>> >If you redo this test with nfs-load (copy files from some client to your
>> >test-box acting as nfs-server) you will end up at 1926 - 2631 kB/s
>throughput
>> >with aic, but 3395 - 3605 kB/s with symbios.
>> 
>> What is the interrupt load during these tests?
>
>How can I present you an exact figure on this?

Isn't there a systat or vmstat equivalent under Linux that gives you
interrupt rates?  I'll poke around tomorrow when I'm in front of a Linux
box.

>>  Have you verified that
>> disconnection is enabled for all devices on the aic7xxx controller?
>
>yes.

The driver may not be seeing the same things as SCSI-Select for some
strange reason.  Again, just email me a full dmesg after a successful
boot along with the /proc/scsi/aic7xxx/ output.

>> This does not look like an interrupt latency problem.
>
>Based on which thoughts?

It really looks like a bug in the driver's round-robin code or perhaps
a difference in how many transactions we allow to be queued in the
untagged case.

Can you re-run your tests with the output directed to /dev/null for cdrom
reads and also perform some benchmarks against your disk?  The benchmarks
should operate on one device only at a time with as little I/O to any other
device during the test.

--
Justin
