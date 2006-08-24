Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030377AbWHXSbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030377AbWHXSbq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 14:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030444AbWHXSbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 14:31:45 -0400
Received: from mail.kroah.org ([69.55.234.183]:42683 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030377AbWHXSbp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 14:31:45 -0400
Date: Thu, 24 Aug 2006 11:27:11 -0700
From: Greg KH <greg@kroah.com>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Mike Galbraith <efault@gmx.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc3-mm2:  oops in sysfs_follow_link()
Message-ID: <20060824182711.GD8808@kroah.com>
References: <1155462893.6125.13.camel@Homer.simpson.net> <20060814210657.GJ11673@kroah.com> <20060824114452.GB11232@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824114452.GB11232@in.ibm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 05:14:52PM +0530, Maneesh Soni wrote:
> On Mon, Aug 14, 2006 at 02:06:57PM -0700, Greg KH wrote:
> > On Sun, Aug 13, 2006 at 09:54:53AM +0000, Mike Galbraith wrote:
> > > (resend with corrected cc)
> > > 
> > > Greetings,
> > > 
> > > I just got the below double warning from lib/kref.c:32 followed by oops.
> > > 
> > > I had just rebooted after upping my printk buffer to 20 (to be able to
> > > see a complete boot despite the spam), and was poking Ctrl+Alt+F1 trying
> > > to get to a vt to watch.
> > 
> > Maneesh, any thoughts?
> > 
> > Original messages left below...
> > 
> > 
> 
> Sorry, took lot of time for this due to vaccations.

No problem, I haven't heard of anyone else hitting this problem.

> > > DEV: registering device: ID = 'vcs6'
> > > PM: Adding info for No Bus:vcs6
> > > DEV: registering device: ID = 'vcsa6'
> > > PM: Adding info for No Bus:vcsa6
> > > DEV: Unregistering device. ID = 'vcs6'
> > > PM: Removing info for No Bus:vcs6
> > > device_create_release called for vcs6
> > > DEV: Unregistering device. ID = 'vcsa6'
> > > PM: Removing info for No Bus:vcsa6
> > > device_create_release called for vcsa6
> > > BUG: warning at lib/kref.c:32/kref_get()
> > >  [<c1003eba>] show_trace_log_lvl+0x16e/0x191
> > >  [<c1004647>] show_trace+0x12/0x14
> > >  [<c1004768>] dump_stack+0x19/0x1b
> > >  [<c11d3f28>] kref_get+0x41/0x43
> > >  [<c11d3416>] kobject_get+0x12/0x17
> > >  [<c10b0dea>] sysfs_follow_link+0x1d0/0x245
> > >  [<c107d187>] generic_readlink+0x28/0x70
> > >  [<c10796de>] sys_readlinkat+0x7c/0xa1
> > >  [<c107972a>] sys_readlink+0x27/0x29
> > >  [<c10030db>] syscall_call+0x7/0xb
> > >  [<b7d309c4>] 0xb7d309c4
> > >  [<c1004647>] show_trace+0x12/0x14
> > >  [<c1004768>] dump_stack+0x19/0x1b
> > >  [<c11d3f28>] kref_get+0x41/0x43
> > >  [<c11d3416>] kobject_get+0x12/0x17
> > >  [<c10b0dea>] sysfs_follow_link+0x1d0/0x245
> > >  [<c107d187>] generic_readlink+0x28/0x70
> > >  [<c10796de>] sys_readlinkat+0x7c/0xa1
> > >  [<c107972a>] sys_readlink+0x27/0x29
> > >  [<c10030db>] syscall_call+0x7/0xb
> > > BUG: warning at lib/kref.c:32/kref_get()
> > >  [<c1003eba>] show_trace_log_lvl+0x16e/0x191
> > >  [<c1004647>] show_trace+0x12/0x14
> > >  [<c1004768>] dump_stack+0x19/0x1b
> > >  [<c11d3f28>] kref_get+0x41/0x43
> > >  [<c11d3416>] kobject_get+0x12/0x17
> > >  [<c10b0ccd>] sysfs_follow_link+0xb3/0x245
> > >  [<c107d187>] generic_readlink+0x28/0x70
> > >  [<c10796de>] sys_readlinkat+0x7c/0xa1
> > >  [<c107972a>] sys_readlink+0x27/0x29
> > >  [<c10030db>] syscall_call+0x7/0xb
> > >  [<b7d309c4>] 0xb7d309c4
> > >  [<c1004647>] show_trace+0x12/0x14
> > >  [<c1004768>] dump_stack+0x19/0x1b
> > >  [<c11d3f28>] kref_get+0x41/0x43
> > >  [<c11d3416>] kobject_get+0x12/0x17
> > >  [<c10b0ccd>] sysfs_follow_link+0xb3/0x245
> > >  [<c107d187>] generic_readlink+0x28/0x70
> > >  [<c10796de>] sys_readlinkat+0x7c/0xa1
> > >  [<c107972a>] sys_readlink+0x27/0x29
> > >  [<c10030db>] syscall_call+0x7/0xb
> > > BUG: unable to handle kernel NULL pointer dereference at virtual address 00000000
> > >  printing eip:
> > > c10b0d1f
> > > *pde = 00000000
> > > Oops: 0000 [#3]
> > > 4K_STACKS PREEMPT SMP 
> > > last sysfs file: /class/net/lo/address
> > > Modules linked in: ip6t_REJECT xt_tcpudp ipt_REJECT xt_state iptable_mangle iptable_nat ip_nat iptable_filter ip6table_mangle ip_conntrack nfnetlink ip_tables ip6table_filter ip6_tables x_tables nls_iso8859_1 nls_cp437 nls_utf8 sd_mod ir_kbd_i2c prism54 bt878 ohci1394 bttv video_buf ir_common btcx_risc tveeprom ieee1394 snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd_page_alloc snd_mpu401 snd_mpu401_uart snd_rawmidi snd_seq_device i2c_i801 snd soundcore
> > > CPU:    0
> > > EIP:    0060:[<c10b0d1f>]    Not tainted VLI
> > > EFLAGS: 00010246   (2.6.18-rc3-mm2-smp #182) 
> > > EIP is at sysfs_follow_link+0x105/0x245
> > > eax: 00000000   ebx: 00000001   ecx: ffffffff   edx: ffffffff
> > > esi: 00000000   edi: 00000000   ebp: dff85ec4   esp: dff85e94
> > > ds: 007b   es: 007b   ss: 0068
> > > Process hald (pid: 4133, ti=dff85000 task=c24a3030 task.ti=dff85000)
> > > Stack: f8b0e078 dff85ed8 f7bca000 00000001 dff0d704 f7c15e40 ffffffea f8b0e078 
> > >        f8b0e168 c14b19a0 f7bc9800 00000100 dff85f34 c107d187 c10824d1 0809ab00 
> > >        c10822f8 dff0d77c 00001000 08096f54 00000070 dff85fb4 f7811000 44dee880 
> > > Call Trace:
> > >  [<c107d187>] generic_readlink+0x28/0x70
> > >  [<c10796de>] sys_readlinkat+0x7c/0xa1
> > >  [<c107972a>] sys_readlink+0x27/0x29
> > >  [<c10030db>] syscall_call+0x7/0xb
> > >  [<b7d309c4>] 0xb7d309c4
> > >  [<c1003f83>] show_stack_log_lvl+0xa6/0xcb
> > >  [<c1004180>] show_registers+0x1d8/0x286
> > >  [<c100437f>] die+0x151/0x333
> > >  [<c10197f9>] do_page_fault+0x26b/0x51f
> > >  [<c13e1a99>] error_code+0x39/0x40
> > >  [<c107d187>] generic_readlink+0x28/0x70
> > >  [<c10796de>] sys_readlinkat+0x7c/0xa1
> > >  [<c107972a>] sys_readlink+0x27/0x29
> > >  [<c10030db>] syscall_call+0x7/0xb
> > > Code: dc 00 00 00 00 83 45 dc 01 8b 40 24 85 c0 75 f5 8b 45 ec 89 45 d0 bb 01 00 00 00 31 f6 ba ff ff ff ff 8b 4d d0 8b 39 89 d1 89 f0 <f2> ae f7 d1 49 83 c1 01 01 cb 8b 4d d0 8b 49 24 89 4d d0 85 c9 
> > > EIP: [<c10b0d1f>] sysfs_follow_link+0x105/0x245 SS:ESP 0068:dff85e94
> > >  <7>DEV: registering device: ID = 'vcs2'
> > > 
> > 
> 
> 
> I guess that earlier WARN_ON's are related to the oops we are seeing. 
> The oops has oocured becaure the target kobject->k_name is NULL? 
> Somehow the target kobjcet is getting freed while sysfs_follow_link() even
> though sysfs takes ref for the the target kobject at the time of symlink
> creation. Can there be some mispatch in kref_get()/kref_put() or kobject_get()
> /kobject_put() in higher layers?

Possibly, I really don't know.  As no one else has reported this, it
might have been an odd bug with something else in the -mm patchset.

thanks for the response.

greg k-h
