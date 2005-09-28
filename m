Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751005AbVI1Wsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbVI1Wsi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 18:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbVI1Wsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 18:48:38 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:40710 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751005AbVI1Wsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 18:48:37 -0400
Date: Thu, 29 Sep 2005 00:35:43 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: Andre Hedrick <andre@linux-ide.org>,
       Patrick Mansfield <patmans@us.ibm.com>,
       Luben Tuikov <ltuikov@yahoo.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into the kernel
Message-ID: <20050928223542.GA12559@alpha.home.local>
References: <Pine.LNX.4.10.10509281227570.19896-100000@master.linux-ide.org> <433B0374.4090100@adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <433B0374.4090100@adaptec.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, hi Luben,

On Wed, Sep 28, 2005 at 04:56:20PM -0400, Luben Tuikov wrote:
(...)
> Ok, thanks Andre.  Much appreciated.
> 
> You are the first person to back me up _publicly_.  Now if we
> can find a person from "the community" to do that, and get all
> the other people who've written me _privately_, we'd be in
> good shape.

I'm sure I'm not one of those who qualify best here, but having largely
contributed to Linux acceptance at critical points at a handful of big
customers here, I'd like to send some general feeling I get from there.

There are people buying expensive hardware. The type of hardware
that costs $100k for just a few CPUs. Those people don't buy "the
Adaptec XXX which runs best with Red Hat Enterprise" nor the "LSI
YYY which runs best with Solaris", they buy a few $100k systems
with 3 TB disk to store their monthly logs. They cannot even imagine
that the hardware in the $100k system will not be fully supported by
some recent OS, that's just plain silly. The OS cost is just a water
drop in the middle of this. When they install Solaris on it because
they're used to run it, it just works. When I sometimes just show
them that Solaris is not adequate for daily greps in logs, and I show
them how faster it is on a $1k Linux machine in the next rack, they
feel they can switch to it easily. But if they discover that this
system does not correctly support their $100k hardware, do you know
which one was is the crap ? the $300 Red Hat or the $100k hardware ?
[ oh, BTW, I forgot to tell you : they say "Red Hat", and not "Linux"
because it does not sound like what they long considered an OS for
tamagotchis - to use their own words - :-( ]

And when they go to adaptec site to find latest drivers and they only
find patches which forces them to find another Linux to install the
sources and guess how to patch and build, do you know which OS they
consider as hobbyist's ? The Red Hat ! (which they can call "Linux"
again then).

For those reasons, I could put Linux there on very specific places,
mostly firewalls and load-balancers. A self-made distro with kernel
2.4 with patch-o-matic still is one of the most powerful and reliable
firewalls around, and at only a few bucks. The same hardened install
is used for load-balancers with my proxy. Seeing that the proxies
have been stable for years, they bought between 50-100 RHEL licences.
But that's all. Nowhere you will find anything serious using Linux in
other areas. It's already a nightmare for them to get a hardware RAID
card working while they just have to click on stupid icons in Windows
to do the same. Right now, new Linux-based machines are turning back
to plain IDE. SCSI was too much boring for them and not needed to do
just networking. Period.

When they will buy hundreds of TB of SAS-based racks in the next few
years, and they will learn the hard way that Linux does not even see
them as disks, it will be too late to give my preferred OS a second
chance.

Hans Reiser once said that every software needs a complete rewrite
every 3 or 5 years (I don't precisely remember). I tend to agree
with him. Maybe it's time to completely rewrite the SCSI subsystem,
but maybe it will be too long, too risky and not worth the effort.
Maybe it can simply coexist with another new subsystem. This is what
Luben seems to have done : break no code, just bring a new subsystem
which should not even give the SCSI maintainer too much work if he
maintains it himself. At least I could understand some arguments against
Reiser4 because it touched the VFS, but here we have a perfect example
of something new which can live next to SCSI and probably some time
will replace it definitely. Jeff has done this with libata (it even
had to touch some pieces to coexist with piix4 and probably a few other
chips).

Having read the discussion from the start here a few days ago, I
believe that Luben maybe has not explained well to non-competent
people like me what the goal of his work is. I've looked at the GIF
on T10.org, but I think that the equivalent with what it currently
implemented in Linux would be worth doing. Maybe we would even
notice that current maintainers cannot agree on a same representation.
Maybe it will enlighten some of us about the poor error reporting,
the reasons why USB storage sometimes fails to assign a device when
plugging a flash, etc...

Luben, you seem to have enough knowledge to draw both diagrams
side-by-side :
 - the T10 spec with colors on the boxes covered by your work
 - the Linux view of SCSI

Perhaps we will see that current code can be extended without too
much work, or perhaps we will see that it's definitely a dead end
and that a new design will help a lot.

Anyway Luben, I fear that for some time, you'll have to provide
pre-patched sources as well as binary kernels to enterprise customers
who still try to get Linux working in production. I hope that this sad
experience will not discourage other vendors from trying to take the
opensource wagon, as it clearly brings fuel to closed-source drivers
at the moment (no need to argue).

Eventhough I don't have SAS, I sincerely hope that a quick and smart
solution will be found which keeps everyone's pride intact, as it
seems to matter much those days. In an ideal situation, 2.7 would
have been opened for a long time, and Luben's code would have been
discussed to death as a new development needed to be merged before
2.8. Right now, as 2.7 is 2.6.<odd>, probably that ideas can gem
before 2.6.15.

Just my personnal thoughts
Willy

PS: please don't CC me in return, I can read LKML. I haven't trimmed
the CC list as nobody has complained yet.

