Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161240AbWBUAww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161240AbWBUAww (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 19:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161241AbWBUAww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 19:52:52 -0500
Received: from main.gmane.org ([80.91.229.2]:56275 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161240AbWBUAww (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 19:52:52 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andreas Happe <andreashappe@snikt.net>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Tue, 21 Feb 2006 00:52:07 +0000 (UTC)
Message-ID: <slrndvkp1m.326.andreashappe@localhost.localdomain>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <1140437152.3429.20.camel@mindpipe> <20060220123122.GA6086@dspnet.fr.eu.org> <200602201513.23849.rjw@sisk.pl> <20060220153922.GA17362@dspnet.fr.eu.org> <slrndvjrfb.2o0.andreashappe@localhost.localdomain> <20060220173608.GC33155@dspnet.fr.eu.org>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: client068.9220.easyline.at
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-02-20, Olivier Galibert <galibert@pobox.com> wrote:
> On Mon, Feb 20, 2006 at 04:27:24PM +0000, Andreas Happe wrote:
>> Why (when LZF would be useful for other stuff) nobody proposed inclusion
>> of it?
>
> You missed all the messages of people who would like it in cryptoloop
> for compressed filesystems?

then why isn't it in mainline then?

> Part of the problem it seems with Nigel's code is that it is stamped
> "suspend2", and nobody looks for useful code in there.

I seem to remember critisims of various aspects of the suspend2 patch
(bitmaps etc., and those were not from neither Pavel or Rafael).

> It hasn't worked for me reliably on any of the dell laptops we have
> around.  Driver problem, irq problem, who knows.  Pavel would sure
> like to have these problems fixed, no doubt about that, but uswsusp
> has nothing to do with fixing them.

And the answer to your bug reports were?

> The entire point of uswsusp is to have progress bars, compression and
> encryption.  It has _nothing_ to do with the reliability of suspend
> itself.

Well.. progress bars, compression and encryption are the advantages that
suspend2 seems to have over swsusp in my current situation. (encryption
somewhat dances out of line as this was already supported by swsusp).

> Suspend2 already has the progress bars and stuff.  Hence the "already
> done and working".

I do not really care about that stuff, swsusp works reliable for me. If
it crashes for you maybe some bug reports or even debugging would be way
more productive than those endless 'swsusp vs suspend2' debates.

>> > 1- will uswsusp solve problems suspend2 doesn't?  Real, currently
>> > encountered problems, not philosophical problems about
>> > kernel/userspace code positions[2].
>> 
>> swsusp works for me (TM), no problems at all, siree
>
> That does not answer the question.  If there are no problems with
> swsusp, there is no need for either suspend2 or uswsusp.

couldn't be stated clearer. Remember that only the users for which
swsusp doesn't work will state their problems (or those that want more
bling).

Although there seems to be a need for bling and encryption which can
perfectly done in userspace (compare that to bootsplash vs. usplash).

>> so submit driver specific patches through the driver's maintainer?
>> Where does Pavel enter the picture?
>
> Pavel is the swsusp maintainer.  Pavel is the one defining the
> interfaces drivers have to conform to to play ball.  Quality and
> documentation of these interfaces is what makes the difference when
> you have to use them in the drivers.

I thought that those driver changes would mostly be power mgmt changes..
that would the existing infrastructure (i.e. maintained by Patrick
Mochel).

>> > 3- if the main problem is really that some parts of suspend2 should
>> > be in userspace instead of kernelspace, why aren't you working from
>> > the appropriate parts of the suspend2 code to port them to
>> > userspace use instead of going to coreutils/libLZF/etc?
>> 
>> code dupplication?
>
> Duplicating what?  There are multiple implementations, some in
> suspend2, some in libraries.  The suspend2 ones, as kernel routines,
> are designed to work in a constrained environment, fs, network and
> memory-wise.  The library ones aren't.  Uswsusp needs code that works
> in a constrained environment.  So the technically clueful way is to
> start from the libraries?

libraries will be used by more people -> more testing and bug fixes (for
'free'). The constraints should relate to hard disk/hardware activity?
memory usage shouldn't be that much of a problem (and the userspace
parts are used for transformations.. and if you can't trust in a working
libopenssl.. you're already hosed).

> For some people, like you, swsusp works as-is.  Good.  For some more
> people, swsusp doesn't work reliably, while suspend2 does.  So there
> are some things in suspend2 that are better than the current
> implementation.

I think that 'some people, like you' may be more than you think.

I tried to use suspend2, but setup wasn't that great (i.e. didn't work
as well or easy as swsusp) so I dropped it.

> I see zero effort to find out what these things are 

Than pray do it. I think patches would be welcomed.

> I don't like seeing anymore throwing of the baby with the bathwater
> going on than strictly necessary.

So you think the maintainer to be competent but you don't believe they
got valid technical reasons to deny those patches? Have you seen the
module support for suspend thread? or the bitmap thread? Those were not
simple problems.

> Obviously not.  I think networking belongs to the kernel, and moving
> things to userspace because it somehow magically makes maintenance
> easier is complete bullshit.  I have criteria to decide what should be
> in the kernel and what should be in userspace, and networking squarely
> belongs in kernelspace.

Encryption and compression for non-timecritical tasks: User or
kernelspace? The other stuff would be driver fixes (which would be
accepted) or infrastructure changes (rafael is at least interested in
bdev freezing, other stuff like using bitmaps seem totaly not acceptable
(and weren't for rather long.. but nigel didn't seem to mind)).

[BTW: the network stuff was about performance (reduced code
complexitivity was just a side effect). Maintenance isn't easier, but
the chances that you totally fsck up a system is smaller in userspace
than in kernel space).

Andy

