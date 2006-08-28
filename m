Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbWH1TLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWH1TLG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 15:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWH1TLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 15:11:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1689 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751357AbWH1TLF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 15:11:05 -0400
Date: Mon, 28 Aug 2006 12:10:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>, Kay Sievers <kay.sievers@suse.de>,
       Greg KH <greg@kroah.com>, andrew@digital-domain.net
Subject: Re: [Bugme-new] [Bug 7065] New: Devices no longer automount
Message-Id: <20060828121057.035fd690.akpm@osdl.org>
In-Reply-To: <200608281700.k7SH0CYl013187@fire-2.osdl.org>
References: <200608281700.k7SH0CYl013187@fire-2.osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2006 10:00:12 -0700
bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=7065
> 
>            Summary: Devices no longer automount

A post-2.6.17 regression, nicely bisected down to a particular changeset
(thanks!).

Is anyone else hitting this?


>     Kernel Version: 2.6.18-rc5
>             Status: NEW
>           Severity: normal
>              Owner: other_other@kernel-bugs.osdl.org
>          Submitter: andrew@digital-domain.net
> 
> 
> Most recent kernel where this bug did not occur:
> 2.6.17-git3
> 
> Distribution:
> Fedora Core 5
> 
> Hardware Environment:
> x86 UP (Athlon and P4)
> 
> Software Environment:
> FC5 + latest updates
> 
> Problem Description:
> When in GNOME and a USB storage device is plugged in, the device is no 
> longer mounted automatically. 
> 
> Steps to reproduce:
> When in GNOME, plug in a USB storage device e.g USB memory stick.
> 
> Seems uvents for the mount command are not being generated.
> 
> Last bit of output from udevmonitor for working kernel
> 
> UEVENT[1154789231.832312] add@/block/sda
> UEVENT[1154789231.834681] add@/block/sda/sda1
> UDEV [1154789231.836590] add@/class/scsi_device/9:0:0:0
> UDEV [1154789231.933474] add@/block/sda
> UDEV [1154789232.106892] add@/block/sda/sda1
> UEVENT[1154789235.937510] mount@/block/sda/sda1
> UDEV [1154789235.937510] mount@/block/sda/sda1
> 
> Last of bit of output from non-working kernel
> 
> UEVENT[1154789364.586896] add@/block/sda
> UEVENT[1154789364.586954] add@/block/sda/sda1
> UEVENT[1154789364.586963] add@/class/scsi_device/10:0:0:0
> UDEV [1154789364.598962] add@/class/scsi_device/10:0:0:0
> UDEV [1154789364.719350] add@/block/sda
> UDEV [1154789364.874149] add@/block/sda/sda1
> 
> 
> This regression happened between 2.6.17-git3 and 2.6.17-git4
> 
> A GIT bisect led to the following culprit.
> 
> 53877d06d53a412d901bb323f080296c363d8b51 is first bad commit
> commit 53877d06d53a412d901bb323f080296c363d8b51
> Author: Kay Sievers <kay.sievers@suse.de>
> Date:   Tue Apr 4 20:42:26 2006 +0200
> 
>     [PATCH] Driver core: bus device event delay
> 
>     split bus_add_device() and send device uevents after sysfs population
> 
>     Signed-off-by: Kay Sievers <kay.sievers@suse.de>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> :040000 040000 468b93360ff68fb133558a84f609731ddc2d846a
> 4db81e3af789cb7c0c3faea57a9f36ffa00732c3 M      drivers
> 
> 
> Reverting this patch fix'd the problem. Seems though that this is not the ideal
> solution.
> 
> ------- You are receiving this mail because: -------
> You are on the CC list for the bug, or are watching someone who is.
