Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbTJ3QzU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 11:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbTJ3QzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 11:55:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:53638 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262652AbTJ3QzI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 11:55:08 -0500
Date: Thu, 30 Oct 2003 08:52:22 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Post-halloween doc updates.
Message-Id: <20031030085222.3874483e.rddunlap@osdl.org>
In-Reply-To: <20031030141519.GA10700@redhat.com>
References: <20031030141519.GA10700@redhat.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Oct 2003 14:15:19 +0000 Dave Jones <davej@redhat.com> wrote:

|                      The post-halloween document. v0.46
|                         (aka, 2.6 - what to expect)
|                     Dave Jones <davej@codemonkey.org.uk>
|                           (Updated as of 2.6.0test9)

| Known gotchas.
| ~~~~~~~~~~~~~~
| Certain known bugs are being reported over and over. Here are the
| workarounds.
| - Can't load any modules? You need updated tools (See modules section below).

  - depmod reports Unresolved symbols?  depmod from modutils instead of
    depmod from module-init-tools is first in $PATH (might be different
    $PATHs as $USER and $ROOT)

| Regressions.
| ~~~~~~~~~~~~
| - Some filesystems still need work (Intermezzo, UFS, HFS, HPFS..)

    + EFS (has a blocksize problem, depending on the device that the
      filesystem is being mounted on)

| Modules.
| ~~~~~~~~
| - Modules now have a .ko suffix instead of .o

    Some (older) versions of 'mkinitrd' don't search for modules
    that end with .ko, so update your mkinitrd if this is a problem.

[
or is this invalid since initrd isn't used any more?
if that's the case, mention it in here somewhere...
need to add anything about initramfs?
]


| Nanosecond stat:
| ~~~~~~~~~~~~~~~~
| The stat64() syscall got changed to return jiffies granularity.
| This allows make(1) to make better decisions on whether or not it
| needs to recompile a file. Not all filesystems may support such precision.

General comment/change:  use 'was changed' instead of 'got changed' (above).
This is the second or third instance that I've noticed where 'got'
should/would better be 'was', so if you would do a global search and
conditional replace for those, that would be Good.


| Generic VFS changes.
| ~~~~~~~~~~~~~~~~~~~~
| - Since Linux 2.5.1 it is possible to atomically move a subtree to
|   another place. The call is...
                       s/call/usage/
|    mount --move olddir newdir


| sysfs.
| ~~~~~~
| In simple terms, the sysfs filesystem is a saner way for
| drivers to export their innards than /proc.
| This filesystem is always compiled in, and can be mounted
| just like another virtual filesystem. No userspace tools
| beyond cat and echo are needed.

  'tree' is also nice for viewing it.

|     mount -t sysfs none /sys
| 
| See Documentation/filesystems/sysfs.txt for more info.
| 
| 
| 
| SELinux.
| ~~~~~~~~
| NSA Security-Enhanced Linux (SELinux) got merged in 2.6.
| It is disabled by default and can be enabled with a boot time parameter
| selinux=1.
| You can obtain SELinux tools and an example policy configuration from
| http://www.nsa.gov/selinux

Somebody correct me here if needed...
selinux can't just be enabled by using 'selinux=1', if the config
options are set for checking that.
The way that I read security/selinux/Kconfig and hooks.c,
if SECURITY_SELINUX_BOOTPARAM is enabled, then the 'selinux'
boot option is also enabled.  However, it can be disabled by using
'selinux=0' as a kernel boot option.

| Networking.
| ~~~~~~~~~~~
| - Users of boxes with >1 NIC may find that for eg, eth0 and eth1 refer to
|   the opposites of what they did in 2.4.   This is a bug that will be fixed
|   before 2.6.0.  One option (or management workaround) for this is to use

It will be?  It's time to do it then, if it's not already done...

|   'nameif' to name Ethernet interfaces.  There is a HOWTO for doing this at
|   <http://xenotime.net/linux/doc/network-interface-names.txt>

| - SCTP (Stream Control Transport Protocol)

RFC 2960 - Stream Control Transmission Protocol



Overall a very good job, Dave.  Thanks for keeping this updated.

--
~Randy
