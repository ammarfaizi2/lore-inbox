Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265216AbUATC2n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 21:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264391AbUATCYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 21:24:45 -0500
Received: from intra.cyclades.com ([64.186.161.6]:10433 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265314AbUATCXO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 21:23:14 -0500
Date: Tue, 20 Jan 2004 00:19:21 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Doug Ledford <dledford@redhat.com>
Cc: Jens Axboe <axboe@suse.de>, hch@lst.de,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [2.4] scsi per-host lock was Re: smp dead lock of io_request_lock/queue_lock
 patch
In-Reply-To: <1074345000.13198.25.camel@compaq.xsintricity.com>
Message-ID: <Pine.LNX.4.58L.0401192316060.10707@logos.cnet>
References: <OF317B32D5.C8C681CB-ONC1256E19.005066CF-C1256E19.00538DEF@de.ibm.com>
  <20040112151230.GB5844@devserv.devel.redhat.com>  <20040112194829.A7078@infradead.org>
  <1073937102.3114.300.camel@compaq.xsintricity.com> 
 <Pine.LNX.4.58L.0401131843390.6737@logos.cnet> <1074345000.13198.25.camel@compaq.xsintricity.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Doug,

Where can I find a copy of uptodate iorl and mlqueue patchsets ?

I cant enjoy the feeling of splitting a global lock at this point in 2.4's
lifetime, but it has been in RedHat's and SuSE's trees for long.

A reason to have it its the dependacy of mlqueue patch. You said most
drivers are handling the BUSY/QUEUE_FULL hangs by themselves, you mention
"IBM zfcp" / Emulex which dont. What other drivers suffer from the same
problem ?


On Sat, 17 Jan 2004, Doug Ledford wrote:

> On Tue, 2004-01-13 at 15:55, Marcelo Tosatti wrote:
> > On Mon, 12 Jan 2004, Doug Ledford wrote:
> >
> > > On Mon, 2004-01-12 at 14:48, Christoph Hellwig wrote:
> > > > On Mon, Jan 12, 2004 at 04:12:30PM +0100, Arjan van de Ven wrote:
> > > > > > as the patch discussed in this thread, i.e. pure (partially
> > > > > > vintage) bugfixes.
> > > > >
> > > > > Both SuSE and Red Hat submit bugfixes they put in the respective trees to
> > > > > marcelo already. There will not be many "pure bugfixes" that you can find in
> > > > > vendor trees but not in marcelo's tree.
> > > >
> > > > I haven't seen SCSI patches sumission for 2.4 from the vendors on linux-scsi
> > > > for ages.  In fact I asked Jens & Doug two times whether they could sort out
> > > > the distro patches for the 2.4 stack and post them, but it seems they're busy
> > > > enough with real work so this never happened.
> > >
> > > More or less.  But part of it also is that a lot of the patches I've
> > > written are on top of other patches that people don't want (aka, the
> > > iorl patch).  I've got a mlqueue patch that actually *really* should go
> > > into mainline because it solves a slew of various problems in one go,
> > > but the current version of the patch depends on some semantic changes
> > > made by the iorl patch.  So, sorting things out can sometimes be
> > > difficult.  But, I've been told to go ahead and do what I can as far as
> > > getting the stuff out, so I'm taking some time to try and get a bk tree
> > > out there so people can see what I'm talking about.  Once I've got the
> > > full tree out there, then it might be possible to start picking and
> > > choosing which things to port against mainline so that they don't depend
> > > on patches like the iorl patch.
> >
> > Hi,
> >
> > Merging "straight" _bugfixes_
>
> OK, I've got some new bk trees established on linux-scsi.bkbits.net.
> There is a 2.4-for-marcelo, which is where I will stick stuff I think is
> ready to go to you.  There is a 2.4-drivers.  Then there is a
> 2.4-everything.  The everything tree will be a place to put any and all
> patches that aren't just experimental patches.  So, just about any Red
> Hat SCSI patch is fair game.  Same for the mods SuSE has made.  Pushing
> changes from here to 2.4-for-marcelo on a case by case basis is more or
> less my plan.  Right now, these trees are all just perfect clones of
> Marcelo's tree.  As I make changes and commit things, I'll update the
> lists with the new stuff.
>
> > (I think all we agree that merging
> > performance enhancements at this point in 2.4 is not interesting)
>
> Well, I can actually make a fairly impressive argument for the iorl
> patch if you ask me.  It's your decision if you want it, but here's my
> take on the issue:
>
> 1)  Red Hat has shipped the iorl patch in our 2.4.9 Advanced Server 2.1
> release, our 2.4.18 based Advanced Server 2.1 for IPF release, and our
> current 2.4.21 based RHEL 3 release.  So, it's getting *lots* of testing
> outside the community.  Including things like all the specweb
> benchmarks, Oracle TPC benchmarks, and all of our customers are using
> this patch.  That's a *lot* of real world, beat it to death testing.
>
> 2)  As I recall, SuSE has shipped either their own iorl type patch, or
> they used one of our versions of the patch, don't really know which.
> But, I know they've got the same basic functionality.  Between 1 and 2,
> that greatly increases the field testing of the iorl patch and greatly
> reduces the breadth of testing of the regular kernel scsi stack.
>
> 3)  OK, you can call it a performance patch if you want, but that
> doesn't really do it justice.  So, here's a little history.  I used the
> lockmeter patch when I was writing the iorl patch to get a clue just how
> much difference it made.  Obviously, on single disk systems it makes
> very little difference (but it does make some difference because the
> host controller and scsi_request_fn use different locks even on a single
> device and that does help some).  But, on a test machine with 4 CPUs and
> something like 14 disks, without the patch a disk benchmark was using
> 100% of CPU and hitting something like 98% contention on the
> io_request_lock.  On the same system with the patch, benchmark CPU usage
> dropped to something like 12% and because we weren't spinning any more
> scsi_request_fn and make_request dropped off the profile radar entirely
> and contention was basically down to low single digits.  Consider my
> home server has 7 disks in a raid5 array, it certainly makes a
> difference to me ;-)
>
> 4)  The last issue.  2.6 already has individual host locks for drivers.
> The iorl patch for 2.4 adds the same thing.  So, adding the iorl patch
> to 2.4 makes it easier to have drivers be the same between 2.4 and 2.6.
> Right now it takes some fairly convoluted #ifdef statements to get the
> locking right in a driver that supports both 2.4 and 2.6.  Adding the
> iorl patch allows driver authors to basically state that they don't
> support anything prior to whatever version of 2.4 it goes into and
> remove a bunch of #ifdef crap.

