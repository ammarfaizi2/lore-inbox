Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161049AbVLOErl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161049AbVLOErl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 23:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161051AbVLOErl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 23:47:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:25813 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161049AbVLOErk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 23:47:40 -0500
Subject: Re: "block" symlink in sysfs for a multifunction device
From: Jeremy Katz <katzj@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20051214234255.GA3275@kroah.com>
References: <20051212134904.225dcc5d.zaitcev@redhat.com>
	 <20051214055019.GA23036@kroah.com>
	 <20051214152615.13b6b105.zaitcev@redhat.com>
	 <20051214234255.GA3275@kroah.com>
Content-Type: text/plain
Date: Wed, 14 Dec 2005 23:47:35 -0500
Message-Id: <1134622055.2864.21.camel@bree.local.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.2 (2.5.2-1.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-14 at 15:42 -0800, Greg KH wrote:
> On Wed, Dec 14, 2005 at 03:26:15PM -0800, Pete Zaitcev wrote:
> > On Tue, 13 Dec 2005 21:50:19 -0800, Greg KH <greg@kroah.com> wrote:
> > > $ ls -l /sys/block/uba/device/
> > > -r--r--r--  1 root root 4096 Dec 13 21:31 bNumEndpoints
> > > lrwxrwxrwx  1 root root    0 Dec 13 21:31 block:uba -> ../../../../../../block/uba
> > > lrwxrwxrwx  1 root root    0 Dec 13 21:31 block:ubb -> ../../../../../../block/ubb
> > > lrwxrwxrwx  1 root root    0 Dec 13 21:31 block:ubc -> ../../../../../../block/ubc
> > > lrwxrwxrwx  1 root root    0 Dec 13 21:31 block:ubd -> ../../../../../../block/ubd
> > 
> > Greg, Jeremy is not happy about this.
> > 
> > > https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=175563
> > > ------- Additional Comments From katzj@redhat.com  2005-12-14 18:05 EST -------
> > > Actually, this is problematic.  It makes it so that the single device directory
> > > corresponds to more than one device which we can't handle with kudzu :-(
> 
> Well, how do you handle it for class devices then?

We don't have any where we need to handle it at present.  

> And if this isn't acceptable, what would be?

By going this route, it really feels like you're hacking around your own
rule of a single value per file :-)  Except that instead of having a
file that I read five values from, it's five files with naming
heuristics to get five values.  Which is, in a lot of ways, worse.

I'd much rather see the fact that there are multiple devices be handled
by having each device with its own unique directory.  This then keeps
all of the abstractions which currently exist.

Jeremy

