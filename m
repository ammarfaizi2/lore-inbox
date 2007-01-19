Return-Path: <linux-kernel-owner+w=401wt.eu-S964801AbXASDXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbXASDXO (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 22:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbXASDXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 22:23:13 -0500
Received: from [69.26.161.131] ([69.26.161.131]:40262 "EHLO mail.ggsys.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S964801AbXASDXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 22:23:13 -0500
Subject: Re: Ext3 mounted as ext2 but journal still in effect.
From: Alberto Alonso <alberto@ggsys.net>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20070118220529.GA20862@win.tue.nl>
References: <1168578496.9707.6.camel@w100>
	 <20070111212545.efd5d8c5.akpm@osdl.org> <1168585021.9707.25.camel@w100>
	 <20070112144103.GA7685@ucw.cz>  <20070118220529.GA20862@win.tue.nl>
Content-Type: text/plain
Organization: Global Gate Systems LLC.
Date: Thu, 18 Jan 2007 21:23:07 -0600
Message-Id: <1169176987.1509.1.camel@w100>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you all for all your input. The tune2fs option was eventually
used and we run into other problems. I think Andries was right in
that the initrd was interfering, that's where we run into issues
after the tune2fs.

I was trying to avoid the tune2fs as it involves booting into
a live CD and brings the system down to where I can't access
it over the network (it is a 4 hour drive).

At the end we had to replace the drive and recreate all file
systems. If it ever happens again I will pay closer attention
to the initrd commands to see if the rootfstype=ext2 was overridden
with what's there.

Thanks,

Alberto

On Thu, 2007-01-18 at 23:05 +0100, Andries Brouwer wrote: 
> >> You were right, even after making the changes, it seems to be 
> >> telling lies:
> >> 
> >> # mount
> >> /dev/hda2 on / type ext2 (rw,usrquota)
> 
> Roughly speaking:
> /etc/mtab shows you what you said to mount.
> /proc/mounts shows what the current kernel state is.
> These may differ greatly.
> 
> For all filesystems mounted by you using mount(8), a line is added
> to /etc/mtab, where the contents of that line is related to the
> given mount command, but not to what the kernel did.
> 
> For the root filesystem, mount(8) writes an initial line in /etc/mtab
> taken from /etc/fstab. Again the information is from you, not from the kernel.
> 
> >> # dmesg | grep 'Kernel command'
> >> Kernel command line: ro root=/dev/hda2 rootfstype=ext2
> > ...
> >> /dev/root / ext3 rw 0 0
> 
> It would be a bad bug if the kernel mounted its root filesystem
> with a type different from the type given in "rootfstype=".
> But I see you use an initrd, and there can be all kinds of commands there.
-- 
Alberto Alonso                        Global Gate Systems LLC.
(512) 351-7233                        http://www.ggsys.net
Hardware, consulting, sysadmin, monitoring and remote backups

