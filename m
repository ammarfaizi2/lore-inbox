Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267451AbUJSVCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267451AbUJSVCo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 17:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269876AbUJSVCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 17:02:09 -0400
Received: from smtp2.netcabo.pt ([212.113.174.29]:10083 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S269693AbUJSUtZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 16:49:25 -0400
Message-ID: <32806.192.168.1.5.1098218772.squirrel@192.168.1.5>
In-Reply-To: <20041019180059.GA23113@elte.hu>
References: <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu>
    <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>
    <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu>
    <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu>
    <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu>
    <20041019180059.GA23113@elte.hu>
Date: Tue, 19 Oct 2004 21:46:12 +0100 (WEST)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U7
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       "Bill Huey" <bhuey@lnxw.com>, "Adam Heath" <doogie@debian.org>,
       "Florian Schmidt" <mista.tapas@gmx.net>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20041019214612_44734"
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 19 Oct 2004 20:49:14.0380 (UTC) FILETIME=[17DBBCC0:01C4B61D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20041019214612_44734
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Ingo Molnar wrote:
>
> i have released the -U7 Real-Time Preemption patch:
>
>   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-rc4-mm1-U7
>

With U7 I'm now able to boot and go all the way into X/KDE with a
SMP+PREEMPT_REALTIME configured kernel (config.gz attached) and reboot
into it, again and again. Things are getting better, really, but ...

Overall behavior is still unreliable. Many things stop functioning once
and for good (until reboot). The shutdown sequence is also prone to busy
hanging.

As an aside, my greatest complaint is that jackd -R doesn't work at all:

JACK: unable to mlock() port buffers: Cannot allocate memory
jack_create_thread: error -1 switching current thread to rt for
inheritance: Unknown error 4294967295
cannot start watchdog thread
cannot load driver module alsa

Another example, and one of the very few that were verbose on dmesg, while
accessing the floppy disk (subfs mounted), I got:

kernel BUG at fs/buffer.c:2702!
invalid operand: 0000 [#1]
PREEMPT SMP
Modules linked in: nls_iso8859_15 nls_cp860 vfat fat nls_base snd_seq
usbhid ehc
i_hcd intel_mch_agp agpgart uhci_hcd mga snd_usb_usx2y snd_usb_lib
snd_rawmidi s
nd_seq_device snd_hwdep snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd
soundc
ore snd_page_alloc evdev sk98lin w83781d i2c_sensor i2c_isa i2c_i801
i2c_core wa
com usbcore subfs dm_mod
CPU:    0
EIP:    0060:[<c015a9c2>]    Not tainted VLI
EFLAGS: 00010246   (2.6.9-rc4-mm1-RT-U7.0smp)
EIP is at submit_bh+0x119/0x126
eax: 00000004   ebx: f16d683c   ecx: 00000000   edx: f12e2000
esi: f16d683c   edi: 00000000   ebp: f12e3d90   esp: f12e3d78
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process submountd (pid: 11393, threadinfo=f12e2000 task=f6116950)
Stack: 00000000 00000200 00000000 f16d683c fffffffb f64b0800 f12e3da4
c01587e3
       00000000 f16d683c f4675000 f12e3db8 c0158ab1 f16d683c 00000000
00000200
       f12e3e34 f8c7e85b f673d500 00000000 00000200 f4675148 f12e3de8
c02ca60c
Call Trace:
 [<c0105235>] show_stack+0xaf/0xb7 (28)
 [<c01053c5>] show_registers+0x168/0x1dd (56)
 [<c01055ce>] die+0x107/0x18f (64)
 [<c0105aee>] do_invalid_op+0x109/0x10b (188)
 [<c0104e7d>] error_code+0x2d/0x38 (92)
 [<c01587e3>] __bread_slow+0x60/0xb2 (20)
 [<c0158ab1>] __bread+0x33/0x39 (20)
 [<f8c7e85b>] fat_fill_super+0xe6/0x76c [fat] (124)
 [<f8c43d70>] vfat_fill_super+0x30/0x67 [vfat] (32)
 [<c015d220>] get_sb_bdev+0xf1/0x147 (72)
 [<f8c43dd5>] vfat_get_sb+0x2e/0x31 [vfat] (28)
 [<c015d492>] do_kern_mount+0xa5/0x15a (44)
 [<c0172f0d>] do_new_mount+0x71/0xab (52)
 [<c01735e3>] do_mount+0x184/0x1ae (116)
 [<c0173a21>] sys_mount+0x97/0xd6 (48)
 [<c01043b9>] sysenter_past_esp+0x52/0x71 (-8124)
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: _spin_lock_irqsave+0x17/0x70 / (die+0x3f/0x18f)
.. entry 2: print_traces+0x16/0x4c / (show_stack+0xaf/0xb7)

Code: 24 e8 28 08 00 00 8b 45 f0 83 c4 0c 5b 5e 5f 5d c3 0f 0b 8d 0a 86 ea
2d c0 e9 14 ff ff ff 0f 0b 8f 0a 86 ea 2d c0 e9 1c ff ff ff <0f> 0b 8e 0a
86 ea 2d c0 e9 04 ff ff ff 55 89 e5 57 56 31 f6 53
 <3>subfs: submountd execution failure. Error 11


Think it's too early to party, eh? :)
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org
------=_20041019214612_44734
Content-Type: application/x-gzip; name="config-2.6.9-rc4-mm1-RT-U7.0smp.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
      filename="config-2.6.9-rc4-mm1-RT-U7.0smp.gz"

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
------=_20041019214612_44734--


