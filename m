Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268051AbTGLQgR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 12:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268089AbTGLQgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 12:36:17 -0400
Received: from mail-7.tiscali.it ([195.130.225.153]:34145 "EHLO
	mail-7.tiscali.it") by vger.kernel.org with ESMTP id S268051AbTGLQfR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 12:35:17 -0400
Date: Sat, 12 Jul 2003 18:45:42 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org, acpi-support@lists.sourceforge.net
Subject: Re: [ACPI-sppt] Re: [2.5.75] S3 and S4
Message-ID: <20030712164542.GA1157@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mail-Followup-To: Pavel Machek <pavel@suse.cz>,
	linux-kernel@vger.kernel.org, acpi-support@lists.sourceforge.net
References: <20030711193611.GA824@dreamland.darkstar.lan> <20030711200053.GA402@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030711200053.GA402@elf.ucw.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Fri, Jul 11, 2003 at 10:00:53PM +0200, Pavel Machek ha scritto: 
> > =unlinkd entered refrigerator
> > =master entered refrigerator
> > =pickup entered refrigerator
> 
> You have "interesting" processes on your machine ;).

Hum, unlinkd is part of squid, master and pickup are part of postfix ;)

> If e100. You have the hardware...
[cut]
> > I'm a bit  worried about these MCEs, but the  machine seems stable after
> > resume (btw,  I remeber that Alan  once posted a MCE  decoder, but can't
> > find it - any clue?).
> 
> Not sure what it is. MCEs should be hardware fault, always...

If I  rmmod e100  before sleeping  everything is fine,  but I  still get
those MCEs.

> > Fixing swap signatures... <3>bad: scheduling while atomic!
> > Call Trace:
> >  [<c012419e>] schedule+0x6ce/0x6e0
> >  [<c02a219d>] generic_make_request+0x17d/0x210
> >  [<c01272d0>] autoremove_wake_function+0x0/0x50
> >  [<c012641e>] io_schedule+0xe/0x20
> >  [<c0150522>] wait_on_page_bit+0xa2/0xd0
> >  [<c01272d0>] autoremove_wake_function+0x0/0x50
> >  [<c01272d0>] autoremove_wake_function+0x0/0x50
> >  [<c017194b>] swap_readpage+0x5b/0x80
> >  [<c0171a2a>] rw_swap_page_sync+0xba/0x110
> >  [<c014d8be>] mark_swapfiles+0x7e/0x1b0
> >  [<c014ea35>] do_magic_resume_2+0xe5/0x170
> >  [<c011d410>] restore_processor_state+0x70/0x90
> >  [<c011ff5f>] do_magic+0x11f/0x140
> >  [<c014ef1d>] do_software_suspend+0x6d/0xa0
> >  [<c023e3cc>] acpi_system_write_sleep+0x11b/0x132
> >  [<c0177de0>] filp_open+0x60/0x70
> >  [<c017952d>] vfs_write+0xad/0x120
> >  [<c017963f>] sys_write+0x3f/0x60
> >  [<c010b10f>] syscall_call+0x7/0xb
> 
> Ahha, this looks like generic problem. I'll probably take a look...

This isn't e100 related. I can reproduce it without e100:

Freeing prev allocated pagedir
Debug: sleeping function called from illegal context at include/linux/rwsem.h:66Call Trace:
 [<c01268bf>] __might_sleep+0x5f/0xa0
 [<c029b712>] sysdev_restore+0x22/0x135
 [<c029bd80>] device_resume+0xc0/0xd0
 [<c014e60c>] drivers_resume+0x8c/0xa0
 [<c014ea15>] do_magic_resume_2+0xc5/0x170
 [<c011d410>] restore_processor_state+0x70/0x90
 [<c011ff5f>] do_magic+0x11f/0x140
 [<c014ef1d>] do_software_suspend+0x6d/0xa0
 [<c023e3cc>] acpi_system_write_sleep+0x11b/0x132
 [<c0177de0>] filp_open+0x60/0x70
 [<c017952d>] vfs_write+0xad/0x120
 [<c017963f>] sys_write+0x3f/0x60
 [<c010b10f>] syscall_call+0x7/0xb

[IDE disks return to life]

Fixing swap signatures... <3>bad: scheduling while atomic!
Call Trace:
 [<c012419e>] schedule+0x6ce/0x6e0
 [<c02a219d>] generic_make_request+0x17d/0x210
 [<c01272d0>] autoremove_wake_function+0x0/0x50
 [<c012641e>] io_schedule+0xe/0x20
 [<c0150522>] wait_on_page_bit+0xa2/0xd0
 [<c01272d0>] autoremove_wake_function+0x0/0x50
 [<c01272d0>] autoremove_wake_function+0x0/0x50
 [<c017194b>] swap_readpage+0x5b/0x80
 [<c0171a2a>] rw_swap_page_sync+0xba/0x110
 [<c014d8be>] mark_swapfiles+0x7e/0x1b0
 [<c014ea35>] do_magic_resume_2+0xe5/0x170
 [<c011d410>] restore_processor_state+0x70/0x90
 [<c011ff5f>] do_magic+0x11f/0x140
 [<c014ef1d>] do_software_suspend+0x6d/0xa0
 [<c023e3cc>] acpi_system_write_sleep+0x11b/0x132
 [<c0177de0>] filp_open+0x60/0x70
 [<c017952d>] vfs_write+0xad/0x120
 [<c017963f>] sys_write+0x3f/0x60
 [<c010b10f>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c012419e>] schedule+0x6ce/0x6e0
 [<c012641e>] io_schedule+0xe/0x20
 [<c0150522>] wait_on_page_bit+0xa2/0xd0
 [<c01272d0>] autoremove_wake_function+0x0/0x50
 [<c01272d0>] autoremove_wake_function+0x0/0x50
 [<c0171780>] end_swap_bio_write+0x0/0x50
 [<c0171a2a>] rw_swap_page_sync+0xba/0x110
 [<c014d931>] mark_swapfiles+0xf1/0x1b0
 [<c014ea35>] do_magic_resume_2+0xe5/0x170
 [<c011d410>] restore_processor_state+0x70/0x90
 [<c011ff5f>] do_magic+0x11f/0x140
 [<c014ef1d>] do_software_suspend+0x6d/0xa0
 [<c023e3cc>] acpi_system_write_sleep+0x11b/0x132
 [<c0177de0>] filp_open+0x60/0x70
 [<c017952d>] vfs_write+0xad/0x120
 [<c017963f>] sys_write+0x3f/0x60
 [<c010b10f>] syscall_call+0x7/0xb

ok
Restarting processes...
Restarting tasks... done
bad: scheduling while atomic!
Call Trace:
 [<c012419e>] schedule+0x6ce/0x6e0
 [<c017963f>] sys_write+0x3f/0x60
 [<c010b136>] work_resched+0x5/0x16
                   
And then the oops:

> Unable to handle kernel paging request at virtual address 40107114
> >  printing eip:
> > 40107114
> > *pde = 2dbf6067
> > *pte = 00000000
> > Oops: 0004 [#1]
> > CPU:    0
> > EIP:    0073:[<40107114>]    Not tainted
> > EFLAGS: 00010202
> > EIP is at 0x40107114
> > eax: ffffffea   ebx: 00000001   ecx: 080d440c   edx: 00000002
> > esi: 00000002   edi: 080d440c   ebp: bffffae8   esp: bffffab8
> > ds: 007b   es: 007b   ss: 007b
> > Process bash (pid: 484, threadinfo=ed776000 task=ef1e40c0)
> >  <6>note: bash[484] exited with preempt_count 1
> > pdflush left refrigerator
> > e100: eth0 NIC Link is Up 10 Mbps Half duplex
> > 
> > ksymoops says:
> > 
> > Warning (Oops_read): Code line not seen, dumping what data is available
> > 
> > 
> > >>EIP; 40107114 Before first symbol   <=====
> > 
> > >>eax; ffffffea <__kernel_rt_sigreturn+1baa/????>
> 
> That's bad. Error outside of kernel. Not sure what is wrong.

Note that  if suspend after booting  with "single" (ie. with  only init,
agetty and bash running) the other warnings go away, but I still see the
above oops.

HTH,
Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Il dottore mi ha detto di smettere di fare cene intime per quattro.
A meno che non ci siamo altre tre persone.
