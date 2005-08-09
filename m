Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbVHITEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbVHITEF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 15:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbVHITEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 15:04:05 -0400
Received: from mta6.srv.hcvlny.cv.net ([167.206.4.201]:22584 "EHLO
	mta6.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1750786AbVHITEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 15:04:04 -0400
Date: Tue, 09 Aug 2005 15:04:13 -0400
From: Robert Wilkens <robw@optonline.net>
Subject: Re: Signal handling possibly wrong
In-reply-to: <42F8F98B.3080908@fujitsu-siemens.com>
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <1123614253.3167.18.camel@localhost.localdomain>
MIME-version: 1.0
X-Mailer: Evolution 2.2.3
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <42F8EB66.8020002@fujitsu-siemens.com>
 <1123612016.3167.3.camel@localhost.localdomain>
 <42F8F6CC.7090709@fujitsu-siemens.com>
 <1123612789.3167.9.camel@localhost.localdomain>
 <42F8F98B.3080908@fujitsu-siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[resent - previous message not properly addressed]

It says "signal is blocked, UNLESS SA_NODEFER is used.."

Which means if NODEFER is used, it's not masked (SA_NOMASK)..

I don't understand how i'm wrong (maybe I have mental problems that are
worse than I thought).  If you want to explain off-list or on-list
(depending on whether others are getting annoyed at me) you can.  Or
just ignore me and i'll go away and someone else who wants to look at it
can.

-Rob
On Tue, 2005-08-09 at 20:44 +0200, Bodo Stroesser wrote:
> Robert Wilkens wrote:
> > Bodo,
> > 
> > SA_MASK is a flag... Which you use to tell it what to do with the data
> > you've given it and/or it gets.  You gave it sa_mask (lower-case).
> > SA_NOMASK means don't use the mask -- the pseudonym (new-word) for
> > SA_NOMASK is SA_NODEFER (renamed, perhaps, because it may defer some or
> > all signals rather than throwing them away, you probably can receive the
> > waiting signals by clearing the SA_NODEFER flag on a subsequent call).
> > 
> > If you want to take this off-list, I'm OK with that..
> > 
> > Please describe what you would expect SA_NODEFER to do in your own
> > language if you don't understand what I seem to understand.
> > 
> > -Rob
> > On Tue, 2005-08-09 at 20:32 +0200, Bodo Stroesser wrote:
> > 
> 
> Sorry, unfortunately you are not right. See this (from man page for sigaction):
> 
> struct sigaction {
>                    void (*sa_handler)(int);
>                    void (*sa_sigaction)(int, siginfo_t *, void *);
>                    sigset_t sa_mask;
>                    int sa_flags;
>                    void (*sa_restorer)(void);
>                }
> 
> Please read the text about element sa_mask of struct sigaction to
> understand what I'm talking about.
> 
> Regards
> 	Bodo
> 
> 
> >>Robert Wilkens wrote:
> >>
> >>>>Kernel code blocks both "handled signal" _and_ sa_mask only if SA_NODEFER
> >>>>isn't set.
> >>>>
> >>>>Which is the right behavior?
> >>>
> >>>
> >>>Perhaps both?
> >>>
> >>>I'm novice here, but if i'm reading the man page correctly, it says:
> >>>
> >>>SA_NODEFER
> >>>   Do not prevent the signal from being received from within
> >>>   its  own  signal handler. 
> >>>	(they also imply that SA_NOMASK is the old name for this,
> >>>	which might make it clear what it's use is).
> >>>
> >>>In which case blocking (masking) when it's not set is exactly what it's
> >>>supposed to do.
> >>>
> >>>-Rob
> >>
> >>Yes. That's true.
> >>
> >>But what about sa_mask? Description of SA_NODEFER and sa_mask both do not
> >>say, that usage of sa_mask depends on SA_NODEFER.
> >>But kernel only uses sa_mask, if SA_NODEFER isn't set.
> >>
> >>So, I think man page and kernel are not consistent.
> >>
> >>	Bodo
> >>-
> >>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >>the body of a message to majordomo@vger.kernel.org
> >>More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

