Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288579AbSBIHaK>; Sat, 9 Feb 2002 02:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288566AbSBIHaA>; Sat, 9 Feb 2002 02:30:00 -0500
Received: from [63.231.122.81] ([63.231.122.81]:41827 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S288565AbSBIH3w>;
	Sat, 9 Feb 2002 02:29:52 -0500
Date: Sat, 9 Feb 2002 00:29:20 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [bk patch] Make cardbus compile in -pre4
Message-ID: <20020209002920.Z15496@lynx.turbolabs.com>
Mail-Followup-To: Jeff Garzik <jgarzik@mandrakesoft.com>,
	Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0202081824070.25114-100000@segfault.osdlab.org> <20020208203931.X15496@lynx.turbolabs.com> <3C649F4F.7E190D26@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C649F4F.7E190D26@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Fri, Feb 08, 2002 at 11:02:23PM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 08, 2002  23:02 -0500, Jeff Garzik wrote:
> Andreas Dilger wrote:
> > I don't see why everyone who is using BK is expecting Linus to do a pull.
> > In the non-BK case, wasn't it always a "push" model, and Linus would not
> > "pull" from URLs and such?  Why are people not simply doing:
> > 
> > !bk send -r+ (other options) -
> > 
> > from within their editor (or equivalent) to inline the CSET in the email?
> > This has the added advantage that other people reading the email can also
> > import the CSET immediately if they so desire.
> 
> 'bk pull' is probably most useful to high volume submitters, where the
> contents of most patches is either obvious and/or uninteresting.

The problem is that (AFAIK) bk pull does not let Linus pick-and-choose
which patches he wants to accept as easily as importing them at the time
he reads each email.  It basically assumes that he wants everything that
is in the repository he is pulling from.

> 'bk send -d -r<rev> -' should be fine for importing.

Yes, that would be my thought as well.  Sadly, running the command

bk send -d -r+ -wgzip_uu -

does not work as I would _hope_ it would, namely putting a regular context
diff at the beginning of the email, and gzip_uu for only the CSET.  That
would give us the best of both worlds, namely a diff to look at (which
most people can read easily), and the compressed CSET for people who
have BK.

I suppose it is possible to do exactly what I want by running both:

bk changes -r<rev>			# generates Changelog
bk export -tpatch -h -du -r<rev>	# generates context diff
bk send -wgzip_uu -r<rev> -		# generates gzipped/uuencoded CSET

This has the added benefit that 'bk export' does not contain changes to
the BK files themselves, only the real changes.

I have no idea if this would confuse BK if you tried to recieve from
a file which had both of these in it...

> But this is still a trial run of BK, so who knows what will wind up to
> be the best policy for casual submitters.
> 
> And there's nothing wrong at all with sending GNU patches...

Oh, I agree that for people without BK they can keep sending patches.
I would prefer that people who _do_ have BK to send the CSET along with
the patch to the mailing list so that you don't have to go hunting for a
specific CSET, or if you can't because you are not currently connected.

This might also be possible if BK could export/import a whole changeset
in patch form, plus some magic stuff at the beginning/end (gzip_uu) which
had all of the BK metadata in it, but I don't know if that is possible or
desirable.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

