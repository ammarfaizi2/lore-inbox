Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267294AbUIOVOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267294AbUIOVOz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 17:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267502AbUIOVGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 17:06:13 -0400
Received: from soundwarez.org ([217.160.171.123]:58779 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S267517AbUIOVDm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 17:03:42 -0400
Date: Wed, 15 Sep 2004 23:03:48 +0200
From: Kay Sievers <kay.sievers@vrfy.org>
To: Tim Hockin <thockin@hockin.org>
Cc: Robert Love <rml@novell.com>, Greg KH <greg@kroah.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040915210348.GA22376@vrfy.org>
References: <20040915034455.GB30747@kroah.com> <20040915194018.GC24131@kroah.com> <1095279043.23385.102.camel@betsy.boston.ximian.com> <20040915202234.GA18242@hockin.org> <1095279985.23385.104.camel@betsy.boston.ximian.com> <20040915203133.GA18812@hockin.org> <1095280414.23385.108.camel@betsy.boston.ximian.com> <20040915204754.GA19625@hockin.org> <1095281358.23385.109.camel@betsy.boston.ximian.com> <20040915205643.GA19875@hockin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915205643.GA19875@hockin.org>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 01:56:43PM -0700, Tim Hockin wrote:
> On Wed, Sep 15, 2004 at 04:49:18PM -0400, Robert Love wrote:
> > On Wed, 2004-09-15 at 13:47 -0700, Tim Hockin wrote:
> > 
> > > Are you not sending it with some specific device as the source?  Or is it
> > > just coming from some abstract root kobject?
> > 
> > It comes the the physical device.
> > 
> > Is there really a specific issue that you are seeing?
> 
> Well, two.
> 
> 1) If you send me an event "/dev/hda3 mounted", but it was for some other
> namespace, you just leaked potentially useful information.

You can listen only as root!
All information is already in /proc/mounts.

> I'm no security expert, but that seems to me to be a gratuitous leak.

I don't aggree on the second part :)

> Maybe it's just another example of why namespaces need to go away.
> 
> 2) If you send me an event "/dev/hda3 mounted" do I also get an event when
> I loopback mount /tmp/rh9.0-1.iso or when I bind mount /foo to /bar or
> when I mount server:/export/home on /home?

You get an event if fs-code claims/relases a genhd. It's a claim/release
event to be more precise. Only the first mount will emit a event and the
last umount.


thaks,
Kay
