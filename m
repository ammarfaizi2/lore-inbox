Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268903AbRG3PYJ>; Mon, 30 Jul 2001 11:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268917AbRG3PX7>; Mon, 30 Jul 2001 11:23:59 -0400
Received: from [212.150.182.35] ([212.150.182.35]:21521 "EHLO
	exchange.guidelet.com") by vger.kernel.org with ESMTP
	id <S268903AbRG3PXo>; Mon, 30 Jul 2001 11:23:44 -0400
Message-ID: <018101c11914$40bc3100$910201c0@zapper>
From: "Alon Ziv" <alonz@nolaviz.org>
To: "Alexander Viro" <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0107300137550.16140-100000@weyl.math.psu.edu>
Subject: Re: [CFT] initramfs patch
Date: Mon, 30 Jul 2001 18:25:27 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I wonder...  May the initramfs be used also for loading modules ???
Hmm... it will require a pico-insmod that can run in the limited initramfs
environment, but I believe that's all !
Reminder-to-self: try this at home...
This may bring the long-awaited revolution in kernel building (everything
is a module!)

    -az

----- Original Message -----
From: "Alexander Viro" <viro@math.psu.edu>
To: <linux-kernel@vger.kernel.org>
Cc: "Linus Torvalds" <torvalds@transmeta.com>;
<linux-fsdevel@vger.kernel.org>
Sent: Monday, July 30, 2001 8:05
Subject: [CFT] initramfs patch


> Folks, IMO initramfs (aka. late boot in userland) is suitable
> for testing.
>
> Patches are on ftp.math.psu.edu/pub/viro, namespaces-a-S8-pre2 and
> initramfs-a-S8-pre2 (the latter is against 2.4.8-pre2 + namespaces).
>
> It is supposed to be a drop-in replacement - any boot setup that works
> with vanilla 2.4 should work with it, initrd or not, with or without
devfs,
> with loading from floppies, etc.
>
> In other words, if you boot normally with 2.4 and something breaks with
> initramfs - I want to know about that.
>
> Stuff that went in userland: choosing and mounting root, unpacking/loading
> initrd, running /linuxrc, handling nfsroot, finding and starting final
> init - basically, everything after do_basic_setup().
>
> The thing unpacks cpio archive (currently - linked into the kernel image)
> on root ramfs and execs /init. After that we are in userland code. Said
> code (source in init/init.c and init/nfsroot.c) emulates the vanilla
> 2.4 behaviour. You can replace it with your own - that's just the default
> that gives (OK, is supposed to give) a backwards-compatible behaviour.
>
> Thing that had not gone into the userland, but should be there:
ipconfig.c.
> If somebody feels like writing a userland equivalent - I'd be very
> grateful to see it. Currently it's still in the kernel.
>
> Another thing that is definitely needed is less crude RPC (for nfsroot).
> Currently it's _very_ quick-and-dirty.
>
> At that stage I'm mostly interested in bug reports regarding the cases
> when behaviour differs from the vanilla tree. I _know_ that we need more
> elegant way to add initial archive to the kernel image. That's a
> separate issue and I'd rather deal with that once userland implementation
> of late-boot is decently debugged.
>
> Right now it's x86-only, but that's the matter of adding minimal
replacement
> of crt1.o for other platforms (i.e. code that picks argc, argv and envp
> and calls main() - 7 lines of assembler for x86 and probably about the
> same on other platforms). Equivalents of arch/i386/kernel/start.S (see
> the patch) are welcome.
>
> It should be pretty safe to debug, for a change - it either gets to
> starting /sbin/init (in which case we are done and safe) or it breaks
> before any local fs is mounted r/w.
>
> Linus, I'm not putting these patches in the posting - each of them is
> above 100Kb and that's way beyond any sane l-k limits. If you want
> to get them in email - tell and I'll send them. And yes, I'm going
> to split this stuff in small chunks when it will come to submitting
> it.
> Al
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

