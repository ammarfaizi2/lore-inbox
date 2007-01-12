Return-Path: <linux-kernel-owner+w=401wt.eu-S1030480AbXALFZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030480AbXALFZx (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 00:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030489AbXALFZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 00:25:53 -0500
Received: from smtp.osdl.org ([65.172.181.24]:34020 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030480AbXALFZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 00:25:53 -0500
Date: Thu, 11 Jan 2007 21:25:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alberto Alonso <alberto@ggsys.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ext3 mounted as ext2 but journal still in effect.
Message-Id: <20070111212545.efd5d8c5.akpm@osdl.org>
In-Reply-To: <1168578496.9707.6.camel@w100>
References: <1168578496.9707.6.camel@w100>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jan 2007 23:08:16 -0600
Alberto Alonso <alberto@ggsys.net> wrote:

> I have an ext3 filesystem that has been having problems
> with its journal. The result is that the file system
> remounts internally as read-only and the server becomes
> unusable, even shutdown does not work, using up 100% of
> the CPU but not rebooting.
> 
> I found some postings indicating that mounting it as
> ext2 should fix the problem, as it doesn't appear to be
> a hardware issue.
> 
> So, I decided to mount everything as ext2. Mount shows this:
> 
> # mount
> /dev/hda2 on / type ext2 (rw,usrquota)
> none on /proc type proc (rw)
> none on /sys type sysfs (rw)
> none on /dev/pts type devpts (rw,gid=5,mode=620)
> usbfs on /proc/bus/usb type usbfs (rw)
> /dev/hda1 on /boot type ext2 (rw)
> none on /dev/shm type tmpfs (rw,noexec)
> none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)
> sunrpc on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw)
> 
> But now I still get the error:
> 
> # dmesg
> [...]
> EXT3-fs error (device hda2) in start_transaction: Journal has aborted
> EXT3-fs error (device hda2) in start_transaction: Journal has aborted
> EXT3-fs error (device hda2) in start_transaction: Journal has aborted
> EXT3-fs error (device hda2) in start_transaction: Journal has aborted
> [...]
> 
> 
> The kernel is:
> 
> # uname -a
> Linux hyperweb.net 2.6.5-1.358smp #1 SMP Sat May 8 09:25:36 EDT 2004
> i686 i686 i386 GNU/Linux
> 
> 
> Any ideas?
> 

mount(8) tells lies.  Look in /proc/mounts and you'll see that it's really
mounted as ext3.

You probably want to add `rootfstype=ext2' to the kernel boot command line.

