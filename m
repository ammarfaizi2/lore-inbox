Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbVBWXOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbVBWXOx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 18:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbVBWXOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 18:14:04 -0500
Received: from waste.org ([216.27.176.166]:64744 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261677AbVBWXLo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 18:11:44 -0500
Date: Wed, 23 Feb 2005 15:11:30 -0800
From: Matt Mackall <mpm@selenic.com>
To: Laurent Riffard <laurent.riffard@free.fr>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Helge Hafting <helge.hafting@aitel.hist.no>
Subject: Re: 2.6.11-rc4-mm1 : IDE crazy numbers, hdb renumbered to hdq ?
Message-ID: <20050223231130.GF3163@waste.org>
References: <20050223014233.6710fd73.akpm@osdl.org> <421C7FC2.1090402@aitel.hist.no> <20050223121207.412c7eeb.akpm@osdl.org> <421D0582.9090100@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421D0582.9090100@free.fr>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2005 at 11:36:50PM +0100, Laurent Riffard wrote:
> Le 23.02.2005 21:12, Andrew Morton a ?crit :
> >Helge Hafting <helge.hafting@aitel.hist.no> wrote:
> >
> >>This kernel came up, but my boot script complained about no /dev/hdb3
> >>when trying to mount /var.
> >>(I have two IDE disks on the same cable, and an IDE cdrom on another.)
> >>They are usually hda, hdb, and hdc.
> >>
> >>MAKEDEV hdq did not help.  Looking at sysfs, it turns out that
> >>/dev/hdq1 is at major:3 minor:1025 if I interpret things right.
> >>(/dev/hda1 is at 3:1, which is correct.)
> >>These numbers did not work with my mknod, it created 7:1 instead.
> >>So I didn't get to test this mysterious device.
> >>
> >>But I assume this is a mistake of some sort, I haven't heard about any
> >>change in the IDE numbering coming up?  2.6.1-rc3-mm1 works as expected.
> >>
> >>It may be interesting to note that my root raid-1 came up fine,
> >>consisting of hdq1 and hda1 instead of the usual hdb1 and hda1.
> >
> >
> >I don't know what could be causing that.  Please send .config.  If you set
> >CONFIG_BASE_FULL=n, try setting it to `y'.
> >
> 
> this is just a "me too"...
> 
> Here is some few lines from dmesg :
> 
> hdb: cache flushes supported
>  hdq: hdq1 hdq2 < hdq5 hdq6 hdq7 hdq8 >

Neat.

> ~$ ls -l  /dev/hd*
> brw-rw----  1 root    disk   3,    0 f?v 23 22:45 /dev/hda
> brw-rw----  1 root    disk   3,    1 f?v 23 22:45 /dev/hda1
> brw-rw----  1 root    disk   3,   10 f?v 23 22:45 /dev/hda10
> brw-rw----  1 root    disk   3,    2 f?v 23 22:45 /dev/hda2
> brw-rw----  1 root    disk   3,    3 f?v 23 22:45 /dev/hda3
> brw-rw----  1 root    disk   3,    4 f?v 23 22:45 /dev/hda4
> brw-rw----  1 root    disk   3,    5 f?v 23 22:45 /dev/hda5
> brw-rw----  1 root    disk   3,    6 f?v 23 22:45 /dev/hda6
> brw-rw----  1 root    disk   3,    7 f?v 23 22:45 /dev/hda7
> brw-rw----  1 root    disk   3,    8 f?v 23 22:45 /dev/hda8
> brw-rw----  1 root    disk   3,    9 f?v 23 22:45 /dev/hda9
> brw-rw----  1 laurent cdrom 22,    0 f?v 23 22:45 /dev/hdc
> brw-------  1 root    root  22,   64 f?v 23 22:45 /dev/hdd
> brw-rw----  1 root    disk   3, 1024 f?v 23 22:45 /dev/hdq

Looks like you're using udev. 

> CONFIG_BASE_FULL=y
> CONFIG_BASE_SMALL=0

Ok, that's unrelated to the weird IDE numbering then.

-- 
Mathematics is the supreme nostalgia of our time.
