Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264941AbTLRFOn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 00:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264943AbTLRFOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 00:14:42 -0500
Received: from fw.osdl.org ([65.172.181.6]:62933 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264941AbTLRFOk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 00:14:40 -0500
Date: Wed, 17 Dec 2003 21:15:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.0
Message-Id: <20031217211516.2c578bab.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0312171951030.5789@home.osdl.org>
References: <Pine.LNX.4.58.0312171951030.5789@home.osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> Andrew has written up some caveats and pointers to information about 2.4.x
>  vs 2.6.x changes, and I'll let him post that. Some known issues were not
>  considered to be release-critical and a number of them have pending fixes
>  in the -mm queue. Generally they just didn't have the kind of verification
>  yet where I was willing to take them in order to make sure a fair 2.6.0
>  release.

It's actually rather short because I started late.  See below.

There are also the "must-fix" and "should-fix" lists of items which we have
identified as still on the 2.6 todo list.  These are at

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/must-fix/must-fix-7.txt and
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/must-fix/should-fix-7.txt




- The 2.6.0 kernel has undergone several weeks of stabilization and we
  expect it to run well on server-class machines.

  Desktops and laptops may have more trouble at this time because of the
  much wider range of hardware and because of as-yet unimplemented fixes for
  the hardware and BIOS bugs from which these machines tend to suffer.

  During the 2.6.0 stabilization period a significant number of less
  serious fixes have accumulated in various auxiliary kernel trees and these
  shall be merged into the 2.6 stream after the 2.6.0 release.  Many of these
  fixes appear in Andrew Morton's "-mm" tree, at

	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/

- Please report any problems to the appropriate mailing list.  If you do
  not know which list to use, send the report to linux-kernel@vger.kernel.org
  and it should reach the right person.  Some active subsystem mailing lists
  are:

	linux1394-devel@lists.sourceforge.net
	linux-xfs@oss.sgi.com
	linux-acpi@intel.com
	linux-scsi@vger.kernel.org
	ext2-devel@lists.sourceforge.net
	linux-usb-users@lists.sourceforge.net

  Alternatively, kernel bug reports may be entered into the kernel bug
  tracking system at http://bugme.osdl.org/

- There are significant changes in the module subsystem, the LVM (Device
  Mapper) and RAID subsystems.  Details about these and many other kernel
  changes are presented in David Jones's kernel upgrade document at

	http://www.linux.org.uk/~davej/docs/post-halloween-2.6.txt

  Users who are testing 2.6 kernels for the first time should consult this
  document.

- The ATA RAID drivers (eg the HighPoint RAID driver) have not been ported
  to the new BIO code and are not available under the 2.6 kernel at this
  time.

- cryptoloop doesn't work on highmem machines.  Fixes exist in -mm and are
  queued for 2.6.1.

- There are known performance problems with the default disk I/O scheduler
  which show up when the workload is performing small, random reads and
  writes (ie: database loads).  Largely fixed in -mm.

  In general, the "deadline" I/O scheduler is, and shall remain somewhat
  faster than the default "anticipatory" I/O scheduler with these sorts of
  workloads.  Database admins should consider adding the "elevator=deadline"
  kernel boot parameter.

- There are performance problems due to misbehaviour in the readahead code
  which also impact database-style workloads.  Fixed in -mm, queued for
  2.6.1.

- There are a larger number of as-yet unmerged frame buffer driver fixes.


