Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751467AbWIGJwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbWIGJwr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 05:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWIGJwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 05:52:47 -0400
Received: from z2.cat.iki.fi ([212.16.98.133]:9359 "EHLO z2.cat.iki.fi")
	by vger.kernel.org with ESMTP id S1751467AbWIGJwq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 05:52:46 -0400
Date: Thu, 7 Sep 2006 12:52:44 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Chase Venters <chase.venters@clientec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bogofilter ate 3/5
Message-ID: <20060907095244.GW16047@mea-ext.zmailer.org>
References: <200609061856.k86IuS61017253@no.spam> <Pine.LNX.4.64.0609061409360.18840@turbotaz.ourhouse>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609061409360.18840@turbotaz.ourhouse>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2006 at 02:15:46PM -0500, Chase Venters wrote:
> On Wed, 6 Sep 2006, ellis@spinics.net wrote:
> 
> >>OK, but doing something could simply consist in adding a header
> >>that anyone is free to filter on or not.
> >
> >The problem with that is the post gets no indication that his
> >mail has been filtered. The way it works now is the rejection
> >happens at SMTP time and that causes the poster to see the
> >problem. If people filtered on a header, you'd never know why you
> >weren't getting a response.
> 
> How about this:
> 
> 1. Incoming mail from subscribers is accepted
> 2. Incoming mail to honeypot addresses is trained as SPAM
> 3. Incoming mail from non-subscribers is marked with X-Bogofilter:
> 4. A handy Perl script subscribes to lkml, and for any message it gets 
> with an X-Bogofilter: SPAM header, it sends a notification (rate-limited) 
> to the message sender explaining that his message will be filtered as SPAM 
> by some recipients, and inviting him to contact postmaster to resolve the 
> issue, and additionally letting him know that notification is rate-limited 
> and there is a website he can check to see the SUBJECTs of all messages 
> filtered as SPAM on lkml (say for the last week or two) if he wants to try 
> and correct the problem himself.


Actually...

At front-door the bogofilter analyzes message for spam-signature
and does classification.  It reports the class to SMTP receiver's
content policy controller, that usually chooses to believe it.

A number of recipient addresses are considered "filter free" and
they do always get messages no matter what BF or other content filters
consider the email.

The SMTP receiver also recognizes diffs in texts (but only when
unquoted) and exempts them of BF rulings (which sometimes do bite
on diffs.)


Honeypots train BF for SPAM.

Majordomo has tons of 'TABOO' filters and any match at them
trains BF also for SPAM.

Any message that was successfully accepted to any list is
trained as HAM.


I am considering teaching the system to recognize VGER's lists
specially, and to verify that sender is in the list, or at possible
extra 'posters' list.  (Did I create one, or did I plan only ?)
Anyway, if MAIL FROM address is at either, then message is again
exempted of Bogofilter.


Presently majordomo and front-end SMTP are not in any direct contact,
and that kind of policy decissions are not made at SMTP input time.
They are done silently a bit latter.

I can move most of the Majordomo policy rules to front-end policy
controller -- it is perl, after all  :-)


> Thanks,
> Chase

/Matti Aarnio -- one of  <postmaster@vger.kernel.org>
