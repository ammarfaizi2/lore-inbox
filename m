Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbVGBN7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVGBN7P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 09:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbVGBN7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 09:59:15 -0400
Received: from cantor2.suse.de ([195.135.220.15]:4042 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261163AbVGBN66 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 09:58:58 -0400
From: Andreas Schwab <schwab@suse.de>
To: Jeff Mahoney <jeffm@suse.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 0/3] openfirmware/macio: hotplug support
References: <20050629003030.GB24094@locomotive.unixthugs.org>
X-Yow: Should I start with the time I SWITCHED personalities with a BEATNIK
 hair stylist or my failure to refer five TEENAGERS to a good OCULIST?
Date: Sat, 02 Jul 2005 15:58:56 +0200
In-Reply-To: <20050629003030.GB24094@locomotive.unixthugs.org> (Jeff Mahoney's
	message of "Tue, 28 Jun 2005 20:30:30 -0400")
Message-ID: <jeekah71i7.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Mahoney <jeffm@suse.com> writes:

> The following 3 patches, combined with the userspace patches referenced below,
> implement hotplug events for open firmware/macio devices such as apple airport
> wireless ethernet cards.
>
> * 01-openfirmware-device-table.diff
>   - Converts struct of_match to a MODULE_DEVICE_TABLE-compatible
>     struct of_device_id
>   - Uses the information to generate a device table parsable by
>     depmod(8)
>
> * 02-openfirmware-sysfs.diff
>   - Exports openfirmware variables via sysfs so that coldplug can read and
>     take appropriate action
>
> * 03-openfirmware-hotplug.diff
>   - Adds the hotplug routine for generating hotplug events. Uses the
>     information published to provide the hotplug environment variables to
>     userspace.

When I tried them on ppc64 (PowerMac G5) against 2.6.13-rc1, I got various
oopses in sysfs:

Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=2 POWERMAC 
Modules linked in:
NIP: C0000000000FF4B8 XER: 20000000 LR: C0000000000FF468 CTR: C0000000000FF420
REGS: c00000000f377950 TRAP: 0300   Not tainted  (2.6.13-rc1)
MSR: 9000000000009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11 CR: 24000424
DAR: 72676f2d70776ebd DSISR: 0000000040000000
TASK: c000000001d697f0[934] 'cat' THREAD: c00000000f374000 CPU: 0
GPR00: 0000000000000010 C00000000F377BD0 C0000000005EEC88 0000000000000000 
GPR04: C0000000005C9AB0 0000000010015038 0000000000004000 0000000000000028 
GPR08: C000000001D486E8 0000000000000001 72676F2D70776EAD C00000000FEA4150 
GPR12: 0000000000000000 C0000000004AEC00 0000000010015038 0000000000001000 
GPR16: 00000000100ADBC0 0000000010010000 00000000FFE1EDA4 0000000000001000 
GPR20: 0000000000000002 00000000FFFFFFFF 0000000000000000 0000000000000040 
GPR24: 0000000000000000 0000000000001000 0000000010000000 C00000004F426230 
GPR28: C00000000FFE8380 C00000004F696C80 C0000000004D7438 72676F2D70776D2D 
NIP [c0000000000ff4b8] .sysfs_release+0x98/0x110
LR [c0000000000ff468] .sysfs_release+0x48/0x110
Call Trace:
[c00000000f377bd0] [c0000000000ff468] .sysfs_release+0x48/0x110 (unreliable)
[c00000000f377c60] [c0000000000a3158] .__fput+0x88/0x250
[c00000000f377d00] [c00000000009f76c] .filp_close+0x9c/0x100
[c00000000f377d90] [c00000000009fac4] .sys_close+0xc4/0x130
[c00000000f377e30] [c00000000000d600] syscall_exit+0x0/0x18
Instruction dump:
794a3e24 6129ff00 394a0180 7c094838 7d5f5214 2f290000 7c000026 54091ffe 
5400dffe 7c004a14 7c0007b4 78001f24 <7d2a002a> 3929ffff 7d2a012a 60000000 
Oops: Kernel access of bad area, sig: 11 [#2]
SMP NR_CPUS=2 POWERMAC 
Modules linked in:
NIP: C0000000000FF4B8 XER: 20000000 LR: C0000000000FF468 CTR: C0000000000FF420
REGS: c000000001fe7950 TRAP: 0300   Not tainted  (2.6.13-rc1)
MSR: 9000000000009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11 CR: 22448424
DAR: 72676f2d70776f3d DSISR: 0000000040000000
TASK: c000000001f0b7f0[929] 'macio.rc' THREAD: c000000001fe4000 CPU: 1
GPR00: 0000000000000010 C000000001FE7BD0 C0000000005EEC88 0000000000000000 
GPR04: C0000000005C9AB0 00000000100AD8B0 00000000616E6400 0000000000000000 
GPR08: C000000001D486E8 0000000000000001 72676F2D70776F2D C00000000FEA4150 
GPR12: 0000000000000000 C0000000004AF400 0000000010090000 00000000100AD478 
GPR16: 0000000010090000 00000000100AD458 0000000000000000 0000000010090000 
GPR20: 0000000010090000 00000000100AD478 0000000000000001 0000000010090000 
GPR24: 00000000100AD790 0000000010090000 0000000000000000 C00000004F32EE70 
GPR28: C00000000FFE8380 C00000004F696E80 C0000000004D7438 72676F2D70776D2D 
NIP [c0000000000ff4b8] .sysfs_release+0x98/0x110
LR [c0000000000ff468] .sysfs_release+0x48/0x110
Call Trace:
[c000000001fe7bd0] [c0000000000ff468] .sysfs_release+0x48/0x110 (unreliable)
[c000000001fe7c60] [c0000000000a3158] .__fput+0x88/0x250
[c000000001fe7d00] [c00000000009f76c] .filp_close+0x9c/0x100
[c000000001fe7d90] [c00000000009fac4] .sys_close+0xc4/0x130
[c000000001fe7e30] [c00000000000d600] syscall_exit+0x0/0x18
Instruction dump:
794a3e24 6129ff00 394a0180 7c094838 7d5f5214 2f290000 7c000026 54091ffe 
5400dffe 7c004a14 7c0007b4 78001f24 <7d2a002a> 3929ffff 7d2a012a 60000000 
Oops: Kernel access of bad area, sig: 11 [#3]
SMP NR_CPUS=2 POWERMAC 
Modules linked in: usbserial deflate zlib_deflate twofish serpent aes blowfish des sha256 sha1 crypto_null xfrm_user ipcomp esp4 ah4 af_key snd_pcm_oss snd_mixer_oss snd_powermac snd_pcm snd_page_alloc snd_timer snd soundcore ip6table_filter ip6_tables md5 ipv6 ipt_TCPMSS ipt_state ipt_REJECT ipt_LOG iptable_nat ip_conntrack iptable_filter ip_tables subfs evdev joydev sg st sr_mod dm_mod ohci1394 ieee1394 uninorth_agp agpgart
NIP: C0000000001DDA48 XER: 20000000 LR: C0000000001002D4 CTR: C0000000000BED40
REGS: c0000000425af980 TRAP: 0300   Not tainted  (2.6.13-rc1)
MSR: 9000000000009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11 CR: 88002482
DAR: 6b322d6b65796c61 DSISR: 0000000040000000
TASK: c000000042534030[4980] 'hald' THREAD: c0000000425ac000 CPU: 1
GPR00: 0000000000000004 C0000000425AFC00 C0000000005EEC88 6B322D6B65796C61 
GPR04: 6B322D6B65796C60 0000000000000003 0000000000000005 0000000000000312 
GPR08: 000000000000000A C0000000004E8000 C000000001D44660 C000000001D446F0 
GPR12: 31353030303A7469 C0000000004AF400 0000000010040000 0000000010045C24 
GPR16: 0000000010040000 0000000010040000 0000000010040000 0000000010040000 
GPR20: 0000000010030000 0000000010066D00 C0000000425AFDE0 C0000000005B8110 
GPR24: C000000040568180 C000000001D447D8 6B322D6B65796C61 0000000000000003 
GPR28: C000000043D526F0 C000000001D446E8 C0000000004D9388 C000000001D446F0 
NIP [c0000000001dda48] .strlen+0x4/0x18
LR [c0000000001002d4] .sysfs_readdir+0xb4/0x2c0
Call Trace:
[c0000000425afc00] [c000000000100328] .sysfs_readdir+0x108/0x2c0 (unreliable)
[c0000000425afcc0] [c0000000000be8fc] .vfs_readdir+0x15c/0x1a0
[c0000000425afd70] [c0000000000bef10] .sys_getdents64+0xa0/0x130
[c0000000425afe30] [c00000000000d600] syscall_exit+0x0/0x18
Instruction dump:
4082fff4 4e800020 38a3ffff 3884ffff 8c650001 2c830000 8c040001 7c601851 
4d860020 4182ffec 4e800020 3883ffff <8c040001> 2c000000 4082fff8 7c632050 

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
