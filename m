Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268170AbUJSAvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268170AbUJSAvY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 20:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268177AbUJSAvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 20:51:24 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:45802 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268170AbUJSAvR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 20:51:17 -0400
Date: Tue, 19 Oct 2004 10:49:33 +1000
From: Nathan Scott <nathans@sgi.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Eric Sandeen <sandeen@sgi.com>
Subject: Re: XFS oops on loading the module
Message-ID: <20041019004933.GD918@frodo>
References: <20041016165058.GB32324@cirrus.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041016165058.GB32324@cirrus.madduck.net>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

On Sat, Oct 16, 2004 at 06:50:58PM +0200, martin f krafft wrote:
> I just tried to mount an XFS filesystem on this AMD K6 machine,
> booted with the 2.6.8 kernel for FAI
> (http://www.informatik.uni/koeln.de/fai) (let me know if you need
> any information about it), and modprobe segfaults with a kernel bug.
> Have you seen this before? Thanks!
> 
> sh-2.05b# modprobe xfs
> Segmentation fault
> ------------[ cut here ]------------
> kernel BUG at kernel/module.c:264!

IOW... this, I guess:

        for (i = 0; i < pcpu_num_used; ptr += block_size(pcpu_size[i]), i++) {
                /* Extra for alignment requirement. */
                extra = ALIGN((unsigned long)ptr, align) - (unsigned long)ptr;
                BUG_ON(i == 0 && extra != 0);

> Modules linked in: ext3 jbd mbcache sr_mod sd_mod scsi_mod ide_generic usbmouse usbhid ide_cd cdrom usbkbd floppy rtc via82cxxx slc90e66 sis5513 siimage serverworks rz1000 piix pdc202xx_old pdc202xx_new hpt366 ide_disk hpt34x cs5530 cmd64x amd74xx alim15x3 aec62xx ide_core uhci_hcd usbcore
> CPU:    0
> EIP:    0060:[<c012bcf6>]    Not tainted
> EFLAGS: 00010202   (2.6.8-fai) 
> EIP is at percpu_modalloc+0xe/0xf8
> eax: 0000004b   ebx: e09f9400   ecx: e09f940c   edx: 0000000f
> esi: e09f84c4   edi: 00000258   ebp: e09fa9c8   esp: d9963f0c
> ds: 007b   es: 007b   ss: 0068
> Process modprobe (pid: 1272, threadinfo=d9962000 task=dfb50650)
> Stack: e09f9400 e09f84c4 00000258 e09fa9c8 c012d8be e098f000 c012d8ed 00000148 
>        00000020 40157000 080509b8 c031f504 d9962000 c416c0a0 00000044 00000060 
>        df0ad4e0 00000000 00000000 e09f9400 0000000f 00000000 00000000 00000000 
> Call Trace:
>  [<c012d8be>] load_module+0x3c6/0x904
>  [<c012d8ed>] load_module+0x3f5/0x904
>  [<c012de59>] sys_init_module+0x5d/0x200
>  [<c0105d5f>] syscall_call+0x7/0xb
> Code: 0f 0b 08 01 6f a5 2b c0 89 f6 bd a0 10 40 c0 31 f6 a1 2c 64 
> 

I haven't come across this before - the only percpu variables
in XFS are the performance stats.  I've CC'd a couple of people
who may have more of a clue as to whats gone wrong here.

cheers.

-- 
Nathan
