Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265134AbUGCOpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265134AbUGCOpo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 10:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265137AbUGCOpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 10:45:44 -0400
Received: from mail007.syd.optusnet.com.au ([211.29.132.55]:63184 "EHLO
	mail007.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265134AbUGCOpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 10:45:39 -0400
Date: Sun, 4 Jul 2004 00:45:00 +1000
From: Andrew Clausen <clausen@gnu.org>
To: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>,
       Steffen Winterfeldt <snwint@suse.de>, bug-parted@gnu.org,
       Thomas Fehr <fehr@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Restoring HDIO_GETGEO semantics (was: Re: workaround for BIOS / CHS stuff)
Message-ID: <20040703144500.GL630@gnu.org>
References: <s5gwu1mwpus.fsf@patl=users.sf.net> <Pine.LNX.4.21.0407021528150.21499-100000@mlf.linux.rulez.org> <20040703013552.GA630@gnu.org> <s5g8ye1qjg9.fsf@patl=users.sf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5g8ye1qjg9.fsf@patl=users.sf.net>
X-Accept-Language: en,pt
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 03, 2004 at 10:15:47AM -0400, Patrick J. LoPresti wrote:
> Parted is primarily a component of larger systems; namely, the
> RedHat/Suse/etc. installers.  Those larger systems can figure out the
> correct geometry (using whatever logic/heuristics/knowledge they have)
> and pass it to the tools which need it, of which Parted is just one.

Why should they bother?  Shouldn't libparted just do it all for them?
(Shouldn't parted use EDD?)

> I am suggesting that you cater to the 99.9% case.  This means
> providing some way, any way, to override Parted's notion of the
> geometry.  In my opinion, you should simply gut the logic for guessing
> the geometry, because it really does not belong in Parted.  But I do
> not really care as long as I have a way to bypass it.

I was under the impression that 2.6 provides a mechanism for setting the
HDIO_GETGEO thingy... so any program can tell Parted (and everything
else, for that matter) what they want the geometry to be.  Perhaps
I misunderstood your email:

	http://www.uwsg.iu.edu/hypermail/linux/kernel/0404.0/0270.html

It contains this:

	echo "bios_cyl:C bios_head:H bios_sect:S" > /proc/ide/hda/settings

Isn't the kernel the right place for this kind of communication to
be happening, anyway?

> (Note that this would also provide a way for end users to fix their
> partition tables if/when they broke.  Right now, the stock solution
> for disks which Parted "broke" is "sfdisk -d | sfdisk -C# -H# -S#".
> Wouldn't it be nice if people could use Parted instead?)

They can, right?  Just type the above, and then do some dummy thing
in parted.  (Parted doesn't have a "touch" command).

> > > 1) and 2) need a way to get a "sane" geometry from the BIOS or kernel.
> > 
> > Shouldn't we just use LBA?  (i.e. x/255/63)
> 
> IBM Thinkpads use x/240/63.  In theory, other BIOSes could use
> anything.

Do they break on x/255/63?

Cheers,
Andrew

