Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbWILPmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbWILPmU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 11:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWILPmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 11:42:20 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:31519 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751381AbWILPmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 11:42:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fE4i0oVgQS7yHXw7mn80YJnryS4thiL6tG87cbaa6cR24ji9gbl9Glg/UNf6/TE7GSJFDk6tflZXqe88/V0/aAVXe0xLpIVMC3EnxdhHpslEU6eKH7WGaxw4Lu9pCV6D289NEWw03e6bP0xvJvi6YJ+opVogW6vYvpE3kVV3rHA=
Message-ID: <6bffcb0e0609120842s6a38b326u4e1fff2e562a6832@mail.gmail.com>
Date: Tue, 12 Sep 2006 17:42:10 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.18-rc6-mm2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6bffcb0e0609120554j5e69e2sd2c8ebb914c4c9f5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060912000618.a2e2afc0.akpm@osdl.org>
	 <6bffcb0e0609120554j5e69e2sd2c8ebb914c4c9f5@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> On 12/09/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm2/
> >
>
> I get this while umounting jfs (umount segfaulted).

s/jfs/xfs

/home/michal/bin/test_mount_fs.sh: line 22:  2354 Segmentation fault
sudo umount /mnt/fs-farm/xfs/

>
> BUG: unable to handle kernel paging request at virtual address 6b6b6c4f
>  printing eip:
> c013a612
> *pde = 00000000
> Oops: 0002 [#1]
> 4K_STACKS PREEMPT SMP
> last sysfs file: /devices/platform/i2c-9191/9191-0290/temp2_input
> Modules linked in: jfs nls_base xfs reiser4 reiserfs ext2 loop ipv6
> w83627hf hwmon_vid hwmon i2c_isa af_packet ip_conntrack_netbios_ns
> ipt_REJECT xt_state ip_conntrack nfnetlink xt_tcpudp iptable_filter
> ip_tables x_tables cpufreq_userspace p4_clockmod speedstep_lib
> binfmt_misc thermal processor fan container evdev snd_intel8x0
> snd_ac97_codec snd_ac97_bus snd_seq_dummy snd_seq_oss
> snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss
> snd_pcm sk98lin snd_timer skge snd soundcore snd_page_alloc intel_agp
> agpgart ide_cd i2c_i801 iTCO_wdt cdrom rtc unix
> CPU:    1
> EIP:    0060:[<c013a612>]    Not tainted VLI
> EFLAGS: 00010046   (2.6.18-rc6-mm2 #120)
> EIP is at __lock_acquire+0x35e/0xae8
> eax: 00000000   ebx: 6b6b6b6b   ecx: c036b3d8   edx: 00000000
> esi: 00000002   edi: f1620030   ebp: f158be7c   esp: f158be48
> ds: 007b   es: 007b   ss: 0068
> Process umount (pid: 19719, ti=f158b000 task=f1620030 task.ti=f158b000)
> Stack: 000007bf 00000000 00000000 f173fd4c f1620030 f2543874 00000002 00000000
>        00000078 c02f980b f16205b8 00000002 f1620030 f158beb0 c013ae74 00000000
>        00000002 00000000 fdcfc85b c02f7e43 00000003 f1620590 00000004 f1620608
> Call Trace:
>  [<c013ae74>] lock_release_non_nested+0xd8/0x143
>  [<c013b291>] lock_release+0x178/0x19f
>  [<c02f7dc5>] __mutex_unlock_slowpath+0xbb/0x131
>  [<c02f7e43>] mutex_unlock+0x8/0xa
>  [<c017655f>] generic_shutdown_super+0x9c/0xd9
>  [<c01765bc>] kill_block_super+0x20/0x32
>  [<c017667c>] deactivate_super+0x5d/0x6f
>  [<c01892bc>] mntput_no_expire+0x52/0x85
>  [<c017b2c9>] path_release_on_umount+0x15/0x18
>  [<c018a469>] sys_umount+0x1e1/0x215
>  [<c018a4aa>] sys_oldumount+0xd/0xf
>  [<c0103156>] sysenter_past_esp+0x5f/0x99
> DWARF2 unwinder stuck at sysenter_past_esp+0x5f/0x99
>
> Leftover inexact backtrace:
>
>  =======================
> Code: 68 0b e6 2f c0 68 e7 04 00 00 68 e9 f4 31 c0 68 f4 84 31 c0 e8
> 7f 7b fe ff e8 3d a4 fc ff 83 c4 10 eb 08 85 db 0f 84 6d 07 00 00 <f0>
> ff 83 e4 00 00 00 8b 55 dc 8b 92 5c 05 00 00 89 55 e4 83 fa
> EIP: [<c013a612>] __lock_acquire+0x35e/0xae8 SS:ESP 0068:f158be48
>  <3>BUG: sleeping function called from invalid context at
> /usr/src/linux-mm/mm/slab.c:2985
> in_atomic():0, irqs_disabled():1
>  [<c01041ba>] dump_trace+0x63/0x1ca
>  [<c0104333>] show_trace_log_lvl+0x12/0x25
>  [<c0104993>] show_trace+0xd/0x10
>  [<c0104a58>] dump_stack+0x16/0x18
>  [<c011a8b7>] __might_sleep+0x8d/0x95
>  [<c01709f7>] kmem_cache_zalloc+0x28/0xe3
>  [<c0152dae>] taskstats_exit_alloc+0x2e/0x6c
>  [<c01246e4>] do_exit+0x1b6/0x9fe
>  [<c01048a3>] die+0x2ae/0x2d4
>  [<c0118b0c>] do_page_fault+0x4a4/0x584
>  [<c02f9b4f>] error_code+0x3f/0x44
> DWARF2 unwinder stuck at error_code+0x3f/0x44
> Leftover inexact backtrace:
>
>  [<c013ae74>] lock_release_non_nested+0xd8/0x143
>  [<c013b291>] lock_release+0x178/0x19f
>  [<c02f7dc5>] __mutex_unlock_slowpath+0xbb/0x131
>  [<c02f7e43>] mutex_unlock+0x8/0xa
>  [<c017655f>] generic_shutdown_super+0x9c/0xd9
>  [<c01765bc>] kill_block_super+0x20/0x32
>  [<c017667c>] deactivate_super+0x5d/0x6f
>  [<c01892bc>] mntput_no_expire+0x52/0x85
>  [<c017b2c9>] path_release_on_umount+0x15/0x18
>  [<c018a469>] sys_umount+0x1e1/0x215
>  [<c018a4aa>] sys_oldumount+0xd/0xf
>  [<c0103156>] sysenter_past_esp+0x5f/0x99
>  =======================
>
> http://www.stardust.webpages.pl/files/mm/2.6.18-rc6-mm2/mm-config1
> http://www.stardust.webpages.pl/files/mm/2.6.18-rc6-mm2/mm-dmesg1
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)
