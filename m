Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262824AbTARHBj>; Sat, 18 Jan 2003 02:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262877AbTARHBj>; Sat, 18 Jan 2003 02:01:39 -0500
Received: from ldap.somanetworks.com ([216.126.67.42]:11648 "EHLO
	mail.somanetworks.com") by vger.kernel.org with ESMTP
	id <S262824AbTARHBg>; Sat, 18 Jan 2003 02:01:36 -0500
Date: Sat, 18 Jan 2003 02:10:31 -0500 (EST)
From: Scott Murray <scottm@somanetworks.com>
X-X-Sender: scottm@rancor.yyz.somanetworks.com
To: Rusty Lynch <rusty@linux.co.intel.com>
cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       pcihpd-discuss <pcihpd-discuss@lists.sourceforge.net>
Subject: Re: [Pcihpd-discuss] Re: [BUG][2.5]deadlock on cpci hot insert
In-Reply-To: <1042855474.1016.163.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0301180127080.31889-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Jan 2003, Rusty Lynch wrote:

[snip] 
> I actually have two ZT5550C boards each using a ZT96073 mezzanine board 
> (which contains a hard drive a floppy) and each with ZT4804/ZT4802 rear
> panel transition boards.
>
> I do not see anything in my BIOS (v5.15) about "High Availability" options,
> but looking through the ZT5550 manual on the pt website, I noticed that
> all ZT550 models before revision 'D' only have active-standby mode, so I 
> wonder if the bit we are looking at was only used in newer versions of the
> ZT5550.

Hmm, based on the research I've done, that does seem to be the case.

> For what it is worth, I messed around with all the possible combinations
> of system master and peripheral boards that I had, and noted what HCF_HCS
> was in system log.
[snip]

That's very useful information, thank you!

> Like I mentioned before, I suspect that the last three bits are not
> implemented on older ZT5550 boards (pre 'D' versions).  In the docs 
> you have access too, is there reference to a register we could find 
> out which version of 5550 this board is for?  That would make this
> easy to solve.

I've dug through the rss-1.0-1 tarball released by Ziatech/Intel, and
have found the init code that handles setup for the different versions
of the host controller.  Once I decipher it a bit further, I should be
able to handle the two board versions.  Note, however, that my plan is
to disable the driver on standby mode boards, since I'm not really in
a position to work on a RSS capable driver (no hardware or time on my
part, and SOMA isn't interested in RSS).

> hmm... if HCS_RH_STATE is talking about if the other system board is
> active or standby, then we could assume both busses need to be added
> if HCS_RH_STATE is not set. That is unless there such thing as being able to 
> completely turn off one of the busses.

The docs I have from PT are pretty much specific to the D version of
the card, so I'll try and decipher the differing bits from the rss-1.0-1
code.

> BTW, I'm going to be at the Linux World show in NY next week, so I
> will not be able to try anything new for a week.

I'll do some more experimenting here and try to come up with a patch
sometime next week that should work with your ZT5550C boards.

Scott


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com

