Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262464AbTCMQfH>; Thu, 13 Mar 2003 11:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262465AbTCMQfH>; Thu, 13 Mar 2003 11:35:07 -0500
Received: from unthought.net ([212.97.129.24]:36284 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S262464AbTCMQfC>;
	Thu, 13 Mar 2003 11:35:02 -0500
Date: Thu, 13 Mar 2003 17:45:48 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: linux-kernel@vger.kernel.org
Cc: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: NetFlow export
Message-ID: <20030313164547.GC29730@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	linux-kernel@vger.kernel.org, Florian Weimer <fw@deneb.enyo.de>
References: <87adfza5kb.fsf@deneb.enyo.de> <20030313114809.GA29730@unthought.net> <87znnz8oob.fsf@deneb.enyo.de> <20030313122932.GB29730@unthought.net> <87llzj8jmr.fsf@deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87llzj8jmr.fsf@deneb.enyo.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 13, 2003 at 02:46:04PM +0100, Florian Weimer wrote:
> Jakob Oestergaard <jakob@unthought.net> writes:
> 
> > You asked for netflow data export. Netramet can give you something
> > similar to netflow (I never used netflow, but from what I hear, netramet
> > is similar only more flexible).
> 
> I need the NetFlow data format, not something else.

Ok.

I suspect it's easier to patch netramet, than start a new kernel-based
project.

If Netramet really supports reading netflow data, I guess it would not
be a huge undertaking to implement write support too.   But I'm not
familiar with the Netramet source - really, you should look at it
yourself or ask the developers.

> 
> > With 10 lines of Perl you could do full ASN-1   ;)
> 
> NetFlow is not based on ASN.1.

No you said that  :)

> It's a completely different format (an
> industry standard which is implemented by quite a few vendors).

Ok

> 
> > Point being; if what you want is flow information from a Linux router,
> > excellent user space software (both "meter" and retrieval/filtering
> > tools) already exist for that.
> 
> I fear the performance impact of copying all packet headers to user
> space.

I understand.

But I don't think you need to worry - how much bandwidth and how many
flows are we looking at here?

Several million flows a day is no problem for an aging PIII 550 (running
with full BGP).

Netramet allows you to define what makes a flow - so depending on your
needs, you can set the detail versus performance pretty much as you
please.  It has a simple rule language (SRL) to define these filtering
rules.

> 
> > If you want something else, then I have completely misread your mails.
> > Please elaborate, in that case  :)
> 
> I'd like to see something which has virtually no impact on forwarding,
> so that it's a no-brainer to enable it.  I doubt copying all the
> packet headers to user space falls into this category.

Well, netramet is not going to do the routing.  Whatever netramet does,
the packets will flow.

Worst case, netramet is going to miss a flow.  If you did it in the
kernel instead, I guess you could either do it the same way, or make the
router drop packets when load gets too high.  I think the current
solution works well.  For the loads that I have seen - maybe you have
other kinds of loads...

Netramet allocates a buffer it uses for holding the flows. If the
"meter" is not emptied frequently enough, netramet may decide to drop
the oldest/smallest flows, to make room for new ones.

This buffer, on a relatively busy router, can easily be 50-100 MB.
This, too, is a good reason to keep it in user space I think.

The kernel memory footprint is bad enough with the routing tables that
full BGP causes.

I think that you should measure and experiemnt - verify that there
really is a problem with a user-space solution, before even thinking
about doing something relatively complicated (and already existing) in
kernel space.

Wheels don't necessarily turn faster just because you re-invent them in
the kernel  ;)

Well that's my 0.02 Euro, at least.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
