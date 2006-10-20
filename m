Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWJTQTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWJTQTO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 12:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbWJTQTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 12:19:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23950 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932267AbWJTQTN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 12:19:13 -0400
Date: Fri, 20 Oct 2006 09:19:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc2-mm2
Message-Id: <20061020091901.71a473e9.akpm@osdl.org>
In-Reply-To: <200610201339.49190.m.kozlowski@tuxland.pl>
References: <20061020015641.b4ed72e5.akpm@osdl.org>
	<200610201339.49190.m.kozlowski@tuxland.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006 13:39:49 +0200
Mariusz Kozlowski <m.kozlowski@tuxland.pl> wrote:

> Hello, 
> 
> 	I installed 2.6.19-rc2-mm2 without kernel debugging options enabled first. 
> The output below is what I saw when the kernel started. Then I enabled 
> debugging and system hangs with oops with no trace in the logs. It is not 
> easily repeatable though. It happens from time to time.
> 
> BUG: unable to handle kernel NULL pointer dereference at virtual address 
> 00000000
>  printing eip:
> ded5bc12
> *pde = 00000000
> Oops: 0000 [#1]
> PREEMPT 
> last sysfs 
> file: /class/pcmcia_socket/pcmcia_socket0/available_resources_setup_done
> Modules linked in: pcmcia firmware_class yenta_socket rsrc_nonstatic 
> pcmcia_core
> CPU:    0
> EIP:    0060:[<ded5bc12>]    Not tainted VLI
> EFLAGS: 00010002   (2.6.19-rc2-mm2 #1)
> EIP is at get_pcmcia_device+0x1e/0x93 [pcmcia]
> eax: ddba2828   ebx: fffffff0   ecx: 00000000   edx: 00000000
> esi: 00000000   edi: 00000000   ebp: 00000246   esp: ddac7f30
> ds: 007b   es: 007b   ss: 0068
> Process cardmgr (pid: 4807, ti=ddac6000 task=ddea7030 task.ti=ddac6000)
> Stack: 40000000 00000000 c00c6409 ddba2828 ded5c777 00000001 00000000 ddba2400 
>        0000000c ddc4930c ded60040 dd5a21c0 bfc9a600 c00c6409 c01661d4 bfc9a600 
>        dd5a21c0 dd5a21c0 00000004 ddac6000 c016622d 00000000 ddea7030 dd5a21c0 
> Call Trace:
>  [<ded5c777>] ds_ioctl+0x88b/0x89f [pcmcia]
>  [<c01661d4>] do_ioctl+0x64/0x6d
>  [<c016622d>] vfs_ioctl+0x50/0x27b
>  [<c016648c>] sys_ioctl+0x34/0x50
>  [<c0102eae>] sysenter_past_esp+0x5f/0x85
>  =======================
> Code: 3f e1 89 d8 e8 f6 7e b1 ff 31 c0 5b c3 55 57 56 53 89 d7 9c 5d fa 89 e2 
> 81 e2 00 e0 ff ff 83 42 14 01 8b 90 44 01 00 00 8d 5a f0 <8b> 4b 10 0f 18 01 
> 90 8d b0 44 01 00 00 39 d6 75 12 eb 37 89 c8 
> EIP: [<ded5bc12>] get_pcmcia_device+0x1e/0x93 [pcmcia] SS:ESP 0068:ddac7f30
>  <6>note: cardmgr[4807] exited with preempt_count 1
> pccard: PCMCIA card inserted into slot 1
> cs: memory probe 0xa0000000-0xa0ffffff: clean.

Don't know.   Nothing has changed in the git-pcmcia tree since July.

Are you able to bisect it, as per
http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt ?

> When running without debug options enabled also these were seen amongst dmesg 
> lines:
> 
> [drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
> [drm:drm_unlock] *ERROR* Process 5131 using kernel context 0

<googles>

This? http://lkml.org/lkml/2005/9/10/78


> When debug options were enabled these above disappeared. System info:
> 
> Linux orion 2.6.19-rc2-mm2 #2 PREEMPT Fri Oct 20 13:14:25 CEST 2006 i686 
> Intel(R) Pentium(R) 4 CPU 2.40GHz GNU/Linux
>  
> Gnu C                  4.1.1
> Gnu make               3.81
> binutils               2.16.1
> util-linux             2.12r
> mount                  2.12r
> module-init-tools      3.2.2
> e2fsprogs              1.39
> pcmcia-cs              3.2.8
> nfs-utils              1.0.6
> Linux C Library        > libc.2.4
> Dynamic linker (ldd)   2.4
> Procps                 3.2.6
> Net-tools              1.60
> Kbd                    1.12
> Sh-utils               5.94
> udev                   087
> Modules Loaded         orinoco_cs orinoco hermes pcmcia firmware_class 
> yenta_socket rsrc_nonstatic pcmcia_core
> 
> This time it _is_ -mm ;-)
> 

Well... that's what it's for ;)  Thanks for testing.
