Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbVDYXJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVDYXJx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 19:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbVDYXJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 19:09:52 -0400
Received: from fire.osdl.org ([65.172.181.4]:55248 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261280AbVDYXJt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 19:09:49 -0400
Date: Mon, 25 Apr 2005 16:09:25 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Nagesh Sharyathi <sharyathi@in.ibm.com>
Cc: vgoyal@in.ibm.com, akpm@osdl.org, ebiederm@xmission.com,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
       maneesh@in.ibm.com
Subject: Re: [Fastboot] Re: Kdump Testing
Message-Id: <20050425160925.3a48adc5.rddunlap@osdl.org>
In-Reply-To: <OFB57B3D45.D8C338C5-ON65256FEE.0042F961-65256FEE.0043D4CB@in.ibm.com>
References: <1114227003.4269c13be5f8b@imap.linux.ibm.com>
	<OFB57B3D45.D8C338C5-ON65256FEE.0042F961-65256FEE.0043D4CB@in.ibm.com>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2005 17:45:43 +0530
Nagesh Sharyathi <sharyathi@in.ibm.com> wrote:

> vgoyal@in.ltcfwd.linux.ibm.com wrote on 23/04/2005 09:00:03:
> 
> > Quoting "Eric W. Biederman" <ebiederm@xmission.com>:
> 
> > > Nagesh Sharyathi <sharyathi@in.ibm.com> writes:
> > >
> > > > Here is the console boot log, before the machine jumps to BIOS
> > > > after hang during panic kerenl boot
> > >
> > > Ok thanks.  So this is manually triggered with SysRq
> > > and the kexec part works but the recover kernel simply fails
> > > to boot.
> > >
> > > It looks like that hunk of the ACPI code that messes up maxcpus=1
> > > needs to be looked at.
> 
> > It works well with Uniporcessor capture kernel. For the time being 
> sufficient
> > to capture the dump but it is always good idea to be able to boot 
> > and SMP kernel
> > as well.
> > 
> > Vivek
> I verified on my machine where earlier kdump used to fail and after 
> disabling CONFIG_SMP(ie CONFIG_SMP=n) crash kernel boots properly and I am 
> able to take the memory dump


Thanks for those hints.  However, my testing didn't go quite
as well as that.


2.6.12-rc2-mm3 reboots vmlinux-recover-UP on panic.
(vmlinux-recover-SMP hangs during [early] reboot, but -UP
goes further....)

(BTW, how does I do serial console from the second
kernel...?  It has the drivers, but not the command
line info?  TBD.)

vmlinux-recover-UP gets to this point, hand-written,
several lines missing:

kfree_debugcheck: bad ptr c3dbffb0h.  ( == %esi)
kernel BUG at <bad filename>:23128!
invalid operand: 0000 [#1]
DEBUG_PAGEALLOC
EIP is at kfree_debugcheck+0x45/0x50

Stack dump shows lots of ext3 cache and inode functions...

On a dual-proc P4 with 1 GB RAM.
-- 
~Randy
