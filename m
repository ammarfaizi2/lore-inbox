Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161101AbWBTSRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161101AbWBTSRF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 13:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161104AbWBTSRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 13:17:05 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:13831 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1161101AbWBTSRD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 13:17:03 -0500
Date: Mon, 20 Feb 2006 19:16:57 +0100
From: Olivier Galibert <galibert@pobox.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: kernel list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060220181657.GD33155@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	kernel list <linux-kernel@vger.kernel.org>,
	Pavel Machek <pavel@suse.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602201513.23849.rjw@sisk.pl> <20060220153922.GA17362@dspnet.fr.eu.org> <200602201816.56232.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602201816.56232.rjw@sisk.pl>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 06:16:55PM +0100, Rafael J. Wysocki wrote:
> On Monday 20 February 2006 16:39, Olivier Galibert wrote:
> > On Mon, Feb 20, 2006 at 03:13:23PM +0100, Rafael J. Wysocki wrote:
> }-- snip --{
> > From what I see of the messages in this thread, at that point you're
> > just trying to play catchup with suspend2.
> 
> Well, I don't think I am.  Or maybe a little.  Still, are you trying to say that
> GNOME developers should give up because KDE is more advanced in some
> respects or vice versa?

The GNOME/KDE situation is an interesting parallel.  GNOME was created
as you probably know essentially because of licensing issues with Qt.
I suspect RedHat wanting to differentiate itself from Suse probably
helped justifying the financing.  For a long while GNOME just played
catchup with KDE.  Current situation is amusing, though.  Sanity has
prevailed, applications are made interoperable between the two
environments and a modern desktop uses from the two indifferently.
There is slightly less duplication between the two, too.  But at the
same time both desktops are trying very hard to differenciate from
each other, GNOME is playing the "user friendlyness" card for
instance, whatever their definition of that is.

Now here, we're talking about suspend.  Something where the best user
interface is no user interface.  Disk speeds and memory sizes being
what there are you have to somehow tell the user that yes, things are
still moving.  But otherwise, there isn't much to do to differenciate
from each other.  Some amusing features could be added, especially at
the interaction between suspend to ram and disk, but STR is even more
unreliable than STD so it's not going to happen any time soon.


> > Don't that feel a little strange to you?  You know you have working GPL code
> > handy, tested with happy users, with a maintainer who would be happy to have
> > it in the kernel, and instead of making it better you spend your talents redoing
> > the same functionality only slightly differently.  Why?
> 
> _I_ am doing it as a proof of concept.  Many people said it didn't make sense
> to implement this in the user space and that it wouldn't work, and it would
> take ages to do this etc.  I don't agree with that and I want to show I'm right.
> Is that wrong?

Nothing wrong with that.  Cool hacks are cool pretty much by
definition :-)

Now try another point of view.  STD as currently in the kernel is
unreliable, and don't get me started about STR.  Assume that you are
the suspend maintainer for the kernel (you are the co-maintainer at
that point in practice).  As such, you should want STD/STR to be
reliable.  As an engineer, tell me if you think uswsusp has a chance
to make STD/STR more reliable than the current situation.


> No, it doesn't.  By the same token you could say writing another mail
> client is redoing Mozilla Thunderbird.

You have, say, xmh.  You start working to make it look and act like
Thunderbird.  Isn't that redoing Thunderbird, whatever the
implementation looks like at the end?


> > md5 is already in the kernel (twice).  lzf is already in suspend2 (and
> > arguably useful for more things than only suspending),
> 
> Now seriously.  Nigel already _had_ submitted the LZF patch, but it 
> was not accepted by the cryptoAPI maintainers.  Neither me, nor Pavel
> took part in that.  The same applies to many things in suspend2,
> just browse the LKML archives for the record.

I'll try to have a look.  I'm curious for the reasons (we don't need
that vs. we need that but that code is crap).


> > Now explain me why you're tying together code from coreutils and other
> > sources when you have the same code, only already tested in a suspend
> > context (memory management, etc), in suspend2.
> 
> Sorry, it's not like that.  The memory management is not done by the
> userland part, it's done by the kernel.  The role of the userland part
> is to read the image from the kernel, transform it (compress/encrypt/whatever)
> if needed and save to disk.  All that.

If the memory usage of your userland part is not severely bounded you
may have annoying issues.  Libraries inmy experience tend to be quite
liberal in their allocations.


> > Why, for the image save, did you port the code from swsusp with for instance
> > its lack of async i/o, instead of porting the suspend2 code?
> 
> Because suspend2 code is incompatible with what's in the kernel now.
> 
> To use the suspend2 code I'd have to modify the kernel code substantially, and
> that's what Pavel didn't want.  OTOH the swsusp code was known to work
> and I used it to test the new code, too.

Ok.  I wouldn't have thought writing the image could be that
different, but I definitively take your word for it.


> > Stuff that is _already_ _done_ and working.
> 
> Functionality-wise, your right.  The problem is how it's done, I think, and
> that is not so obvious.

Heh.  It obviously has been way too long out of mainline.  Pavel's
reviews being 90% "you should do all that in userspace" are a little
tiring after a while though.


> >    The constraints on userland suspend code are rather close to RT kernel
> >    code, so  technically it would be a much better base.
> 
> Can you please tell me why do you think so?

Well, from what I see (I can be very wrong mind you), the constraints are:
- no fs access at all
- careful with memory, you don't want to push things into swap once
  the image is done

That's very RT-ish.  And all that essentially without the kernel
protecting you from your errors.
 


> > 4- why aren't you actively working at pushing the parts of suspend2
> >    that actually are good and potentially useful to uswsusp in the
> >    mainline kernel.  Do you really think nothing is worthwhile in there?
> 
> Because there are no patches to work on?  I'd _really_ love to work on patches
> that modify the current kernel code _gradually_ instead of just trying to
> replace it top-down with something else in one big shot.
> 
> For example, I'd really appreciate it if Nigel could prepare a patch against
> the current -mm implementing the freezing of bdevs he was talking about,
> and there are more things like that.

Ok, that attitude I completely agree with.


> > Please tell me what is wrong in my perception of what is going on.
> 
> I think you are assuming I'm doing this to prevent suspend2 from being merged.
> It is not so, as I've tried to explain above.  If you don't accept my point of view,
> I'll respect that.

You're way saner about suspend2 than Pavel is.

  OG.
