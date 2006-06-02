Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751279AbWFBHtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbWFBHtE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 03:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbWFBHtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 03:49:04 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:9419
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751279AbWFBHtC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 03:49:02 -0400
Message-Id: <448009B8.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Fri, 02 Jun 2006 09:49:44 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Laurent Riffard" <laurent.riffard@free.fr>,
       "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-rc5-mm1
References: <20060530022925.8a67b613.akpm@osdl.org> <447DD4D3.3060205@free.fr> <20060601150713.5bf84161.akpm@osdl.org>
In-Reply-To: <20060601150713.5bf84161.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Andrew Morton <akpm@osdl.org> 02.06.06 00:07 >>>
>Laurent Riffard <laurent.riffard@free.fr> wrote:
>>
>> Le 30.05.2006 11:29, Andrew Morton a écrit :
>> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm1/ 
>> 
>> Hello, I've got this nice BUG:
>> 
>> pktcdvd: writer pktcdvd0 mapped to hdc
>> BUG: unable to handle kernel NULL pointer dereference at virtual address 00000084
>>  printing eip:
>> c01118f1
>> *pde = 00000000
>> Oops: 0000 [#1]
>> last sysfs file: /block/pktcdvd0/removable
>> Modules linked in: pktcdvd lp parport_pc parport snd_pcm_oss snd_mixer_oss snd_ens1371 gameport snd_rawmidi snd_seq_device
>snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd_page_alloc snd soundcore af_packet floppy ide_cd cdrom loop aes dm_crypt
>nls_iso8859_1 nls_cp850 vfat fat reiser4 reiserfs via_agp agpgart video joydev ohci1394 usbhid ieee1394 uhci_hcd usbcore dm_mirror
>dm_mod via82cxxx
>> CPU:    0
>> EIP:    0060:[<c01118f1>]    Not tainted VLI
>> EFLAGS: 00010006   (2.6.17-rc5-mm1 #11) 
>> EIP is at do_page_fault+0xb4/0x5bc
>> eax: d6750084   ebx: d6750000   ecx: 0000007b   edx: 00000000
>> esi: d6758000   edi: c011183d   ebp: d675007c   esp: d6750044
>> ds: 007b   es: 007b   ss: 0068
>> Process  (pid: 0, threadinfo=d674f000 task=d657c000)
>> Stack: 00000000 d6750084 00000000 00000049 00000084 00000000 00001e2e 02001120 
>>        00000027 00000022 00000055 d6750000 d6758000 c011183d d67500f0 c010340d 
>>        d6750000 0000007b 00000000 d6758000 c011183d d67500f0 d67500f8 0000007b 
>> Call Trace:
>>  [<c010340d>] error_code+0x39/0x40
>> Code: 00 00 c0 81 0f 84 12 02 00 00 e9 1c 05 00 00 8b 45 cc f7 40 30 00 02 02 00 74 06 e8 68 af 01 00 fb f7 43 14 ff ff ff ef
>8b 55 d0 <8b> b2 84 00 00 00 0f 85 e5 01 00 00 85 f6 0f 84 dd 01 00 00 8d 
>> EIP: [<c01118f1>] do_page_fault+0xb4/0x5bc SS:ESP 0068:d6750044
>>  <0>Kernel panic - not syncing: Fatal exception in interrupt
>...

>Jan, this stack trace looks wrong.  We have no information which tells us
>how we entered the pagefault handler.  Userspace hasn't started up yet, so
>we probably entered the fault handler from the kernel.  But that info has
>been lost.

I agree that the trace is incomplete, but I'm not certain (without seeing at least twice as much of the raw stack) whether the unwinder is to blame here. After all, looking at the registers, the stack was already overflowed at the point the (nested) exception was taken, so there is no way to know whether the stack contents can actually be relied upon.

Jan


