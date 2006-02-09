Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422919AbWBIRZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422919AbWBIRZG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 12:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422918AbWBIRZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 12:25:06 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:14479 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP
	id S1422919AbWBIRZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 12:25:04 -0500
Date: Thu, 9 Feb 2006 18:25:04 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Marc Koschewski <marc@osknowledge.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH GIT] drivers/block/ub.c - misc. cleanup/indentation, removed unneeded return
Message-ID: <20060209172504.GC5710@stiffy.osknowledge.org>
References: <mailman.1139418724.17734.linux-kernel2news@redhat.com> <20060208194057.55b02719.zaitcev@redhat.com> <20060209092143.GA5676@stiffy.osknowledge.org> <20060209085501.0a29c7e7.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060209085501.0a29c7e7.zaitcev@redhat.com>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.16-rc2-marc-g0bdd340c-dirty
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pete Zaitcev <zaitcev@redhat.com> [2006-02-09 08:55:01 -0800]:

> On Thu, 9 Feb 2006 10:21:43 +0100, Marc Koschewski <marc@osknowledge.org> wrote:
> 
> > > But the rest is quite bad, the worst being indenting the switch statement.
> > 
> > I see. Why do you use if-statement-indenting then?
> 
> Insides of case blocks are indented, didn't you notice? Why waste a tab?

The 'case' block are, however, _within_ the switch, thus they need to be
indented - just my 2 cents. But OK ...

> 
> > What is the sense of the empty comments? What sense does the 'immediate
> > return' make when the value is returned 2 lines below (where one line is just
> > a closing brace)?
> 
> Empty comments segregate related groups of functions.
>

Didn't know. Is there any documentation on this _really_ helpful mechanism?

> 
> The return is there in case something else is needed between the if and

OK, so why is _any_

	if (1)
		get_lost;

stuff left there without the braces? I guess one day there _could_ another
line to lead to 

	if (1) {
		beat_it;
		get_lost;
	}

where the braces are definitely missing. You could also have pinned the return
there when it was needed. And for now it's definitely not. Maybe for readability.
But that's another thing...

> the function's end. It's there to underscore the regular structure of the
> code. Though the big block comment obscures the intent there. Perhaps
> I should relocate it.

.. to be discussed right here. You're snippet is not _more readable_ due to the
return. Any when it comes to such things as 'return the rc right now as we're
setup and ready' I could point out some other locations where the rc is set, the
code did its setup for ie. a device and many if-statements follow but no change
to rc is made. Why not use 'immediate return' there?

Maybe on could clarify for me.

> 
> You didn't mention empty lines on top of functions. They appear where
> variables are likely to be, or if the function body has a break, to make
> it fair to all little segments :-)

I did understand the fact that one line-breaks the function declaration. But I
don't understand the need to put a blank line where someday a var could
defined.

I could put another 60 blank lines somewhere just in case some vendor brings any
device that needs some special treatment on init or something.

> 
> > > Is there nothing else you can do in the whole kernel?
> > 
> > Sure, but I guess you don't have to tell me what files I put my nose in, do
> > you? I didn't mean to personally piss you off by sending this in. Tzzz ...
> > 
> > Unfortunately my understanding of how ie. the Linux VM works is not very good.
> > In fact it's poor. But I will dig into this and try to make even you happy with
> > a patch that makes sense _in your eyes_.
> 
> I don't know anything about VM either and I do not see how this is
> relevant.

It was just an example. To me it looks like some sorta 'this is my code and you
please let your finger off it'-thing. I do understand that whitespace/indenting-only
patches are just about to get us in trouble when it comes to other patches
applied to the tree as ie. Andi Kleen stated in 'Re: [PATCH] early_printk:
cleanup trailiing whitespace' today.

The remove-return-thing, however, was not a whitespace thing. I still disagree
it makes the code more readable or whatever. It's just redundant as this time.
When there's a need, we could add it.

> 
> The bigger point is, if you strive to make a meaningful contribution,
> meaningless code rearrangements is not the way to go about it. And
> we have plenty of work under the subsystem level, though usually it
> has something to do with specific hardware. For example, Firewire
> appears to be in dire need of fixing right now.

OK, let's face it: I don't have any FireWire hardware around. Not even a cable.
So I'm not gonna do anyting there.

I just stumbled upon the ub.c code on my way to get my USB chipcard reader module
from crashing when it's unloaded. The patch just exists because I read the file
and wondered what all these comments should 'comment' if now comment was
actually in there.

> 
> I remember a period of time when the janitoring project produced
> meaningful cleanups, such as verification of failure paths. This work
> is still relevant. Just the other day I sent a patch to Dmitry for
> a leak in mousedev. And remember the debacle of memset(p, size, 0)!
> I'm not going to tell you where to put your nose in, but I would like
> to hint that the janitoring project might use some help with something
> going beyond the uglification of my pretty code :-)

Could you point me to some location?

> 
> -- Pete
> 

Marc
