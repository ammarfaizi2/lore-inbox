Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316499AbSHRWnd>; Sun, 18 Aug 2002 18:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316512AbSHRWnd>; Sun, 18 Aug 2002 18:43:33 -0400
Received: from zork.zork.net ([66.92.188.166]:19891 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id <S316499AbSHRWn3>;
	Sun, 18 Aug 2002 18:43:29 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: devfs
References: <Pine.GSO.4.21.0208180509540.2495-100000@weyl.math.psu.edu>
	<1029662182.2970.23.camel@psuedomode>
	<1029694235.520.9.camel@psuedomode> <6un0rkuiyg.fsf@zork.zork.net>
	<1029695363.1357.5.camel@psuedomode> <6uhehsui80.fsf@zork.zork.net>
	<20020818215355.GB5154@ip68-4-77-172.oc.oc.cox.net>
	<1029709596.3331.32.camel@psuedomode>
From: Sean Neakums <sneakums@zork.net>
Organization: The Emadonics Institute
X-Worst-Pick-Up-Line-Ever: "Hey baby, wanna peer with my leafnode instance?"
X-Groin-Mounted-Steering-Wheel: "Arrrr... it's driving me nuts!"
X-Message-Flag: Message text advisory: IMPROPER FORETHOUGHT, GROSS INDECENCY
X-Mailer: Norman
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Sun, 18 Aug 2002 23:47:30 +0100
In-Reply-To: <1029709596.3331.32.camel@psuedomode> (Ed Sweetman's message of
 "18 Aug 2002 18:26:35 -0400")
Message-ID: <6uznvju6m5.fsf@zork.zork.net>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

commence  Ed Sweetman quotation:

> On Sun, 2002-08-18 at 17:53, Barry K. Nathan wrote:
>> On Sun, Aug 18, 2002 at 07:36:47PM +0100, Sean Neakums wrote:
>> > commence  Ed Sweetman quotation:
>> [snip]
>> > > the devfs documentation says it doesn't need to have devfs mounted
>> > > to work, but this doesn't seem to be true at all.
>> > 
>> > If it does say exactly that, then it is outrageously wrong.
>> 
>> Starting at line 722 of
>> linux-2.4.19/Documentation/filesystems/devfs/README:
>> 
>> > In general, a kernel built with CONFIG_DEVFS_FS=y but without mounting
>> > devfs onto /dev is completely safe, and requires no
>> > configuration changes.
>> 
>> I skimmed through the documentation and it appears to assume that you're
>> not deleting all the stuff in /dev before switching over to devfs.
>
> This has nothing to do with not mounting devfs and still using devfs to
> work with devices.

If you don't mount devfs, you are not using it to "work with devices".
You use your existing device nodes, unless you deleted them, in which
case you are in trouble, as you discovered.

> If devfs is not mounted but you're still using devfs, you shouldn't
> need anything in /dev.

If devfs is not mounted, you are not "using it".

> The documentation says you can use devfs without mounting [...]

It does not.  It says that if devfs is built as part of your kernel's
configuration and you do not mount it, everything works as before.
For everythign to work as before, your device nodes need to be
present.

> and This is what i'm saying is problematic and doesn't seem possible
> in normal usage.  It's an optional config so are we using devfs when
> we dont mount it or not?  and if not, then why make not mounting it
> an option ?

I can imagine it being useful for for vendors.  Makes it easy to make
devfs usage a simple selection a install time without needsing to ship
two different kernels.

> If it's using the old device files in /dev then how can it be using
> devfs and how can accessing physical inodes on the disk be
> intentional to devfs?

Dunno what you mean here.

>> Right, there's no way around that. If you deleted everything in /dev --
>> which you're not supposed to do -- then there's no way for anything to
>> find any devices if devfs isn't enabled. (And you should have a rescue
>> CD around anyway -- you never know when you might need it! BTW, what
>> distribution are you (Ed) using? Some distributions have special boot
>> options you can use when booting their install CDs to get into a rescue
>> mode.)
>> 
>> In any event, it might be a good idea to make the documentation a bit
>> more explicit about this, and I might send a patch to the mailing
>> list later today.
>
> I'm not talking about booting without devfs enabled being the problem, i
> know booting without devfs enabled I'll have issues booting the system
> without physical /dev entries, i was referring to having devfs enabled
> and not mounting it.  Which according to the documentation should be
> perfectly functional and valid.  This is not the case though.

BECAUSE YOU DELETED YOUR DEVICE NODES.

> devfs should not require the old /dev entries at all since it
> doesn't use them so why would keeping them be required at all when
> using it (not counting the "if i want to not use devfs" argument).
> This is what should be cleared up in the documentation.

devfs does not require your old devices nodes.  Nowhere does the
documentation say that it does.  HOWEVER, if you want to boot a
devfs-capable kernel and not mount devfs (or simply boot a kernel with
no devfs capability at all), you have to have SOMETHING in /dev,
i.e. a set of standard device nodes.

-- 
 /                          |
[|] Sean Neakums            |  Questions are a burden to others;
[|] <sneakums@zork.net>     |      answers a prison for oneself.
 \                          |
