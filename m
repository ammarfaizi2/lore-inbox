Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269717AbUJMOPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269717AbUJMOPd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 10:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269719AbUJMOPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 10:15:33 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:20398 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id S269717AbUJMONt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 10:13:49 -0400
Message-ID: <416D380E.4080202@t-online.de>
Date: Wed, 13 Oct 2004 16:13:34 +0200
From: "Harald Dunkel" <harald.dunkel@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Mathieu Segaud <matt@minas-morgul.org>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: udev: what's up with old /dev ?
References: <1097446129l.5815l.0l@werewolf.able.es>	<20041012001901.GA23831@kroah.com> <416B91C4.7050905@t-online.de>	<20041012165809.GA11635@kroah.com> <416C26B4.6040408@t-online.de>	<20041012185733.GA31222@kroah.com> <416C3BB6.4040200@t-online.de>	<20041012203022.GB32139@kroah.com> <416C4E15.9000503@t-online.de> <87vfde3gvs.fsf@barad-dur.crans.org>
In-Reply-To: <87vfde3gvs.fsf@barad-dur.crans.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: bRcQwqZSre4uP933hJH56s2ynvMuSyGQQlcaXcvKm+YrWgSqWTdSsn
X-TOI-MSGID: 63f4bdcf-4866-4c0c-a4ad-fb815965b75f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Segaud wrote:
> 
> huh, well initrd is / that is mounted over the so-called _rootfs_
> initramfs is here to _be_ that rootfs. So no pivot_root needed and the run-it
> program included in klibc tarballs takes care of wiping-out everything that
> could waste memory into the initramfs before mounting the real /. 
> If it was to compiled out of the kernel, it would just be an initrd....
> 
> rootfs is _needed_ for mounting the real root, so is initramfs.
> 

So the kernel boots, activates the initramfs somehow to
become the first /, and then starts /sbin/init (e.g. kinit
from the klibc package).

And then?

The sources of kinit show that its job is parse the kernel
command line arguments, configure the NIC, mount the root
filesystem via NFS, etc. Other configurations might require
a different init to start hotplug and udev, or to handle the
LVM and crypto magic, for example. My point is that if there
is no one-for-all init process to handle _every_ possible
startup procedure, then it might be necessary to rebuild the
initramfs. This would be easier (and easier to test) if
initramfs is not compiled into the kernel, but a separate
image to be loaded at boot time "somehow".

Or did I miss something?


Regards

Harri
