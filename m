Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964936AbWBTPjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbWBTPjZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 10:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030278AbWBTPjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 10:39:24 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:2318 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S964935AbWBTPjY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 10:39:24 -0500
Date: Mon, 20 Feb 2006 16:39:22 +0100
From: Olivier Galibert <galibert@pobox.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: kernel list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060220153922.GA17362@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	kernel list <linux-kernel@vger.kernel.org>,
	Pavel Machek <pavel@suse.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <1140437152.3429.20.camel@mindpipe> <20060220123122.GA6086@dspnet.fr.eu.org> <200602201513.23849.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602201513.23849.rjw@sisk.pl>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 03:13:23PM +0100, Rafael J. Wysocki wrote:
> Actually "Pavel and frieds" are Pavel and _me_ and _I_ don't like what
> you're saying here.

Sorry about that.  Look at the thread though, and the answers to
questions of the "suspend2 as feature <x>" kind.  They tend to be
either "you don't need it" or "we need to reimplement it".  That looks
like a bad syndrome of NIHing to me and I should know, I catch myself
often enough at it.  It's really, really hard to admit that code that
you write yourself, for which you will instinctively know your way
around much better, may not in practice be better long term that what
already exists.  Often enough just because what already exists
obviously existed for longer than code you're going to write and as a
result has been way more debugged.


> > Even with wanting to move as many things to 
> > userspace as possible, merging suspend2 with cleanups if necessary,
> > _then_ starting from there to move things to userspace seems more
> > realistic long-term.
> 
> The _only_ thing we moved to the user space was the writing and reading
> of the image.  [We moved it quite literally, by porting the analogous swsusp
> code from the current -mm.]
> 
> Currently we are _not_ moving _anything_ to the user space.  We're just
> _implementing_ some things in the user space, but _not_ from scratch.

>From what I see of the messages in this thread, at that point you're
just trying to play catchup with suspend2.  Don't that feel a little
strange to you?  You know you have working GPL code handy, tested with
happy users, with a maintainer who would be happy to have it in the
kernel, and instead of making it better you spend your talents redoing
the same functionality only slightly differently.  Why?  Just for a
semireligious argument on where the userspace/kernelspace separation
should be in the suspend process?


> > Right now it really looks like they're only 
> > trying to redo what's already in suspend2, tested and debugged, only
> > different and new, hence untested and undebugged.
> 
> Actually a lot of the code that we use _has_ _been_ tested and debugged,
> because it _is_ used on a daily basis by many people, like eg.:
> - MD5 from the coreutils package,
> - libLZF (the original one)
> (openSSL wil be used soon for the image encryption).
> 
> And I'm not trying to redo suspend2 in the user space.  Instead I'm trying
> to use the code that's _already_ _available_ in the user space to obtain
> the functionality that suspend2 implements in the kernel space.

"obtaining the functionality that suspend2 implements" means "redoing
suspend2".  Don't play on words, please.

md5 is already in the kernel (twice).  lzf is already in suspend2 (and
arguably useful for more things than only suspending), so suspend2's
implementation has been tested for use in a suspend context, while
libLZF hasn't.  You _will_ have bugs putting things together, that's a
given.

Now explain me why you're tying together code from coreutils and other
sources when you have the same code, only already tested in a suspend
context (memory management, etc), in suspend2.  Why, for the image
save, did you port the code from swsusp with for instance its lack of
async i/o, instead of porting the suspend2 code?


> The problem is to merge suspend2 we'd have to clean it up first and
> actually solve some problems that it works around.  That, arguably,
> would be more work than just implementing some _easy_ stuff in the
> user space.

Stuff that is _already_ _done_ and working.

Be careful though, you're awfully close to saying that userspace code
is easier because it isn't reviewed[1] while kernel code has higher
standards.  I really doubt it from you guys, but it looks like that.


Ask yourself some important questions and see if you like the answers:

1- will uswsusp solve problems suspend2 doesn't?  Real, currently
   encountered problems, not philosophical problems about
   kernel/userspace code positions[2].  In particular, since according
   to Pavel 90+% of the problems are driver issues, why aren't you
   concentrating on drivers?

2- in the time you're going to need to reimplement all the features of
   suspend2 and stabilize the code, wouldn't it be possible to fix the
   worked-around problems of suspend2?  Will you ever be able to be as
   stable as suspend2 given the heads-up that code has?

3- if the main problem is really that some parts of suspend2 should be
   in userspace instead of kernelspace, why aren't you working from the
   appropriate parts of the suspend2 code to port them to userspace use
   instead of going to coreutils/libLZF/etc?  The constraints on
   userland suspend code are rather close to RT kernel code, so
   technically it would be a much better base.

4- why aren't you actively working at pushing the parts of suspend2
   that actually are good and potentially useful to uswsusp in the
   mainline kernel.  Do you really think nothing is worthwhile in there?

Are you really, really sure you're not rejecting suspend2 in bulk
because you didn't write it?  Do we need a John W. Linville as suspend
maintainer for things to go better?

Please tell me what is wrong in my perception of what is going on.

  OG, not even a suspend2 user.


[1] Look at s2ram.c and puke.  I understand it has been clobbed
together for testing and as such does not pretend to be of any
quality, but it's so bad it's painful.

[2] Otherwise you can start net5 in userspace just because it doesn't
absolutely need to be in kernelspace.
