Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267189AbUIODn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267189AbUIODn2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 23:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267184AbUIODn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 23:43:27 -0400
Received: from mail.kroah.org ([69.55.234.183]:17116 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267189AbUIODnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 23:43:04 -0400
Date: Tue, 14 Sep 2004 20:42:29 -0700
From: Greg KH <greg@kroah.com>
To: Tim Hockin <thockin@hockin.org>
Cc: Robert Love <rml@ximian.com>, Kay Sievers <kay.sievers@vrfy.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040915034229.GA30747@kroah.com>
References: <20040906020601.GA3199@vrfy.org> <20040910235409.GA32424@kroah.com> <1094875775.10625.5.camel@lucy> <20040911165300.GA17028@kroah.com> <20040913144553.GA10620@vrfy.org> <20040915000753.GA24125@kroah.com> <20040915010901.GA19524@vrfy.org> <20040915011146.GA27782@hockin.org> <1095214229.20763.6.camel@localhost> <20040915031706.GA909@hockin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915031706.GA909@hockin.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 08:17:06PM -0700, Tim Hockin wrote:
> On Tue, Sep 14, 2004 at 10:10:29PM -0400, Robert Love wrote:
> > > I don't have any concrete examples right now, but it seems that this is
> > > being locked down pretty tightly for no real reason...
> > > 
> > > Just a passing thought.
> > 
> > I am fearful of the overly strict lock down, too.  I mean, we already
> > ditched the entire payload.
> 
> Yeah, it's much reduced in flexibility from where it started.

That's because the original proposal was not very well defined at all.

> > But so long as you can always add a new action, what complaint do you
> > have?  In other words, all this does is force the use of the enum, which
> > ensures that we try to reuse existing actions, prevent typos, and so on.
> 
> Well, it will be what it will be, I think.  I know several people who
> wanted it to be more than it is turning out to be, but that's not
> unexpected.  Of course we can cope with what it is.

Who are those people?  What did people want it to be that it now is not?
Will they not speak up publicly?  If not, how do they expect it to
address things they want?

> What I think we'll find is that fringe users will hack around it.  It will
> become a documentum that the "insert" event of a Foo really means
> something else.  People will adapt to the limited "verbs" and overload
> them to mean whatever it is that they need.

Since when did I ever state that the verbs would be "limited"?  One of
the original issues that people were worried about was the possiblity of
a typo in a verb that we would be forced to live with.  The patch I just
proposed fixes that issue.

All new "verbs" will be submitted to the same kind of review that any
other portion of the kernel code would be subjected to.  Nothing wrong
with that, right?

> As much as we all like to malign "driver hardening", there is a *lot* that
> can be done to make drivers more robust and to report better diagnostics
> and failure events.

I agree.  But this interface is not designed or intended for that.  

> I'd like to have a standardized way to spit things like ECC errors up to
> userspace, but I don't think that's what Greg K-H wants these used for.

You are correct.  I also would like to see a way ECC and other types of
errors and diagnostics be sent to userspace in a common and unified
manner.  But I have yet to see a proposal to do this that is acceptable.

> I'd like to ACPI events move to a standardized event system, but they
> *require* a data payload.

Great, that also would be wonderful.  Create such a event system for
ACPI if you desire.  I think the ACPI developers are still working on
bigger issues currently.

> There are *way* too many places (IMHO) where we throw a printk() and punt,
> or do something which is less than ideal.  If I had my druthers, we would
> examine most places that call printk() at runtime (not startup, etc) and
> figure out if an event makes more sense.

Please do.

> This model serves well for "eth0 has a link" and "hda1 was mounted" sorts
> of events. [Though namespaces make mounting a lot of fun.  Which namespace
> was it mounted on?  Why should my app in namespace X see an event about
> namespace Y?]

Yeah, namespaces are interesting :)

> If that is all it's good for, then it is better than nothing, though not
> as good as it might be.

Patches are always welcome.

thanks,

greg k-h
