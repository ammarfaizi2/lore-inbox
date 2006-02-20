Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161056AbWBTRRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161056AbWBTRRD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 12:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161062AbWBTRRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 12:17:03 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:22162 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1161067AbWBTRQ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 12:16:56 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Olivier Galibert <galibert@pobox.com>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Mon, 20 Feb 2006 18:16:55 +0100
User-Agent: KMail/1.9.1
Cc: kernel list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602201513.23849.rjw@sisk.pl> <20060220153922.GA17362@dspnet.fr.eu.org>
In-Reply-To: <20060220153922.GA17362@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602201816.56232.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 February 2006 16:39, Olivier Galibert wrote:
> On Mon, Feb 20, 2006 at 03:13:23PM +0100, Rafael J. Wysocki wrote:
}-- snip --{
> From what I see of the messages in this thread, at that point you're
> just trying to play catchup with suspend2.

Well, I don't think I am.  Or maybe a little.  Still, are you trying to say that
GNOME developers should give up because KDE is more advanced in some
respects or vice versa?

> Don't that feel a little strange to you?  You know you have working GPL code
> handy, tested with happy users, with a maintainer who would be happy to have
> it in the kernel, and instead of making it better you spend your talents redoing
> the same functionality only slightly differently.  Why?

_I_ am doing it as a proof of concept.  Many people said it didn't make sense
to implement this in the user space and that it wouldn't work, and it would
take ages to do this etc.  I don't agree with that and I want to show I'm right.
Is that wrong?

> > > Right now it really looks like they're only 
> > > trying to redo what's already in suspend2, tested and debugged, only
> > > different and new, hence untested and undebugged.
> > 
> > Actually a lot of the code that we use _has_ _been_ tested and debugged,
> > because it _is_ used on a daily basis by many people, like eg.:
> > - MD5 from the coreutils package,
> > - libLZF (the original one)
> > (openSSL wil be used soon for the image encryption).
> > 
> > And I'm not trying to redo suspend2 in the user space.  Instead I'm trying
> > to use the code that's _already_ _available_ in the user space to obtain
> > the functionality that suspend2 implements in the kernel space.
> 
> "obtaining the functionality that suspend2 implements" means "redoing
> suspend2".

No, it doesn't.  By the same token you could say writing another mail
client is redoing Mozilla Thunderbird.

> Don't play on words, please.

I don't.  I really _think_ it's not the same. :-)

> md5 is already in the kernel (twice).  lzf is already in suspend2 (and
> arguably useful for more things than only suspending),

Now seriously.  Nigel already _had_ submitted the LZF patch, but it 
was not accepted by the cryptoAPI maintainers.  Neither me, nor Pavel
took part in that.  The same applies to many things in suspend2,
just browse the LKML archives for the record.

> so suspend2's implementation has been tested for use in a suspend context,
> while libLZF hasn't.  You _will_ have bugs putting things together, that's a
> given.

You're probably right.

> Now explain me why you're tying together code from coreutils and other
> sources when you have the same code, only already tested in a suspend
> context (memory management, etc), in suspend2.

Sorry, it's not like that.  The memory management is not done by the
userland part, it's done by the kernel.  The role of the userland part
is to read the image from the kernel, transform it (compress/encrypt/whatever)
if needed and save to disk.  All that.

> Why, for the image save, did you port the code from swsusp with for instance
> its lack of async i/o, instead of porting the suspend2 code?

Because suspend2 code is incompatible with what's in the kernel now.

To use the suspend2 code I'd have to modify the kernel code substantially, and
that's what Pavel didn't want.  OTOH the swsusp code was known to work
and I used it to test the new code, too.

> > The problem is to merge suspend2 we'd have to clean it up first and
> > actually solve some problems that it works around.  That, arguably,
> > would be more work than just implementing some _easy_ stuff in the
> > user space.
> 
> Stuff that is _already_ _done_ and working.

Functionality-wise, your right.  The problem is how it's done, I think, and
that is not so obvious.

> Be careful though, you're awfully close to saying that userspace code
> is easier because it isn't reviewed[1] while kernel code has higher
> standards.

Oh, come on.  You can review it, everybody can.  Moreover, you're welcome to
do this. :-)

}-- snip --{
>    The constraints on userland suspend code are rather close to RT kernel
>    code, so  technically it would be a much better base.

Can you please tell me why do you think so?

> 4- why aren't you actively working at pushing the parts of suspend2
>    that actually are good and potentially useful to uswsusp in the
>    mainline kernel.  Do you really think nothing is worthwhile in there?

Because there are no patches to work on?  I'd _really_ love to work on patches
that modify the current kernel code _gradually_ instead of just trying to
replace it top-down with something else in one big shot.

For example, I'd really appreciate it if Nigel could prepare a patch against
the current -mm implementing the freezing of bdevs he was talking about,
and there are more things like that.

> Are you really, really sure you're not rejecting suspend2 in bulk
> because you didn't write it?

Oh, _I_ am not rejecting it.  I've never said so.  I just don't think there's
a chance it will be merged in the short run, for various reasons, so
I'm working on an alternative.

}-- snip --{ 
> Please tell me what is wrong in my perception of what is going on.

I think you are assuming I'm doing this to prevent suspend2 from being merged.
It is not so, as I've tried to explain above.  If you don't accept my point of view,
I'll respect that.

Greetings,
Rafael

PS
I didn't write s2ram, so I can't comment your observations wrt it.
