Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266443AbTAFKXA>; Mon, 6 Jan 2003 05:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266460AbTAFKXA>; Mon, 6 Jan 2003 05:23:00 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:31694 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id <S266443AbTAFKW4>; Mon, 6 Jan 2003 05:22:56 -0500
Date: Mon, 06 Jan 2003 23:24:23 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: Andre Hedrick <andre@pyxtechnologies.com>,
       Oliver Xymoron <oxymoron@waste.org>
cc: Andrew Morton <akpm@digeo.com>, Rik van Riel <riel@conectiva.com.br>,
       Richard Stallman <rms@gnu.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux iSCSI Initiator, OpenSource (fwd) (Re: Gauntlet Set NOW!)
Message-ID: <12720000.1041848663@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.10.10301051924140.421-100000@master.linux-ide.org>
References: <Pine.LNX.4.10.10301051924140.421-100000@master.linux-ide.org>
X-Mailer: Mulberry/3.0.0b10 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's a common large-vendor tactic to create bizzarre specs, and the IETF 
gets sidetracked that way very easily (I'm not blaming Cisco or anyone in 
particular, I am too busy at IETFs to track the politics in iSCSI). 
Andre's showing some of the difficulty of implementing any IETF spec; they 
are very incomplete.  You can't write an IP stack purely from the spec and 
get anywhere.

Also, in the case of something like iSCSI, you get two kinds of early 
implementations; experimental (in this case Cisco) and production (Andre, 
and presumably Microsoft).  Often the quality of the experimental 
implementations is awful, but nevertheless they become the reference. The 
community has recently been able to produce production quality code faster 
than the experimenters (anyone remember the first Halloween memo talking 
about how long it would take to implement WebDAV?  There was a complete, 
production opensource implementation available three days after the release 
of the memo, about a year ahead of MS).  Looks like Andre's done that with 
iSCSI.

Andrew

--On Sunday, January 05, 2003 19:38:15 -0800 Andre Hedrick 
<andre@pyxtechnologies.com> wrote:

> On Sun, 5 Jan 2003, Oliver Xymoron wrote:
>
>> On Sat, Jan 04, 2003 at 06:47:43PM -0800, Andrew Morton wrote:
>> > Andre Hedrick wrote:
>> > >
>> > > Rik and Richard,
>> > >
>> > > As you see, I in good faith prior to this holy war, had initiated a
>> > > formal request include a new protocol into the Linux kernel prior to
>> > > the freeze. The extention was requested to insure the product was of
>> > > the highest quality and not limited with excessive erratium as the
>> > > ratification of the IETF modified, postponed, and delayed ;
>> > > regardless of reason.
>> > >
>> > > Obviously, PyX had (has) on its schedule to product a high quality
>> > > target which is transport independent on each side of the protocol.
>> > > We are not sure of this position because of the uncertain nature of
>> > > the basic usages of headers and export_symbols.
>> > >
>> >
>> > I suggest that if a function happens to be implemented as an inline
>> > in a header then it should be treated (for licensing purposes) as
>> > an exported-to-all-modules symbol.  So in Linux, that would be
>> > LGPL-ish.
>> >
>> > The fact that a piece of kernel functionality happens to be inlined
>> > is a pure technical detail of linkage.
>> >
>> > If there really is inlined functionality which we do not wish made
>> > available to non-GPL modules then it should be either uninlined and
>> > not exported or it should be wrapped in #ifdef GPL.
>>
>> More pragmatically, who cares? There's already at least one vendor
>> (Cisco) who ships a perfectly good fully GPLed iSCSI initiator module
>> that doesn't need to touch any core code. It's already the benchmark
>> for compatibility at interoperability tests. And it's following the
>> IETF drafts closely too. Once we actually have an iSCSI RFC, it might
>> be worth pulling it into the kernel tree. I believe Red Hat is
>> shipping it some form already.
>
> If you know anything about iSCSI RFC draft and how storage truly works.
> Cisco gets it wrong, they do not believe in supporting the full RFC.
> So you get ERL=0, and now they turned of the "Header and Data Digests",
> this is equal to turning off the iCRC in ATA, or CRC in SCSI between the
> controller and the device.  For those people who think removing the
> checksum test for the integrity of the data and command operations, you
> get what you deserve.
>
>> That leaves the question of using Linux as an iSCSI target, and I've
>> yet to see any reason why this couldn't be done in userspace. In fact,
>> in a lot of ways that's the right thing to do as it lets you take
>> proper advantage of MD/LVM/EVMS/crypto, etc..
>
> You go right ahead, and see if you can move at near wire speed.
> Next try to support any filesystem regardless of platform.
> Specifically anything Microsoft does to thwart Linux, I have already
> covered.
>
>> There are a few other free implementations out there too.
>
> Please go use them and in two seconds my product can bring them all to the
> ground with the full error injection tool kit from both sides.  My team
> has gone through supporting every optional feature in the RFC draft as
> manditory to remove any possible vendor unique opportunities.
>
> There are grey areas in the RFC draft to support every corner case of
> ERL=1 and ERL=2.
>
> You figure out how to support the marker stream to perform a
> Sync-and-Steering layer.
>
> PyX is the second in the world to support Sync-and-Steering, and the first
> to do it software only.
>
> Please go for it, and you will spend at least 18-24 months to develop.
>
> The target(erl=0) is what would be the second phase to open source, but I
> see you and other want to do the hard way and that is fine.
>
> In two week I will have NetBSD certified, and 4 weeks later should have
> Solaris certifed.
>
> Cheers,
>
> Andre Hedrick, CTO & Founder
> iSCSI Software Solutions Provider
> http://www.PyXTechnologies.com/
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>


