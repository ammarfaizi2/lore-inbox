Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131590AbRAJEEl>; Tue, 9 Jan 2001 23:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131745AbRAJEEb>; Tue, 9 Jan 2001 23:04:31 -0500
Received: from cs2732-110.austin.rr.com ([24.27.32.110]:2801 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S131590AbRAJEE3>; Tue, 9 Jan 2001 23:04:29 -0500
Message-ID: <3A5B9C36.F6718E56@flash.net>
Date: Tue, 09 Jan 2001 17:18:14 -0600
From: Rob Landley <landley@flash.net>
Organization: Boundaries Unlimited
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Fwd: Learn from minix: fork ramfs.] - linus's reply
Content-Type: multipart/mixed;
 boundary="------------87D1F13745570CF698A44D45"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------87D1F13745570CF698A44D45
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

He replied to my bad cc:, so forwarding this here should be okay...
--------------87D1F13745570CF698A44D45
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

X-Mozilla-Status2: 00000000
Message-ID: <3A5B995D.D31A8C39@flash.net>
Date: Tue, 09 Jan 2001 17:06:05 -0600
From: Rob Landley <landley@flash.net>
Organization: Boundaries Unlimited
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.rutgers.edu
Subject: Re: Learn from minix: fork ramfs.
In-Reply-To: <Pine.LNX.4.10.10101081900040.1371-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> 
> On Mon, 8 Jan 2001, Rob Landley wrote:
> >
> > So fork ramfs already.  Copy the snapshot you like as an educational
> > tool, call it skeletonfs.c or some such, and let the current code evolve
> > into something more useful.
> 
> The thing is, that I'm not sure that even the extended ramfs is really
> useful except for very controlled environments (ie initrd-type things
> where the contents of the ramdisk is _controlled_, and as such the
> addition of limits is not necessarily all that useful a feature). Others
> have spoken up on why tmpfs isn't a good thing either, with good
> arguments.

I've got a use for it.  Diskless render nodes.

At my day job we do (among other things) rackmounted render farms, and
we're thinking about adding diskless dual procs to our line in our
Copious Free Time (tm).  The plan right now is to throw at least half a
gig of ram in each machine (quite possibly more, maya and other
renderers positively suck the stuff down even WITH local disks), boot
the sucker up via intel's PXE (dhcp/bootp/mtftp apparently has a new
name since last I saw it, right...), and use a combination of NFS and
ramfs for the root filesystem.

Ramfs is WAY better than the ram block device 'cause of the
auto-scaling.  If the client wants to use all the memory for the
rendering app, ramfs is only really dealing with logs and such.  If they
want to copy their dataset over and belch out frame after frame from the
local copy to cut down on server bandwidth (which can EASILY get to be a
bottleneck here).

Best of all, they don't have to come back to US to get any kind of
configuration changes, this is all a matter of what their apps choose to
do.  And when they delete stuff they get the ram back, which is nice
when things like maya can spit out verbose logs you have to parse to see
if something went wrong, or when you have to run some odd tool to
convert an entire file from one data format to another to parse out some
info, which results in an enormous file existing for only a second or
two.  Getting that ram back is very, very nice.  Tying up half the box's
ram with a block device when it's only briefly used is not.

> I think the ramfs limit code has a good argument from Alan for embedded
> devices, so that probably will make it in. However, even so it's obviously

I'd like to second that.  The oom killer is better than nothing, but
people are way more used to comprehending/diagnosing a full file system
rather than their apps crashing.  If I can tell it not to let the disk
grow big enough to hose the system, this is a Good Thing. :)

(We're selling this stuff to art majors.  They have an IT department,
but I strongly suspect they need all the help they can get.)

> not a 2.4.1 issue, AND as shown by the fact that apparently the thing is
> buggy and still worked on I wouldn't want the patches right now in the
> first place.

You mean other than the free when delete thing in .0?

Take your time.  Enjoy life.  Happy birthday.  Pet the cat.  Pack for
LWE.  Bask in the adoration of the world at large for surviving yet
another development cycle.  Teach your daughters to program (the world
needs more geekettes.  Where Illiad and Eric Raymond find them I'll
never know).

No rush.  I can grab an AC patch to get limits for testing and
configuring my config.  I'd just not sure I could convince management to
ship one, or our customers to accept it.  But that's my problem, isn't
it? :)

(Come to think of it, I could probably just use user-level filesystem
quotas in this case.  All the apps the node runs should be under one
user, and the log files root writes out are pretty much a rounding
error...  Hmmm...  Not exactly an elegant solution, and I can only hope
the multi-megabyte files that user owns on NFS don't throw off the
count.  (Queue pooh: Think think think, think-think...))

>                 Linus

Rob

P.S.  Linus responded to my email!  Wow!  Did it himself and
everything.  I feel like I've been initiated into something, but I don't
know what...

--------------87D1F13745570CF698A44D45--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
