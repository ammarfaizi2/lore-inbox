Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268283AbUIBMtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268283AbUIBMtG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 08:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268290AbUIBMtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 08:49:05 -0400
Received: from soundwarez.org ([217.160.171.123]:11201 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S268283AbUIBMtB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 08:49:01 -0400
Date: Thu, 2 Sep 2004 14:49:08 +0200
From: Kay Sievers <kay.sievers@vrfy.org>
To: Greg KH <greg@kroah.com>
Cc: Robert Love <rml@ximian.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040902124908.GA26413@vrfy.org>
References: <1093988576.4815.43.camel@betsy.boston.ximian.com> <20040831145643.08fdf612.akpm@osdl.org> <1093989513.4815.45.camel@betsy.boston.ximian.com> <20040831150645.4aa8fd27.akpm@osdl.org> <1093989924.4815.56.camel@betsy.boston.ximian.com> <20040902083407.GC3191@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040902083407.GC3191@kroah.com>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2004 at 10:34:08AM +0200, Greg KH wrote:
> On Tue, Aug 31, 2004 at 06:05:24PM -0400, Robert Love wrote:
> > +int send_kevent(enum kevent type, struct kset *kset,
> > +		struct kobject *kobj, const char *signal);
> 
> Why is the kset needed?  We can determine that from the kobject.

I expect it's because:
  fill_kobj_path(struct kset *kset, struct kobject *kobj, char *path, int length)
  get_kobj_path_length(struct kset *kset, struct kobject *kobj)

and therefore the exported:
  kobject_get_path(struct kset *kset, struct kobject *kobj, int gfp_mask)

are all passing the kset. If they all are not needed, they can go too?

> How about changing this to:
> 	int send_kevent(struct kobject *kobj, struct attribute *attr);
> which just tells userspace that a specific attribute needs to be read,
> as something "important" has changed.

Hmm, in most cases this will work. But in mandates the creation of an
attribute instead of the lazy signal string. Yes, it would be nicer in
the long run and closer to the idea, that the whole event data should be
available through sysfs, but it may be hard to reach this in some subsystems.

> Will passing the attribute name be able to successfully handle the 
> "enum kevent" and "signal" combinations?

What should we do in the hotplug case? We may send a NULL attr for
the kset creation. But how can we distinguish between "add" and "remove"?
Just by looking if we find the sysfs dir? I'm not sure in this case.

Any ideas?

Thanks,
Kay
