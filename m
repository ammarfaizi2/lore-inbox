Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263130AbUDBMRz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 07:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263586AbUDBMRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 07:17:55 -0500
Received: from mail.cyclades.com ([64.186.161.6]:34497 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263130AbUDBMRt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 07:17:49 -0500
Date: Fri, 2 Apr 2004 09:03:42 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Lewis Shobbrook <lshobbrook@fasttrack.net.au>
Cc: debian-testing@lists.debian.org, linux-kernel@vger.kernel.org
Subject: Re: md raid oops on 2.4.25/alpha
Message-ID: <20040402120342.GC1998@logos.cnet>
References: <0C8098CA7F09CE419F0C2B68EB8358761EB863@exchange.fasttrack.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0C8098CA7F09CE419F0C2B68EB8358761EB863@exchange.fasttrack.net.au>
User-Agent: Mutt/1.5.5.1i
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2004 at 04:53:01PM +1000, Lewis Shobbrook wrote:
> Hi All,
> 
> [Excerpt from linux-raid mailing list]
> > We have some problems with the md code on alpha. We get 
> > regular oops when using the md raid1. Here we got another 
> > oops when fsck (at boot 
> > time) the raid:
> > This was after a fresh reboot. As long as only the raid is 
> > *not* mounted of fsck the machine works without any oops.

There is a patch by Ivan against the MD code which avoids 
gcc3 < 3.3.3 from generating bad assembly code. This patch
is sitting now in the 2.4 BK tree. 

Have you guys tried that one?

> I've found similar results with the unstable Debian 2.4.25.-1-686
> kernel.
>  
> > I also can mount the hard disks *without* raid directly as 
> > hda1 and hdc1, and do NOT get any errors here, so I suspect 
> > that only the md code is the culprit.
> 
> Same again here.
> 
> I have /dev/hda2 listed in raidtab as a failed disc, lilo points to hda
> as boot.  I get kernel panic when attemtpting to boot to it.
> 
> I thought this strange as I have another system running the very same
> kernel (even used the same copied kernel deb) with a UU (no failed)raid
> 1 running off a hpt372 onboard controller (as soft md, not hardware raid
> 1).  The raid device was present prior to the kernel in this instance.
> I was impressed that the std initrd wokred with both md and hpt372
> without modification, where the process had been more involved in the
> past requiring a custom initrd or "compiled in" kernel.
> 
> I thought that the devfs (compiled in with the std debain kernel) may
> have been an issue, but it has never been in the past and the same
> filesystem on the raidtab listed "failed" drive /dev/hda2 is happy.
> 
> I can boot the the raid 1 as root filesystem when passing root=/dev/md0
> loading through a system rescue disc (http://www.sysresccd.org/) with a
> 2.4.25 kernel. 
> 
> Attempting to boot to /dev/md0  with the Debian 2.4.25-1-686 kernel
> panics after attempting to mount the device /dev2/root2 as ext2, minix &
> fat (possibly others that disappear before they can be read) and
> complains the std way when you attempt to mount with the wrong fs. 
> ...
> pivot_root: no such file or directory
> /sbin/init: 347: cannot open dev/console : no such file
> Kernel panic: Attempted to kill init !
> 
> I've attempted to pre-load the initrd modules, but didn't expect this to
> be a solution and it wasn't.
> 
> I'm scratching the head and losing hair...
> 
> Never had any trouble of this sort before.

Lewis, dont know what is going wrong here for you. Sorry.

