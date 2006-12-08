Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425098AbWLHHmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425098AbWLHHmo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 02:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425097AbWLHHmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 02:42:44 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:43709 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425096AbWLHHmo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 02:42:44 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Lu, Yinghai" <yinghai.lu@amd.com>
Cc: "Greg KH" <gregkh@suse.de>, "Peter Stuge" <stuge-linuxbios@cdy.org>,
       linux-usb-devel@lists.sourceforge.net,
       "Stefan Reinauer" <stepan@coresystems.de>, linux-kernel@vger.kernel.org,
       linuxbios@linuxbios.org, "Andi Kleen" <ak@suse.de>,
       "David Brownell" <david-b@pacbell.net>
Subject: Re: [LinuxBIOS] [linux-usb-devel] [RFC][PATCH 0/2] x86_64 Early usb debug port support.
References: <5986589C150B2F49A46483AC44C7BCA49072A5@ssvlexmb2.amd.com>
Date: Fri, 08 Dec 2006 00:42:04 -0700
In-Reply-To: <5986589C150B2F49A46483AC44C7BCA49072A5@ssvlexmb2.amd.com>
	(Yinghai Lu's message of "Thu, 7 Dec 2006 19:48:17 -0800")
Message-ID: <m17ix24ywj.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Lu, Yinghai" <yinghai.lu@amd.com> writes:

> -----Original Message-----
> From: linuxbios-bounces@linuxbios.org
> [mailto:linuxbios-bounces@linuxbios.org] On Behalf Of
> ebiederm@xmission.com
>
>
>>Ok due to popular demands here is the slightly fixed patch that works
>>on both i386 and x86_64.  For the i386 version you must not have
>>HIGHMEM64G enabled. 
>
>>I just rolled it all into one patch as I'm to lazy to transmit all
>>3 of them.
>
>
> I got
>
> Firmware type: LinuxBIOS
> Linux version 2.6.19-smp-gc9976797-dirty (root@lbsrv) (gcc version
> 4.0.2) #196 6
> Command line: earlyprintk=ttyS0,115200 apic=debug pci=noacpi,routeirq
> snd-hda-i
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 0000000000001000 (reserved)
>  BIOS-e820: 0000000000001000 - 00000000000a0000 (usable)
>  BIOS-e820: 00000000000c0000 - 00000000000f0000 (usable)
>  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 00000000c0000000 (usable)
>  BIOS-e820: 0000000100000000 - 0000000240000000 (usable)
> dbgp_num: 0
> Found EHCI debug port
> bar: 10 offset: 098
> bar: 10 offset: 098
> dbgp pre-set_fixmap_nocache
> PANIC: early exception rip ffffffff809c24b4 error 0 cr2 ffff810000203ff8
>
> Call Trace:
>  [<ffffffff809c24b4>] __set_fixmap+0x84/0x202
>  [<ffffffff809c05bb>] early_dbgp_init+0x259/0x55c
>  [<ffffffff8022d958>] __call_console_drivers+0x64/0x72
>  [<ffffffff809b242b>] do_early_param+0x0/0x57
>  [<ffffffff809c0a20>] setup_early_printk+0x162/0x17e
>  [<ffffffff809b2459>] do_early_param+0x2e/0x57
>  [<ffffffff8023d051>] parse_args+0x159/0x1f3
>  [<ffffffff809b24c2>] parse_early_param+0x40/0x4c
>  [<ffffffff809b88ca>] setup_arch+0x1c1/0x636
>  [<ffffffff809b2534>] start_kernel+0x55/0x208
>  [<ffffffff809b2173>] _sinittext+0x173/0x177
>
> RIP __set_fixmap+0x84/0x202

Ugh.  I'd check the code.  But it looks like my tweak to the
early fixmap code.  But my hunch is that my tweak to __fixmap
so that it's pud and pmd were prepopulated didn't take on
your build.

> With Eric code in LinuxBIOS, it will report "No device found in debug
> port"

Hmm.  At least this is partial progress :)

Eric

