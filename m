Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261686AbVBXAYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbVBXAYo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 19:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbVBXAYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 19:24:12 -0500
Received: from waste.org ([216.27.176.166]:28807 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261686AbVBXARU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 19:17:20 -0500
Date: Wed, 23 Feb 2005 16:17:00 -0800
From: Matt Mackall <mpm@selenic.com>
To: Mathieu Segaud <Mathieu.Segaud@crans.org>
Cc: Andrew Morton <akpm@osdl.org>, Helge Hafting <helge.hafting@aitel.hist.no>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc4-mm1 : IDE crazy numbers, hdb renumbered to hdq ?
Message-ID: <20050224001700.GG3163@waste.org>
References: <20050223014233.6710fd73.akpm@osdl.org> <421C7FC2.1090402@aitel.hist.no> <20050223121207.412c7eeb.akpm@osdl.org> <878y5eq2c4.fsf@barad-dur.crans.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878y5eq2c4.fsf@barad-dur.crans.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2005 at 12:32:59AM +0100, Mathieu Segaud wrote:
> Andrew Morton <akpm@osdl.org> disait derni??rement que :
> 
> > Helge Hafting <helge.hafting@aitel.hist.no> wrote:
> >>
> >> This kernel came up, but my boot script complained about no /dev/hdb3
> >>  when trying to mount /var.
> >>  (I have two IDE disks on the same cable, and an IDE cdrom on another.)
> >>  They are usually hda, hdb, and hdc.
> >> 
> >>  MAKEDEV hdq did not help.  Looking at sysfs, it turns out that
> >>  /dev/hdq1 is at major:3 minor:1025 if I interpret things right. 
> >>  (/dev/hda1 is at 3:1, which is correct.)
> >>  These numbers did not work with my mknod, it created 7:1 instead.
> >>  So I didn't get to test this mysterious device.
> >> 
> >>  But I assume this is a mistake of some sort, I haven't heard about any
> >>  change in the IDE numbering coming up?  2.6.1-rc3-mm1 works as expected.
> >> 
> >>  It may be interesting to note that my root raid-1 came up fine,
> >>  consisting of hdq1 and hda1 instead of the usual hdb1 and hda1.
> >
> > I don't know what could be causing that.  Please send .config.  If you set
> > CONFIG_BASE_FULL=n, try setting it to `y'.
> 
> I've got the same problem here on my box, udev creates hds and hdu
> entries when running 2.6.11-rc4-mm1, whereas it creates correctly hdf
> et hdh, on other kernels.

Are these misnamed and misnumbered devices mountable? If not, can you
mknod device nodes at the proper major:minor location and have them
work?

Seems ->disk_name is getting modified between ide_setup() and
add_disk() somehow, giving us:

hdb: ...
 hdq: hdq1 hdq2...

-- 
Mathematics is the supreme nostalgia of our time.
