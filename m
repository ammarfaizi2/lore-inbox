Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423881AbWKAEoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423881AbWKAEoZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 23:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423623AbWKAEoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 23:44:25 -0500
Received: from mail.gmx.de ([213.165.64.20]:52113 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161636AbWKAEoZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 23:44:25 -0500
X-Authenticated: #14349625
Subject: Re: 2.6.19-rc3-mm1 -- missing network adaptors
From: Mike Galbraith <efault@gmx.de>
To: Greg KH <gregkh@suse.de>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>,
       "Martin J. Bligh" <mbligh@google.com>,
       Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
In-Reply-To: <20061031213126.GA596@suse.de>
References: <454631C1.5010003@google.com> <45463481.80601@shadowen.org>
	 <20061030211432.6ed62405@gondolin.boeblingen.de.ibm.com>
	 <1162276206.5959.9.camel@Homer.simpson.net> <4546EF3B.1090503@google.com>
	 <20061031065912.GA13465@suse.de> <4546FB79.1060607@google.com>
	 <20061031075825.GA8913@suse.de> <45477131.4070501@google.com>
	 <20061031174639.4d4d20e3@gondolin.boeblingen.de.ibm.com>
	 <20061031213126.GA596@suse.de>
Content-Type: text/plain
Date: Wed, 01 Nov 2006 05:44:09 +0100
Message-Id: <1162356249.6105.21.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-31 at 13:31 -0800, Greg KH wrote:
> On Tue, Oct 31, 2006 at 05:46:39PM +0100, Cornelia Huck wrote:
> > On Tue, 31 Oct 2006 07:52:17 -0800,
> > "Martin J. Bligh" <mbligh@google.com> wrote:
> > 
> > > >>> Merely change CONFIG_SYSFS_DEPRECATED to be set to yes, and it should
> > > >>> all work just fine.  Doesn't anyone read the Kconfig help entries for
> > > >>> new kernel options?
> > > >> 1. This doesn't fix it.
> > > > 
> > > > I think acpi is now being fingered here, right?
> > > 
> > > Eh? How. Backing out all your patches from -mm fixes it.
> > > The deprecated stuff does not fix it, it's the same as before.
> > 
> > That's because /sys/class/net/<interface> is now a symlink instead of a
> > directory (and that hasn't anything to do with acpi, but rather with
> > the conversions in the driver tree). Seems the directory -> symlink
> > change shouldn't be done since it's impacting user space...
> 
> If you enable CONFIG_SYSFS_DEPRECATED, then there is no symlink and
> there is no userspace change.  sysfs should look identical to before.
> 
> Or did I miss something doing this work?

Something is amiss, because it's still a symlink here.

With driver-core-fixes-sysfs_create_link-retval-checks-in.patch reverted
so I can boot, I get the below both in my patched up 2.6.19-rc3 and
2.6.19-rc3-mm1.

strace -vf /sbin/getcfg eth0
lstat64("/sys/class/net/eth0", {st_dev=makedev(0, 0), st_ino=4480, st_mode=S_IFLNK|0777, st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=0, st_size=0, st_atime=2006/11/01-05:00:15, st_mtime=2006/11/01-05:59:54, st_ctime=2006/11/01-05:59:54}) = 0

file /sys/class/net/eth0
/sys/class/net/eth0: symbolic link to `../../devices/pci0000:00/0000:00:1e.0/0000:02:09.0/eth0'

grep DEPRECATED .config
CONFIG_SYSFS_DEPRECATED=y
# CONFIG_PM_SYSFS_DEPRECATED is not set


