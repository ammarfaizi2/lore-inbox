Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268305AbUIBN0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268305AbUIBN0G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 09:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268307AbUIBN0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 09:26:06 -0400
Received: from soundwarez.org ([217.160.171.123]:15812 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S268305AbUIBN0B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 09:26:01 -0400
Date: Thu, 2 Sep 2004 15:26:09 +0200
From: Kay Sievers <kay.sievers@vrfy.org>
To: Daniel Stekloff <dsteklof@us.ibm.com>
Cc: Greg KH <greg@kroah.com>, Robert Love <rml@ximian.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040902132609.GB26413@vrfy.org>
References: <1093988576.4815.43.camel@betsy.boston.ximian.com> <20040831145643.08fdf612.akpm@osdl.org> <1093989513.4815.45.camel@betsy.boston.ximian.com> <20040831150645.4aa8fd27.akpm@osdl.org> <1093989924.4815.56.camel@betsy.boston.ximian.com> <20040902083407.GC3191@kroah.com> <1094126565.1761.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094126565.1761.25.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2004 at 05:02:46AM -0700, Daniel Stekloff wrote:
> On Thu, 2004-09-02 at 01:34, Greg KH wrote:
> > On Tue, Aug 31, 2004 at 06:05:24PM -0400, Robert Love wrote:
> > > +int send_kevent(enum kevent type, struct kset *kset,
> > > +		struct kobject *kobj, const char *signal);
> > 
> > Why is the kset needed?  We can determine that from the kobject.
> > 
> > How about changing this to:
> > 	int send_kevent(struct kobject *kobj, struct attribute *attr);
> > which just tells userspace that a specific attribute needs to be read,
> > as something "important" has changed.
> 
> 
> Do all events require an attribute? What about the "overheating"
> example? Would you need an attribute or would getting a "signal" for a
> specific kobj be enough? 

Hmm, both can be the case at the moment. We need to decide, if we want to
mandate the use of a sysfs attribute instead of the string value as the signal.

> Binding an attribute to an event would at least tell you the name of the
> attribute to check. Otherwise, how does an app know the name of the
> attribute that changed? Or am I missing something?

That's a valid point, right. If we don't use "verbs" as the signal string,
and know what we can expect from that particular kind of event, we don't
know which attribute has changed.


The remaining questions are:

o Do we want the multicast - "channels" for the events? It may be nice, to
  have it, if a application only interested in e.g. hotplug events, can get
  only the interesting events?

o What kind of signal do we need? A lazy string, a well defined set like
  ADD/REMOVE/CHANGE?
  Or can we get rid of the whole signal? But how can we distinguish between
  add and remove? Watching if the sysfs file comes or goes is not a option,
  I think.

Thanks,
Kay
