Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267504AbUIOVB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267504AbUIOVB2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 17:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267452AbUIOVA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 17:00:26 -0400
Received: from [66.35.79.110] ([66.35.79.110]:1477 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S267433AbUIOU4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 16:56:52 -0400
Date: Wed, 15 Sep 2004 13:56:43 -0700
From: Tim Hockin <thockin@hockin.org>
To: Robert Love <rml@novell.com>
Cc: Greg KH <greg@kroah.com>, Kay Sievers <kay.sievers@vrfy.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040915205643.GA19875@hockin.org>
References: <1095211167.20763.2.camel@localhost> <20040915034455.GB30747@kroah.com> <20040915194018.GC24131@kroah.com> <1095279043.23385.102.camel@betsy.boston.ximian.com> <20040915202234.GA18242@hockin.org> <1095279985.23385.104.camel@betsy.boston.ximian.com> <20040915203133.GA18812@hockin.org> <1095280414.23385.108.camel@betsy.boston.ximian.com> <20040915204754.GA19625@hockin.org> <1095281358.23385.109.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095281358.23385.109.camel@betsy.boston.ximian.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 04:49:18PM -0400, Robert Love wrote:
> On Wed, 2004-09-15 at 13:47 -0700, Tim Hockin wrote:
> 
> > Are you not sending it with some specific device as the source?  Or is it
> > just coming from some abstract root kobject?
> 
> It comes the the physical device.
> 
> Is there really a specific issue that you are seeing?

Well, two.

1) If you send me an event "/dev/hda3 mounted", but it was for some other
namespace, you just leaked potentially useful information.

I'm no security expert, but that seems to me to be a gratuitous leak.
Maybe it's just another example of why namespaces need to go away.

2) If you send me an event "/dev/hda3 mounted" do I also get an event when
I loopback mount /tmp/rh9.0-1.iso or when I bind mount /foo to /bar or
when I mount server:/export/home on /home?

If you're notifying me of mounts and unmounts, I really want to know about
all of them, not just mounts that have a hard local device.  I'd rather
get "something was mounted" and be forced to probe that (that's a leak,
too, but less important).

Tim
