Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbUKSPpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbUKSPpn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 10:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbUKSPpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 10:45:42 -0500
Received: from mail.aei.ca ([206.123.6.14]:13037 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S261384AbUKSPp1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 10:45:27 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.28-1
From: Shane Shrybman <shrybman@aei.ca>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Amit Shah <amit.shah@codito.com>
In-Reply-To: <20041119095607.GD27642@elte.hu>
References: <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu>
	 <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu>
	 <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu>
	 <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu>
	 <49222.195.245.190.94.1100789179.squirrel@195.245.190.94>
	 <1100814616.10544.6.camel@krustophenia.net>
	 <20041119095607.GD27642@elte.hu>
Content-Type: text/plain
Message-Id: <1100879045.4106.4.camel@mars>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 19 Nov 2004 10:44:06 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-11-19 at 04:56, Ingo Molnar wrote:

> 0.7.29-1 fixes a similar module-unload problem reported by Christian
> Meder, could you try it?
> 
> 	Ingo
> 

Hi, just tried V0.7.29-1 with the ivtv module and I got this oops:

Attached scsi generic sg2 at scsi0, channel 0, id 2, lun 0,  type 0
IRQ#22 thread RT prio: 38.
BUG: Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
e0ab77f8
*pde = 00000000
Oops: 0002 [#1]
PREEMPT 
Modules linked in: sg msp3400 saa7115 tveeprom ivtv nfsd exportfs lockd sunrpc tuner tvaudio bttv video_buf firmware_class btcx_risc snd_via82xx snd_mpu401_uart i2c_viapro joydev usbhid uhci_hcd usbcore 3c59x mii emu10k1_gp gameport snd_emu10k1 snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_util_mem snd_hwdep snd soundcore via_agp agpgart dm_mod realtime rtc
CPU:    0
EIP:    0060:[<e0ab77f8>]    Not tainted VLI
EFLAGS: 00210286   (2.6.10-rc22-V29) 
EIP is at buffer_queue+0x38/0x70 [bttv]
eax: de7d4744   ebx: 00000000   ecx: d745c2a0   edx: d745c304
esi: de7d40e8   edi: e0ad34e0   ebp: d2571c34   esp: d2571c24
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process mythbackend (pid: 4071, threadinfo=d2570000 task=d27fb800)
Stack: d2571c34 00200286 00200286 e0ad39dc d2571ec8 e0ab8fb8 de7d4000 d745c2a0 
       e0ac37b4 00000160 000001e0 00000004 00001c3c e0ad34e0 de7d4010 d27fb800 
       d2571c78 c01112d0 00000002 d745c2a0 c01dcf75 de7d4000 c01339a1 00200286 
Call Trace:
 [<c0104093>] show_stack+0x83/0xa0 (28)
 [<c010424c>] show_registers+0x16c/0x1d0 (56)
 [<c0104447>] die+0xf7/0x190 (64)
 [<c0114fb0>] do_page_fault+0x360/0x6b0 (220)
 [<c0103cab>] error_code+0x2b/0x30 (76)
 [<e0ab8fb8>] bttv_do_ioctl+0x538/0x15f0 [bttv] (660)
 [<c0276a4e>] video_usercopy+0x8e/0x160 (168)
 [<e0aba0b4>] bttv_ioctl+0x44/0x70 [bttv] (32)
 [<c01741a1>] sys_ioctl+0xe1/0x280 (44)
 [<c0103245>] sysenter_past_esp+0x52/0x71 (-8124)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c010438f>] .... die+0x3f/0x190
.....[<c0114fb0>] ..   ( <= do_page_fault+0x360/0x6b0)
.. [<c0136f4d>] .... print_traces+0x1d/0x60
.....[<c0104093>] ..   ( <= show_stack+0x83/0xa0)

Code: eb 9a 65 df 8b 45 08 8b 4d 0c 8b 80 ec 00 00 00 8d 51 64 8b 30 c7 41 20 02 00 00 00 8d 86 5c 06 00 00 8b 58 04 89 41 64 89 50 04 <89> 13 89 5a 04 8b 8e 78 06 00 00 85 c9 74 08 8b 5d f8 8b 75 fc 
 BUG: mythbackend/4071, BKL held at task exit time!
BKL acquired at: sys_ioctl+0x5e/0x280
 [c03b1d44] {kernel_sem.lock}
.. held by:       mythbackend: 4071 [d27fb800, 119]
... acquired at:  lock_kernel+0x2f/0x50
BUG: mythbackend/4071, lock held at task exit time!
 [de7d4014] {&q->lock}
.. held by:       mythbackend: 4071 [d27fb800, 119]
... acquired at:  bttv_do_ioctl+0x476/0x15f0 [bttv]
BUG: mythbackend/4071, lock held at task exit time!
 [e0ad39dc] {&btv->s_lock}
.. held by:       mythbackend: 4071 [d27fb800, 119]
... acquired at:  bttv_do_ioctl+0x51b/0x15f0 [bttv]
mythbackend/4071: BUG in __up_mutex at kernel/rt.c:1101
 [<c01040d3>] dump_stack+0x23/0x30 (20)
 [<c01340a2>] __up_mutex+0x302/0x530 (52)
 [<c01351b1>] up+0x101/0x110 (36)
 [<c0342df1>] __schedule+0x6b1/0x750 (72)
 [<c011e797>] do_exit+0x2f7/0x590 (48)
 [<c01044e0>] do_trap+0x0/0x100 (64)
 [<c0114fb0>] do_page_fault+0x360/0x6b0 (220)
 [<c0103cab>] error_code+0x2b/0x30 (76)
 [<e0ab8fb8>] bttv_do_ioctl+0x538/0x15f0 [bttv] (660)
 [<c0276a4e>] video_usercopy+0x8e/0x160 (168)
 [<e0aba0b4>] bttv_ioctl+0x44/0x70 [bttv] (32)
 [<c01741a1>] sys_ioctl+0xe1/0x280 (44)
 [<c0103245>] sysenter_past_esp+0x52/0x71 (-8124)
---------------------------
| preempt count: 00000004 ]
| 4-level deep critical section nesting:
----------------------------------------
.. [<c034278f>] .... __schedule+0x4f/0x750
.....[<c011e797>] ..   ( <= do_exit+0x2f7/0x590)
.. [<c0135161>] .... up+0xb1/0x110
.....[<c0342df1>] ..   ( <= __schedule+0x6b1/0x750)
.. [<c01342b7>] .... __up_mutex+0x517/0x530
.....[<c01351b1>] ..   ( <= up+0x101/0x110)
.. [<c0136f4d>] .... print_traces+0x1d/0x60
.....[<c01040d3>] ..   ( <= dump_stack+0x23/0x30)

Regards,

Shane

