Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129370AbQLYLkk>; Mon, 25 Dec 2000 06:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129408AbQLYLka>; Mon, 25 Dec 2000 06:40:30 -0500
Received: from cicero0.cybercity.dk ([212.242.40.52]:15627 "HELO
	cicero0.cybercity.dk") by vger.kernel.org with SMTP
	id <S129370AbQLYLkU>; Mon, 25 Dec 2000 06:40:20 -0500
Date: Mon, 25 Dec 2000 12:10:28 +0100
From: Jens Axboe <axboe@suse.de>
To: Stelian Pop <stelian.pop@alcove.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Driver for emulating a tape device on top of a cd writer...
Message-ID: <20001225121028.A303@suse.de>
In-Reply-To: <20001218112529.B6315@wiliam.alcove-int> <20001218190442.B473@suse.de> <20001219104512.A10971@wiliam.alcove-int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001219104512.A10971@wiliam.alcove-int>; from stelian.pop@alcove.fr on Tue, Dec 19, 2000 at 10:45:12AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19 2000, Stelian Pop wrote:
> > > Basically, I would like to be able to use a cdwriter as a tape
> > > device, with software like dump(8) or tar(1). With /dev/tcdw
> > > as name (for example), I'd like to be able to do:
> > > [...]
> 
> > What you describe is actually one of the goals of the packet writing
> > driver. To do this reliably you need packet writing, I won't even
> > start to think about the headaches wihtout it...
> 
> Yes, I saw your patch for packet writing but:
> - the CD written with packet writing software may not be readable
>   on standard CD-ROM drives (and I want that, because almost 
>   everybody has one).

On CD drives sold during the last two years or so, and of course
all DVD drives they are readable. But of course of you want 100%
coverage, it isn't good enough.

> - using packet writing you basically write _files_ on top of an
>   UDF filesystem. Tar and dump (or afio, cpio etc) does not
>   support that kind of access, they expect to be given a character
>   device they can stream data to. (Of course, it is possible to
>   add some additionnal level of indirection on top of the packet
>   device and provide character based access to the UDF files, but
>   IMHO _this_ would be overkill).

Why would you even want to use UDF for this? You want raw access
to the device. Packet writing or not, this is totally unrelated.

> - data backups are expected to be fast. Writing data in DAO/TAO
>   mode is much quicker than in packet mode.

No no no, not much quicker. Write large packets and it's just
as fast as dao/tao. 64Kb packets are a bit slower because of
run-in, run-out block over head, but using larger packets this
isn't the noticable. And packet writing has so many other
advantages...

> - reliability is a question of implementation. cdrecord can
>   be very reliable. If a user space application can provide this
>   level of reliability, it should be even simpler to achieve it
>   in kernel space (and I plan to use the BurnProof/etc extensions
>   which will be present on all future cdwriters).

Even simpler to achieve reliability in the kernel? I gather you
mean feeding-data reliability, and not stability.

> > > I'll start to work on this, probably by looking at the cdrecord 
> > > low level code and porting it into kernel space.
> > 
> > Oh god no! You can do all this from user space.
> 
> Please pay attention to the fact that I was refering to the 'low level
> code'. I don't intend to write a driver who can replace cdrecord. 
> _This_ would be madness.

Very much so

> What I indend to do is just a 'small' driver, which supports only the
> mmc drives. I expect the driver to be only some hundreds lines long.

A few hundred lines? *This* I look forward to seeing :)

> Doing that from user space would mean propagating the data from
> the user space application (dump or tar) to a character mode
> driver, and back to a user space application (something like a hacked 
> cdrecord), which will return in kernel space using sg interface...
> It could be easier to write (even if I don't exactly feel confident
> about hacking the cdrecord source :) ), but the reliability and
> the performance would be far far away...

Pipes and 100% user space based, then pass to sg? I don't see the
problem.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
