Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264090AbUEXHYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264090AbUEXHYl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 03:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264095AbUEXHYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 03:24:41 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:13956 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264090AbUEXHYR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 03:24:17 -0400
Subject: Re: [PATCH] dynamic addition of virtual disks on PPC64 iSeries
From: Dave Hansen <haveblue@us.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       PPC64 External List <linuxppc64-dev@lists.linuxppc.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20040524170504.29a8d001.sfr@canb.auug.org.au>
References: <20040524162039.5f6ca3e0.sfr@canb.auug.org.au>
	 <20040523232920.2fb0640a.akpm@osdl.org>
	 <20040524170504.29a8d001.sfr@canb.auug.org.au>
Content-Type: text/plain
Message-Id: <1085383408.20577.7.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 24 May 2004 00:23:28 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-24 at 00:05, Stephen Rothwell wrote:
> On Sun, 23 May 2004 23:29:20 -0700 Andrew Morton <akpm@osdl.org> wrote:
> > Or to generate a hotplug event when a disk is added?  Even if there's no
> > notification to the kernel, it should be possible to generate the hotplug
> > events in response to a /proc-based trigger.
> 
> I guess that would be possible.  In this case I am trying to do the
> minimum change.

I think this would be a worthy change.  It's the same kind of thing that
we're planning for memory hotplug on ppc64: initiate a probe in /sys
somewhere, and get a few hotplug events in short order.  The only
difference is that we'll probably require a write for the probe to
trigger.  You don't want a 'grep -r foo /sys' to cause probes, do you?

> +       printk(VIOD_KERN_INFO "disk %d: %lu sectors (%lu MB) "
> +                       "CHS=%d/%d/%d sector size %d%s\n",
> +                       dev_no, (unsigned long)(d->size >> 9),
> +                       (unsigned long)(d->size >> 20),
> +                       (int)d->cylinders, (int)d->tracks,
> +                       (int)d->sectors, (int)d->bytes_per_sector,
> +                       d->read_only ? " (RO)" : "");
> +

Isn't it a little naughty to be spitting out so many values in a /sys
file?  

-- Dave

