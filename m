Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268145AbUJOCVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268145AbUJOCVZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 22:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268148AbUJOCVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 22:21:25 -0400
Received: from lennier.cc.vt.edu ([198.82.162.213]:13320 "EHLO
	lennier.cc.vt.edu") by vger.kernel.org with ESMTP id S268145AbUJOCUz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 22:20:55 -0400
Message-ID: <416F42A0.5060103@vt.edu>
Date: Thu, 14 Oct 2004 22:23:12 -0500
From: William Wolf <wwolf@vt.edu>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040919)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernel list <linux-kernel@vger.kernel.org>
CC: Dmitry Torokhov <dtor_core@ameritech.net>, akpm@zip.com.au
Subject: Re: 2.6.9-rc4-mm1
References: <416EE7EB.4070209@vt.edu> <200410141815.03110.dtor_core@ameritech.net>
In-Reply-To: <200410141815.03110.dtor_core@ameritech.net>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> On Thursday 14 October 2004 03:56 pm, William Wolf wrote:
> 
>>Hey, I just tried -rc4-mm1 on my amd64 laptop, and my keyboard fails to
>>work, I don't even think it is being recognized. 
> 
> 
> Could you try booting with i8042.noacpi and if it helps mailing me your
> /proc/acpi/dsdt?
> 
> Thanks!
> 


Thanks a bunch, this fixed the keyboard problem.  What did this do 
exactly?  Anyway, now I'm having more issues with this kernel.

I'm getting a lot of scheduling while atomic, and not tainted messages. 
    There are no such messages right after boot or after log in, it only 
happens when i try to launch certain applications.  gaim, thunderbird, 
and firefox are some that i tried, all just dying and dumping these 
types of messages:




Unable to handle kernel paging request at 00000000000c1644 RIP:
<ffffffff8013564d>{profile_hit+45}
PML4 16557067 PGD 16b76067 PMD 0
Oops: 0002 [5] PREEMPT
CPU 0
Modules linked in: usbcore snd_intel8x0 snd_ac97_codec snd_pcm snd_timer 
snd snd_page_alloc evdev sis900 sg sd_mod scsi_mod
Pid: 7329, comm: firefox-bin Not tainted 2.6.9-rc4-mm1
RIP: 0010:[<ffffffff8013564d>] <ffffffff8013564d>{profile_hit+45}
RSP: 0018:0000010016a6df20  EFLAGS: 00010082
RAX: 0000000000000000 RBX: 0000010016a7f860 RCX: 0000000000000000
RDX: 0000010016a7f998 RSI: 00000000000c1644 RDI: 0000000000000002
RBP: 0000010016a6df68 R08: 0000000000000001 R09: 0000000000000001
R10: 0000002a95d67000 R11: 0000000000000206 R12: 0000000000000000
R13: 00000000ffffffea R14: 0000007fbfffefb4 R15: ffffffff804543e0
FS:  000000000051e4a0(005b) GS:ffffffff80497840(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00000000000c1644 CR3: 0000000000101000 CR4: 00000000000006e0
Process firefox-bin (pid: 7329, threadinfo 0000010016a6c000, task 
0000010016a7f860)
Stack: ffffffff801312f6 000000000055c570 0000000000000006 00000000bffff680
        0000002a95e7c820 0000000000004000 0000000000000000 0000007fbfffefb4
        0000002a97775e18 0000010016a6df78
Call Trace:<ffffffff801312f6>{setscheduler+214} 
<ffffffff801314a9>{sys_sched_setscheduler+9}
        <ffffffff80110496>{system_call+126}

Code: ff 06 c3 48 83 ec 08 39 3d 86 49 32 00 75 54 48 83 3d 64 49
RIP <ffffffff8013564d>{profile_hit+45} RSP <0000010016a6df20>
CR2: 00000000000c1644
  <6>note: firefox-bin[7329] exited with preempt_count 2
scheduling while atomic: firefox-bin/0x04000002/7329

Call Trace:<ffffffff803358e7>{schedule+119} 
<ffffffff80130e34>{__wake_up+84}
        <ffffffff803364cf>{cond_resched+63} 
<ffffffff801633af>{unmap_vmas+1519}
        <ffffffff80168316>{exit_mmap+118} <ffffffff801322a0>{mmput+48}
        <ffffffff801369f3>{do_exit+483} 
<ffffffff80259dc7>{do_unblank_screen+119}
        <ffffffff801212df>{do_page_fault+1263} 
<ffffffff80164afd>{do_no_page+1341}
        <ffffffff80164cc6>{handle_mm_fault+326} 
<ffffffff8018248c>{path_release+12}
        <ffffffff80183984>{link_path_walk+3780} 
<ffffffff80110d49>{error_exit+0}
        <ffffffff8013564d>{profile_hit+45} 
<ffffffff801312f6>{setscheduler+214}
        <ffffffff801314a9>{sys_sched_setscheduler+9} 
<ffffffff80110496>{system_call+126}

Unable to handle kernel paging request at 00000000000c1644 RIP:
<ffffffff8013564d>{profile_hit+45}
PML4 1675a067 PGD 167ae067 PMD 0
Oops: 0002 [6] PREEMPT
CPU 0
Modules linked in: usbcore snd_intel8x0 snd_ac97_codec snd_pcm snd_timer 
snd snd_page_alloc evdev sis900 sg sd_mod scsi_mod
Pid: 7353, comm: mozilla-xremote Not tainted 2.6.9-rc4-mm1
RIP: 0010:[<ffffffff8013564d>] <ffffffff8013564d>{profile_hit+45}
RSP: 0018:00000100167d7f20  EFLAGS: 00010082
RAX: 0000000000000000 RBX: 00000100165091d0 RCX: 0000000000000000
RDX: 0000010016509308 RSI: 00000000000c1644 RDI: 0000000000000002
RBP: 00000100167d7f68 R08: 0000000000000001 R09: 0000000000000001
R10: 0000002a958744a0 R11: 0000000000000206 R12: 0000000000000000
R13: 00000000ffffffea R14: 0000007fbffff4c4 R15: ffffffff804543e0
FS:  00000000005034a0(005b) GS:ffffffff80497840(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00000000000c1644 CR3: 0000000000101000 CR4: 00000000000006e0
Process mozilla-xremote (pid: 7353, threadinfo 00000100167d6000, task 
00000100165091d0)
Stack: ffffffff801312f6 0000000000504770 0000000000000002 0000000000402360
        0000002a95ad8820 0000000000004000 0000000000000000 0000007fbffff4c4
        0000002a964dfe18 00000100167d7f78
Call Trace:<ffffffff801312f6>{setscheduler+214} 
<ffffffff801314a9>{sys_sched_setscheduler+9}
        <ffffffff80110496>{system_call+126}

Code: ff 06 c3 48 83 ec 08 39 3d 86 49 32 00 75 54 48 83 3d 64 49
RIP <ffffffff8013564d>{profile_hit+45} RSP <00000100167d7f20>
CR2: 00000000000c1644
  <6>note: mozilla-xremote[7353] exited with preempt_count 2
scheduling while atomic: mozilla-xremote/0x04000002/7353

Call Trace:<ffffffff803358e7>{schedule+119} 
<ffffffff80130e34>{__wake_up+84}
        <ffffffff803364cf>{cond_resched+63} 
<ffffffff801633af>{unmap_vmas+1519}
        <ffffffff80168316>{exit_mmap+118} <ffffffff801322a0>{mmput+48}
        <ffffffff801369f3>{do_exit+483} 
<ffffffff80259dc7>{do_unblank_screen+119}
        <ffffffff801212df>{do_page_fault+1263} 
<ffffffff80164afd>{do_no_page+1341}
        <ffffffff80164cc6>{handle_mm_fault+326} 
<ffffffff80110d49>{error_exit+0}
        <ffffffff8013564d>{profile_hit+45} 
<ffffffff801312f6>{setscheduler+214}
        <ffffffff801314a9>{sys_sched_setscheduler+9} 
<ffffffff80110496>{system_call+126}

Unable to handle kernel paging request at 00000000000c1644 RIP:
<ffffffff8013564d>{profile_hit+45}
PML4 16708067 PGD 167c3067 PMD 0
Oops: 0002 [7] PREEMPT
CPU 0
Modules linked in: usbcore snd_intel8x0 snd_ac97_codec snd_pcm snd_timer 
snd snd_page_alloc evdev sis900 sg sd_mod scsi_mod
Pid: 7355, comm: thunderbird-bin Not tainted 2.6.9-rc4-mm1
RIP: 0010:[<ffffffff8013564d>] <ffffffff8013564d>{profile_hit+45}
RSP: 0018:00000100167d9f20  EFLAGS: 00010082
RAX: 0000000000000000 RBX: 000001001678b210 RCX: 0000000000000000
RDX: 000001001678b348 RSI: 00000000000c1644 RDI: 0000000000000002
RBP: 00000100167d9f68 R08: 0000000000000001 R09: 0000000000000001
R10: 0000002a96b1c950 R11: 0000000000000202 R12: 0000000000000000
R13: 00000000ffffffea R14: 0000007fbfffeea4 R15: ffffffff804543e0
FS:  000000000051e4a0(005b) GS:ffffffff80497840(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00000000000c1644 CR3: 0000000000101000 CR4: 00000000000006e0
Process thunderbird-bin (pid: 7355, threadinfo 00000100167d8000, task 
000001001678b210)
Stack: ffffffff801312f6 000000000055c5c0 0000000000000002 00000000bffff570
        0000002a96e71820 0000000000004000 0000000000000000 0000007fbfffeea4
        0000002a97775e18 00000100167d9f78
Call Trace:<ffffffff801312f6>{setscheduler+214} 
<ffffffff801314a9>{sys_sched_setscheduler+9}
        <ffffffff80110496>{system_call+126}

Code: ff 06 c3 48 83 ec 08 39 3d 86 49 32 00 75 54 48 83 3d 64 49
RIP <ffffffff8013564d>{profile_hit+45} RSP <00000100167d9f20>
CR2: 00000000000c1644
  <6>note: thunderbird-bin[7355] exited with preempt_count 2
scheduling while atomic: thunderbird-bin/0x04000002/7355

Call Trace:<ffffffff803358e7>{schedule+119} 
<ffffffff80130e34>{__wake_up+84}
        <ffffffff803364cf>{cond_resched+63} 
<ffffffff801633af>{unmap_vmas+1519}
        <ffffffff80168316>{exit_mmap+118} <ffffffff801322a0>{mmput+48}
        <ffffffff801369f3>{do_exit+483} 
<ffffffff80259dc7>{do_unblank_screen+119}
        <ffffffff801212df>{do_page_fault+1263} 
<ffffffff80164afd>{do_no_page+1341}
        <ffffffff80164cc6>{handle_mm_fault+326} 
<ffffffff8018248c>{path_release+12}
        <ffffffff80183984>{link_path_walk+3780} 
<ffffffff80110d49>{error_exit+0}
        <ffffffff8013564d>{profile_hit+45} 
<ffffffff801312f6>{setscheduler+214}
        <ffffffff801314a9>{sys_sched_setscheduler+9} 
<ffffffff80110496>{system_call+126}

Unable to handle kernel paging request at 00000000000c1644 RIP:
<ffffffff8013564d>{profile_hit+45}
PML4 15e0e067 PGD 15e44067 PMD 0
Oops: 0002 [8] PREEMPT
CPU 0
Modules linked in: usbcore snd_intel8x0 snd_ac97_codec snd_pcm snd_timer 
snd snd_page_alloc evdev sis900 sg sd_mod scsi_mod
Pid: 7366, comm: gaim Not tainted 2.6.9-rc4-mm1
RIP: 0010:[<ffffffff8013564d>] <ffffffff8013564d>{profile_hit+45}
RSP: 0018:000001001678ff20  EFLAGS: 00010082
RAX: 0000000000000000 RBX: 00000100165098a0 RCX: 0000000000000000
RDX: 00000100165099d8 RSI: 00000000000c1644 RDI: 0000000000000002
RBP: 000001001678ff68 R08: 0000000000000001 R09: 0000002a97823a01
R10: 0000002a9556b9c8 R11: 0000000000000202 R12: 0000000000000000
R13: 00000000ffffffea R14: 0000007fbfff5404 R15: ffffffff804543e0
FS:  00000000005e34a0(005b) GS:ffffffff80497840(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000c1644 CR3: 0000000000101000 CR4: 00000000000006e0
Process gaim (pid: 7366, threadinfo 000001001678e000, task 00000100165098a0)
Stack: ffffffff801312f6 0000002a9a51f17f 0000000000000006 0000000000000000
        0000002a95899820 0000000000004000 0000000000000000 0000007fbfff5404
        0000000000000001 000001001678ff78
Call Trace:<ffffffff801312f6>{setscheduler+214} 
<ffffffff801314a9>{sys_sched_setscheduler+9}
        <ffffffff80110496>{system_call+126}

Code: ff 06 c3 48 83 ec 08 39 3d 86 49 32 00 75 54 48 83 3d 64 49
RIP <ffffffff8013564d>{profile_hit+45} RSP <000001001678ff20>
CR2: 00000000000c1644
  <6>note: gaim[7366] exited with preempt_count 2
scheduling while atomic: gaim/0x04000002/7366

Call Trace:<ffffffff803358e7>{schedule+119} 
<ffffffff80130e34>{__wake_up+84}
        <ffffffff803364cf>{cond_resched+63} 
<ffffffff801633af>{unmap_vmas+1519}
        <ffffffff80168316>{exit_mmap+118} <ffffffff801322a0>{mmput+48}
        <ffffffff801369f3>{do_exit+483} <ffffffff801119ee>{oops_end+62}
        <ffffffff801212df>{do_page_fault+1263} 
<ffffffff80163d42>{do_wp_page+354}
        <ffffffff80165021>{handle_mm_fault+1185} 
<ffffffff8018fa28>{inode_update_time+168}
        <ffffffff80110d49>{error_exit+0} <ffffffff8013564d>{profile_hit+45}
        <ffffffff801312f6>{setscheduler+214
