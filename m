Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161005AbWBTQ1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161005AbWBTQ1z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 11:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161007AbWBTQ1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 11:27:54 -0500
Received: from main.gmane.org ([80.91.229.2]:59025 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161005AbWBTQ1y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 11:27:54 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andreas Happe <andreashappe@snikt.net>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Mon, 20 Feb 2006 16:27:24 +0000 (UTC)
Message-ID: <slrndvjrfb.2o0.andreashappe@localhost.localdomain>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <1140437152.3429.20.camel@mindpipe> <20060220123122.GA6086@dspnet.fr.eu.org> <200602201513.23849.rjw@sisk.pl> <20060220153922.GA17362@dspnet.fr.eu.org>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: client068.9220.easyline.at
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-02-20, Olivier Galibert <galibert@pobox.com> wrote:
> On Mon, Feb 20, 2006 at 03:13:23PM +0100, Rafael J. Wysocki wrote:
>> Actually a lot of the code that we use _has_ _been_ tested and debugged,
>> because it _is_ used on a daily basis by many people, like eg.:
>> - MD5 from the coreutils package,
>> - libLZF (the original one)
>> (openSSL wil be used soon for the image encryption).
>> 
>> And I'm not trying to redo suspend2 in the user space.  Instead I'm trying
>> to use the code that's _already_ _available_ in the user space to obtain
>> the functionality that suspend2 implements in the kernel space.
>
> "obtaining the functionality that suspend2 implements" means "redoing
> suspend2".  Don't play on words, please.

through using the userspace helper he is able to use existing maintained
libaries, something that isn't possible with kernelspace suspend. This
is real code reduction.

> md5 is already in the kernel (twice).  lzf is already in suspend2 (and
> arguably useful for more things than only suspending),

Why (when LZF would be useful for other stuff) nobody proposed inclusion
of it?

>> The problem is to merge suspend2 we'd have to clean it up first and
>> actually solve some problems that it works around.  That, arguably,
>> would be more work than just implementing some _easy_ stuff in the
>> user space.
>
> Stuff that is _already_ _done_ and working.

While reading this 'discussion' I get the expression that swsusp isn't
working. But this isn't true: it works for me since I can't remember
when. The only problems were with some modules (ieee1394 had to be
unloaded before suspending) and minor glinches (writing the image
sometimes _very_ slow when suspending from a powersave cpufreq
governor..).

> 1- will uswsusp solve problems suspend2 doesn't?  Real, currently
>    encountered problems, not philosophical problems about
>    kernel/userspace code positions[2].

swsusp works for me (TM), no problems at all, siree

>    In particular, since according
>    to Pavel 90+% of the problems are driver issues, why aren't you
>    concentrating on drivers?

so submit driver specific patches through the driver's maintainer? Where
does Pavel enter the picture?

> 3- if the main problem is really that some parts of suspend2 should be
>    in userspace instead of kernelspace, why aren't you working from the
>    appropriate parts of the suspend2 code to port them to userspace use
>    instead of going to coreutils/libLZF/etc?

code dupplication?

> 4- why aren't you actively working at pushing the parts of suspend2
>    that actually are good and potentially useful to uswsusp in the
>    mainline kernel.  Do you really think nothing is worthwhile in there?

Maybe the mentioned problems with bitmaps and the module infrastructure
could explain that. Even Nigel said that the problem with evolutionary
patches is that suspend2 changes some fundamentals.

> Are you really, really sure you're not rejecting suspend2 in bulk
> because you didn't write it?  Do we need a John W. Linville as suspend
> maintainer for things to go better?

Are you really threatening Pavel's position as maintainer? how subtle.

> Please tell me what is wrong in my perception of what is going on.
>
>   OG, not even a suspend2 user.

andy, a long time swsusp user.

> [2] Otherwise you can start net5 in userspace just because it doesn't
> absolutely need to be in kernelspace.

it seems like "Van Jacobson's network channels" [0] would move some
stuff to userspace. Are you volunteering? (dislaimer: I have just
glimpsed at the article).

[0] http://lwn.net/Articles/169961/

