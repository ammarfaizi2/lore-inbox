Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267992AbUG2P3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267992AbUG2P3l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 11:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268164AbUG2PTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 11:19:11 -0400
Received: from mailr.eris.qinetiq.com ([128.98.1.9]:22473 "HELO
	qinetiq-tim.net") by vger.kernel.org with SMTP id S267992AbUG2PDt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 11:03:49 -0400
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: Jason L Tibbitts III <tibbs@math.uh.edu>
Subject: Re: mke2fs -j goes nuts on 3Ware 8506-4LP
Date: Thu, 29 Jul 2004 16:06:58 +0100
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org
References: <200407281050.24958.m.watts@eris.qinetiq.com> <ufad62evpwe.fsf@epithumia.math.uh.edu>
In-Reply-To: <ufad62evpwe.fsf@epithumia.math.uh.edu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200407291606.58636.m.watts@eris.qinetiq.com>
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.26.0.10; VDF: 6.26.0.51; host: mailr.qinetiq-tim.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> >>>>> "MW" == Mark Watts <m.watts@eris.qinetiq.com> writes:
>
> MW> I have a 3Ware 8506-4LP controller with 4 250GB Maxtor SATA
> MW> drives, in a raid-5 configuration (64K blocks) System is: Dual
> MW> Opteron 246 (2GHz) 2GB RAM Tyan S2875 motherboard
>
> I have a distantly similar configuration: 3ware 8506-4LP controller, 4
> 250GB Western Digital SATA drives, RAID5 (with one hot spare, so the
> array is only 500GB), running dual 2.8GHz Xeon CPUs on a Supermicro
> X5DPEG2 motherboard with 4GB of RAM.  The OS is Fedora Core 2 fully
> updated; kernel is 2.6.6-1.435.2.3smp (which is basically 2.6.7rc3
> plus security fixes).
>
> IO is just glacial.  Things go well for a time but then everything
> slows to a crawl.  The machine has very little load: a mostly inactive
> NFS export, mysql running a few queries per second on a very small
> database, that kind of thing.  Certainly the entire working set fits
> easily into available RAM.
>
> Yet on occasion it can take upwards of a minute just to ssh in.  This
> machine took over half of the load from a poor 2GHz Athlon machine
> with 1GB of RAM running Red Hat 7.2 and it feels far slower.
>
> It took three seconds to run this:
> > cat /proc/meminfo
>
<snip>
> I actually have several of these machines and can spare one for
> testing.  If anyone has any suggestions, I'm happy to try them out.
>
> MW> P.S. As I write this, I'm doing an sa-learn (spamassassin) over
> MW> 14k messages and the system is a little sluggish even though
> MW> gkrellm is only showing ~1MB/sec on the 3Ware, so I'm guessing
> MW> these are just pants cards in general.
>
> I have used 3ware cards extensively for many years now and have never
> known them to be slow like this.  This configuration should easily be
> able to saturate the drives (or the bus, whichever comes first).
>
>  - J<


I've since disabled CONFIG_PREEMPT in an attempt to see if ti fixes a full 
system freeze I've been seeing ove the last few days (3 freezes in 24 hrs but 
nothing on a serial console).
It seems to be behaving from that regard.

Copying a couple of ISO images (~650MB each) from a USB2 drive (LaCie 1TB 
disk) to the Raid has practically tied up the system again.
X is so unresponsive that I've managed to type the last paragraph before it 
hit the screen...

Once the copy has finished and caches have been synced to disk, the system 
becomes more lively again, but my P3/1.2Ghz/256MB laptop with an old 20GB 
disk is able to remain fully responsive when I copy the same set of isos over 
the network.

I have an LSI Logic Megaraid SATA raid card on order from my supplier so I'll 
be sticking it into another identical system to run some more tests, although 
I suspect it will confirm that its the 3Ware rather than the system thats the 
bottleneck.

Out of interest Jason, do you have the 3Ware plugged into a 64bit or 32bit pci 
slot?

Mark.

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ Trusted Information Management
Trusted Solutions and Services group
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBCRKSBn4EFUVUIO0RApm2AJ0cSwI7nqUeVqpKzcGS76cMbPwjtACfcsB3
WkyNVT6hQq0mnLMoqoKgoa0=
=lWPW
-----END PGP SIGNATURE-----
