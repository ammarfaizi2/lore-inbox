Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbWEGQvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWEGQvQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 12:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWEGQvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 12:51:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39623 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932201AbWEGQvO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 12:51:14 -0400
Date: Sun, 7 May 2006 09:50:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Risenhoover <prisenhoover@daxsolutions.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: GPF on Dell machines
Message-Id: <20060507095058.8f2cc4d3.akpm@osdl.org>
In-Reply-To: <445B7F4E.8030304@daxsolutions.com>
References: <445B7F4E.8030304@daxsolutions.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 May 2006 09:37:34 -0700
Paul Risenhoover <prisenhoover@daxsolutions.com> wrote:

> I've been getting the following error repeatedly on a number of machines 
> in my server farm.  Unfortunately, when this happens, the machine 
> becomes completely inoperable and must be hard booted.  These are 
> dual-processor Dell X64 machines . 

Unfortunately smbfs hasn't had a breathing maintainer for a couple of years
and I do not know anyone who knows the code much at all.  The stock answer
here is that you should migrate to cifs, which is maintained.

If you are for some reason not able to do that then please make the reasons
for this known to the cifs maintainer.

> Can anybody please help?  How can I make this stop?  Should I be posting 
> this to the samba mailing list instead?
> 
> May  3 12:35:04 neon kernel: general protection fault: 0000 [1] SMP
> May  3 12:35:04 neon kernel: last sysfs file: /class/vc/vcsa4/dev
> May  3 12:35:04 neon kernel: CPU 0
> May  3 12:35:04 neon kernel: Modules linked in: smbfs ipv6 parport_pc lp 
> parport autofs4 i2c_dev i2c_core rfcomm l2cap bluetooth sunrpc pcmcia
> yenta_socket rsrc_nonstatic pcmcia_core video button battery ac 
> e752x_edac edac_mc e1000 dm_snapshot dm_zero dm_mirror ext3 jbd dm_mod 
> ata_piix
>  libata sd_mod scsi_mod
> May  3 12:35:04 neon kernel: Pid: 21979, comm: smbiod Not tainted 
> 2.6.16-1.2069_FC4smp #1
> May  3 12:35:04 neon kernel: RIP: 0010:[<ffffffff882ea8ff>] 
> <ffffffff882ea8ff>{:smbfs:smbiod+520}

This oops is really hard to follow.  Without a
compiled-with-CONFIG_DEBUG_INFO kernel it'll be hard to work out where it
crashed.  And it appears that RH do not ship kernels with CONFIG_DEBUG_INFO
set.  Or maybe they do have that as a download somewhere; I don't know.

One option would be to self-compile a kernel with CONFIG_DEBUG_INFO and
when it crashes, do

cd /usr/src/linux
gdb /path/to/vmlinux
(gdb) l *0xffffffff882ea8ff

(substitute in the correct RIP value when doing this).


Sorry, no easy answers there.
