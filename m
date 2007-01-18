Return-Path: <linux-kernel-owner+w=401wt.eu-S932659AbXARWd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932659AbXARWd3 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 17:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932663AbXARWd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 17:33:29 -0500
Received: from mailhost.tue.nl ([131.155.3.8]:61331 "EHLO mailhost.tue.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932659AbXARWd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 17:33:28 -0500
X-Greylist: delayed 1677 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Jan 2007 17:33:28 EST
Date: Thu, 18 Jan 2007 23:05:29 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Pavel Machek <pavel@ucw.cz>
Cc: Alberto Alonso <alberto@ggsys.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Ext3 mounted as ext2 but journal still in effect.
Message-ID: <20070118220529.GA20862@win.tue.nl>
References: <1168578496.9707.6.camel@w100> <20070111212545.efd5d8c5.akpm@osdl.org> <1168585021.9707.25.camel@w100> <20070112144103.GA7685@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070112144103.GA7685@ucw.cz>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> You were right, even after making the changes, it seems to be 
>> telling lies:
>> 
>> # mount
>> /dev/hda2 on / type ext2 (rw,usrquota)

Roughly speaking:
/etc/mtab shows you what you said to mount.
/proc/mounts shows what the current kernel state is.
These may differ greatly.

For all filesystems mounted by you using mount(8), a line is added
to /etc/mtab, where the contents of that line is related to the
given mount command, but not to what the kernel did.

For the root filesystem, mount(8) writes an initial line in /etc/mtab
taken from /etc/fstab. Again the information is from you, not from the kernel.

>> # dmesg | grep 'Kernel command'
>> Kernel command line: ro root=/dev/hda2 rootfstype=ext2
> ...
>> /dev/root / ext3 rw 0 0

It would be a bad bug if the kernel mounted its root filesystem
with a type different from the type given in "rootfstype=".
But I see you use an initrd, and there can be all kinds of commands there.
