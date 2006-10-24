Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422768AbWJXWqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422768AbWJXWqr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 18:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422778AbWJXWqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 18:46:47 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:52941 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1422768AbWJXWqq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 18:46:46 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [PATCH] Use extents for recording what swap is allocated.
Date: Wed, 25 Oct 2006 00:45:38 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
References: <1161576857.3466.9.camel@nigel.suspend2.net> <200610242208.34426.rjw@sisk.pl> <1161727981.22729.18.camel@nigel.suspend2.net>
In-Reply-To: <1161727981.22729.18.camel@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610250045.38812.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday, 25 October 2006 00:13, Nigel Cunningham wrote:
> Hi.
> 
> On Tue, 2006-10-24 at 22:08 +0200, Rafael J. Wysocki wrote:
> > On Monday, 23 October 2006 06:14, Nigel Cunningham wrote:
> > > Switch from bitmaps to using extents to record what swap is allocated;
> > > they make more efficient use of memory, particularly where the allocated
> > > storage is small and the swap space is large.
> > 
> > As I said before, I like the overall idea, but I have a bunch of comments.
> 
> Thanks for them. Just a quick reply for the moment to say they're
> appreciated and I will revise accordingly.
> 
> I should also mention that this isn't the only use of these functions in
> Suspend2.

Could we please focus on things that are on the table _now_?.  You are
submitting the patch aganist the current code and I can only review it
in this context.  I can't say if I like your _future_ patches at this moment! :-)

> There I also use extents to record the blocks to which the 
> image will be written. I hope to submit modifications to swsusp to do
> that too in the near future.
> 
> > > +/* Simplify iterating through all the values in an extent chain */
> > > +#define suspend_extent_for_each(extent_chain, extentpointer, value) \
> > > +if ((extent_chain)->first) \
> > > +	for ((extentpointer) = (extent_chain)->first, (value) = \
> > > +			(extentpointer)->minimum; \
> > > +	     ((extentpointer) && ((extentpointer)->next || (value) <= \
> > > +				 (extentpointer)->maximum)); \
> > > +	     (((value) == (extentpointer)->maximum) ? \
> > > +		((extentpointer) = (extentpointer)->next, (value) = \
> > > +		 ((extentpointer) ? (extentpointer)->minimum : 0)) : \
> > > +			(value)++))
> > 
> > This macro doesn't look very nice and is used only once, so I think you
> > can drop it and just write the loop where it belongs.
> 
> With the modifications I mentioned just above, this would also be used
> for getting the blocks which match each swap extent. I can remove the
> macro, but just want to make you aware that it does serve a purpose,
> you're just not seeing it fully yet.

Can we just assume there are no other patches and proceed under this
assumption?

Could you please remove the macro for now?  You can introduce it with the
other patches when you submit them (if it's still needed at that time).

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
