Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261530AbSLUBwm>; Fri, 20 Dec 2002 20:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261523AbSLUBwm>; Fri, 20 Dec 2002 20:52:42 -0500
Received: from magic.adaptec.com ([208.236.45.80]:49597 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S261486AbSLUBwi>; Fri, 20 Dec 2002 20:52:38 -0500
Date: Fri, 20 Dec 2002 18:59:46 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Janet Morgan <janetmor@us.ibm.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aic7xxx bouncing over 4G
Message-ID: <223910000.1040435985@aslan.btc.adaptec.com>
In-Reply-To: <20021221013500.GN25000@holomorphy.com>
References: <200212210012.gBL0Cng21338@eng2.beaverton.ibm.com>
 <176730000.1040430221@aslan.btc.adaptec.com>
 <20021221002940.GM25000@holomorphy.com>
 <190380000.1040432350@aslan.btc.adaptec.com>
 <20021221013500.GN25000@holomorphy.com>
X-Mailer: Mulberry/3.0.0b9 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Dec 20, 2002 at 05:59:10PM -0700, Justin T. Gibbs wrote:
>> You can review all of that information by browsing the BK depot at:
>> http://linux-scsi.bkbits.net:8080/scsi-aic7xxx-2.5
>> Since the drivers in 2.4 and 2.5 are almost identical, the changelogs
>> there apply for 2.4.X too.
> 
> This is not in a remotely digestible form.
> (1) the entire universe's changesets are mixed together

Such is BK.

> (2) PITA, I filter for "gibbs", I see a changelog entry that says this:
>    Changeset details for 1.865.1.4
> 
>    ChangeSet@1.865.1.4  2002-12-12 13:45:46-07:00  gibbs@adaptec.com
>    all diffs
>    o Kill host template files.
>    o Move readme files into the Documentation SCSI directory
>    o Enable highmem_io
>    o Split out Kconfig files for aic7xxx and aic79xx
>    Host template and large disk changes provided or inspired by:
>            Christoph Hellwig <hch@sgi.com>
> 
> This is one cset??? These are -very- unrelated changes.

You have to look at individual files in BK to get anything other
than a simple sumation of what the CSET includes.  The CSET is
simply a grouping of changes.  Since I don't develop under BK,
the CSET groupings there are by convenience.  The CSET you list
is the integration of some changes from Christoph Hellwig.  They
are, in fact, related since they all came from him in a single
CSET!

> So I narrow it down to one file inside there:
> 
>    Changes for drivers/scsi/aic7xxx/aic7xxx_osm.c@1.5
> 
>    Age Author Annotate Comments
>    9 days gibbs@adaptec.com 1.5
>    Eliminate separate Linux host template files and move
>    all host template entry ponts to one section of the Linux
>    osm.c file.
>    Add support for larger disks under 2.5.X.
>    Enable highmem_io.
> 
> So now I have to figure out what you mean by "enable highmem io"

What?  You don't know what highmem io is?  Well, either did I until
I groveled around in scsi/host.h, noticed that this new flag had
shown up and greped around to see what it did.  Welcome to the club.

> which is a one-line change in the middle of vast amounts of code
> being shoveled from one file into another.

Those were committed in separate changes into our local Perforce
repository, but I simply don't have the patience to replicate each
individual change in Perforce into a BK change.  Since all of the
Linux universe likes stuff in BK format, I do what I can to accomodate
them.

> Moving around back and forth:
> 
>    11 days gibbs 1.865.1.2
>    Complete aic7xxx 6.2.22 and aic79xx 1.3.0_ALPHA2 update.
> 
> ... another nondescript logentry.

You have to look at the individual files.  In Perforce you have
a single Changelog entry for a submission, not per-file comments.
Since BK allows per-file comments, they are split out into per-file
comments.

> How many URL's do you expect me to chase here?

Why do you expect me to format all of my BK changes exactly the
way that you want?

> Do I have to find your *BSD cvs/whatever repo to extract meaningful
> log entries or are even the cvs commit messages there useless?

Depends on what you want.  It sounds like you want the per-file
messages.  If you did a bk-pull from the above URL, all of that
information would be easily available via "bk csettool".  It's
not my fault that the web interface for BK sucks.

> So off to www.freebsd.org and right there is a very different story:

All of that information is inside the BK changelogs too.  You just
need to work harder to get it.  Don't blame me because:

1) Individual developers are allowed to commit to the central repository
   for FreeBSD, but not in Linux so this kind of information is easily
   recorded for all to see.
2) The BK web interface sucks rocks.
3) You prefer having all of the comments in the CSET entry when BK
   is designed to take per-file comments.
4) You, unlike most people, actually care, in intimate detail, what has
   transpired in the aic7xxx and aic79xx drivers, but expect that
   information to be spoon fed to you.
5) My employer will not allow us to export our Perforce repository
   to remote clients even though it contains no proprietary information.

> Wow! Now that's what I call descriptive.
> 
> The changes listed under gibbs there seem to be mostly p4 ID synchs.
> Not sure what to make of those. But I did find this:

Scott's Changelog was pulled from our Perforce repository (he's a coworker).
I just haven't had time to commit to the FreeBSD repository recently so
he's done the last few updates.   Many, if not most,  of those comments
were actually made by me.

...

> This is very much smaller than the individual csets you're pushing
> to Linux, and has a changelog entry with actual content. Is there any
> chance you could send us changes as modular and well-documented as these?

If it wasn't such a pain to get stuff into the tree, you would see
smaller changesets.  With FreeBSD, I have the authority to go in
and modify the drivers, subsystems, etc. that I maintain at any
time and in any granularity.  Linux doesn't give me that freedom so 
you get this result.  I mean really.  I've only been trying to get
Marcelo to take the aic79xx driver since May or something.  Give
me a break.

--
Justin

