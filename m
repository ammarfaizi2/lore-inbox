Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266903AbUIODRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266903AbUIODRQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 23:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266910AbUIODRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 23:17:16 -0400
Received: from [66.35.79.110] ([66.35.79.110]:16827 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S266903AbUIODRN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 23:17:13 -0400
Date: Tue, 14 Sep 2004 20:17:06 -0700
From: Tim Hockin <thockin@hockin.org>
To: Robert Love <rml@ximian.com>
Cc: Kay Sievers <kay.sievers@vrfy.org>, Greg KH <greg@kroah.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040915031706.GA909@hockin.org>
References: <20040905121814.GA1855@vrfy.org> <20040906020601.GA3199@vrfy.org> <20040910235409.GA32424@kroah.com> <1094875775.10625.5.camel@lucy> <20040911165300.GA17028@kroah.com> <20040913144553.GA10620@vrfy.org> <20040915000753.GA24125@kroah.com> <20040915010901.GA19524@vrfy.org> <20040915011146.GA27782@hockin.org> <1095214229.20763.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095214229.20763.6.camel@localhost>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 10:10:29PM -0400, Robert Love wrote:
> > I don't have any concrete examples right now, but it seems that this is
> > being locked down pretty tightly for no real reason...
> > 
> > Just a passing thought.
> 
> I am fearful of the overly strict lock down, too.  I mean, we already
> ditched the entire payload.

Yeah, it's much reduced in flexibility from where it started.

> But so long as you can always add a new action, what complaint do you
> have?  In other words, all this does is force the use of the enum, which
> ensures that we try to reuse existing actions, prevent typos, and so on.

Well, it will be what it will be, I think.  I know several people who
wanted it to be more than it is turning out to be, but that's not
unexpected.  Of course we can cope with what it is.

What I think we'll find is that fringe users will hack around it.  It will
become a documentum that the "insert" event of a Foo really means
something else.  People will adapt to the limited "verbs" and overload
them to mean whatever it is that they need.

As much as we all like to malign "driver hardening", there is a *lot* that
can be done to make drivers more robust and to report better diagnostics
and failure events.

I'd like to have a standardized way to spit things like ECC errors up to
userspace, but I don't think that's what Greg K-H wants these used for.

I'd like to ACPI events move to a standardized event system, but they
*require* a data payload.

There are *way* too many places (IMHO) where we throw a printk() and punt,
or do something which is less than ideal.  If I had my druthers, we would
examine most places that call printk() at runtime (not startup, etc) and
figure out if an event makes more sense.

This model serves well for "eth0 has a link" and "hda1 was mounted" sorts
of events. [Though namespaces make mounting a lot of fun.  Which namespace
was it mounted on?  Why should my app in namespace X see an event about
namespace Y?]

If that is all it's good for, then it is better than nothing, though not
as good as it might be.

Tim
