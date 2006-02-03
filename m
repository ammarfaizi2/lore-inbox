Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945940AbWBCUSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945940AbWBCUSF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 15:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWBCUSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 15:18:05 -0500
Received: from pilet.ens-lyon.fr ([140.77.167.16]:32651 "EHLO
	pilet.ens-lyon.fr") by vger.kernel.org with ESMTP id S1751267AbWBCUSC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 15:18:02 -0500
Date: Fri, 3 Feb 2006 21:13:34 +0100
From: Benoit Boissinot <bboissin@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm5
Message-ID: <20060203201334.GA23182@ens-lyon.fr>
References: <20060203000704.3964a39f.akpm@osdl.org> <40f323d00602030217l77db3dd0o4f3f66eac74950f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40f323d00602030217l77db3dd0o4f3f66eac74950f3@mail.gmail.com>
X-Sieve: CMU Sieve 2.2
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/06, Benoit Boissinot <bboissin@gmail.com> wrote:
> On 2/3/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm5/
> >
> >
> > - The ntp/time rework patches from John Stultz have been resurrected and fixed.
> >
> > - There's now a `hot-fixes' directory at the above URL.  Please look in
> >   there for any updates which should be applied.
>
> It runs fine here, no problems. Even iptables works this time.

Actually it spoke too fast, I have the following oops with
CONFIG_DEBUG_INITDATA=y (it does not oops without this config
option).

I can send full dmesg and .config if needed (the bug is reproducable).

with gcc4.1 (I supposed buffered_rmqueue is inlined):

BUG: unable to handle kernel paging request at virtual address c0401000
 printing eip:
c013ea41
*pde = 1ff0a163
*pte = 00401000
Oops: 0002 [#1]
last sysfs file: /devices/pci0000:00/0000:00:1e.0/0000:02:03.0/rf_kill
Modules linked in: aes ieee80211_crypt_ccmp radeon drm ipt_multiport xt_state xt_limit ipt_REJECT xt_tcpudp iptable_filter iptable_nat ip_nat ip_tables x_tables ip_conntrack_irc ip_conntrack_ftp ip_conntrack nfnetlink snd_seq snd_seq_device snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc speedstep_centrino cpufreq_stats freq_table cpufreq_conservative cpufreq_ondemand cpufreq_performance cpufreq_powersave fan button thermal processor battery ac uhci_hcd ehci_hcd usbcore tg3 ipw2200 ieee80211 ieee80211_crypt psmouse ide_cd cdrom
CPU:    0
EIP:    0060:[<c013ea41>]    Not tainted VLI
EFLAGS: 00010287   (2.6.16-rc1-mm5-casaverde #15) 
EIP is at get_page_from_freelist+0x2d1/0x330
eax: 00000000   ebx: 00000000   ecx: 00000400   edx: 00000400
esi: c1008020   edi: c0401000   ebp: da64eed8   esp: da64ee8c
ds: 007b   es: 007b   ss: 0068
Process hg (pid: 18179, threadinfo=da64e000 task=da437560)
Stack: <0>00000002 00000044 c1008020 00000001 00000001 c03b8b60 00000000 c03b8b40 
       00000002 00000000 000280d2 c03b900c 00000000 00000202 00000000 00000001 
       c03b9008 da437560 000280d2 da64ef18 c013f1b5 00000044 00000000 00000000 
Call Trace:
 <c0103f05> show_stack_log_lvl+0xc5/0xf0   <c01040ba> show_registers+0x18a/0x210
 <c010421f> die+0xdf/0x1f0   <c0114266> do_page_fault+0x276/0x5ec
 <c010391f> error_code+0x4f/0x54   <c013f1b5> __alloc_pages+0x55/0x2c0
 <c01461d4> __handle_mm_fault+0x3f4/0x730   <c01143b4> do_page_fault+0x3c4/0x5ec
 <c010391f> error_code+0x4f/0x54  
Code: 89 75 bc 31 db ba 00 04 00 00 c7 45 e4 00 00 00 00 a1 30 66 45 c0 89 d1 8b 7d bc 29 c7 89 d8 c1 ff 05 c1 e7 0c 81 ef 00 00 00 40 <f3> ab ff 45 e4 83 45 bc 20 8b 4d e4 39 4d c4 75 d5 e9 15 ff ff 

with gcc-3.4:

BUG: unable to handle kernel paging request at virtual address c0450000
 printing eip:
c013fdf9
*pde = 1ff37163
*pte = 00450000
Oops: 0002 [#1]
last sysfs file: /devices/pci0000:00/0000:00:1e.0/0000:02:03.0/rf_kill
Modules linked in: radeon drm aes ieee80211_crypt_ccmp ipt_multiport xt_state xt_limit ipt_REJECT xt_tcpudp iptable_filter iptable_nat ip_nat ip_tables x_tables ip_conntrack_irc ip_conntrack_ftp ip_conntrack nfnetlink snd_seq snd_seq_device snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc speedstep_centrino cpufreq_stats freq_table cpufreq_conservative cpufreq_ondemand cpufreq_performance cpufreq_powersave fan button thermal processor battery ac uhci_hcd ehci_hcd usbcore tg3 ipw2200 ieee80211 ieee80211_crypt psmouse ide_cd cdrom
CPU:    0
EIP:    0060:[<c013fdf9>]    Not tainted VLI
EFLAGS: 00210287   (2.6.16-rc1-mm5-casaverde #17) 
EIP is at buffered_rmqueue+0x169/0x1f0
eax: 00000000   ebx: 00000400   ecx: 00000400   edx: c1008a00
esi: 00000000   edi: c0450000   ebp: dfa67c74   esp: dfa67c50
ds: 007b   es: 007b   ss: 0068
Process hg (pid: 7823, threadinfo=dfa67000 task=df95e560)
Stack: <0>c03d206c 00000001 00000000 c1008a00 00200246 00000000 c03d250c 00000044 
       00000000 dfa67ca0 c013ffe3 000280d2 00000044 00000002 c03d2508 00000000 
       000280d2 c03d2508 000280d2 df95e560 dfa67cdc c014005e 00000044 c01fbcf3 
Call Trace:
 <c0103d01> show_stack_log_lvl+0xa1/0xe0   <c0103ee4> show_registers+0x174/0x1f0
 <c01040d2> die+0xd2/0x160   <c011458f> do_page_fault+0x39f/0x599
 <c0103953> error_code+0x4f/0x54   <c013ffe3> get_page_from_freelist+0xa3/0xd0
 <c014005e> __alloc_pages+0x4e/0x2b0   <c0148790> do_anonymous_page+0x40/0x130
 <c0148b9f> __handle_mm_fault+0xaf/0x210   <c01143ae> do_page_fault+0x1be/0x599
 <c0103953> error_code+0x4f/0x54   <c013bf4c> do_generic_mapping_read+0x3ec/0x610
 <c013c3e4> __generic_file_aio_read+0x184/0x200   <c013c557> generic_file_read+0x97/0xc0
 <c0158078> vfs_read+0x88/0x160   <c01583fd> sys_read+0x3d/0x70
 <c0102e3f> sysenter_past_esp+0x54/0x75  
Code: 00 7e 32 89 7d e0 8b 55 e8 31 f6 bb 00 04 00 00 89 f6 a1 30 96 47 c0 89 d7 89 d9 29 c7 c1 ff 05 89 f0 c1 e7 0c 81 ef 00 00 00 40 <f3> ab 83 c2 20 ff 4d e0 75 dd 8b 5d f0 85 db 74 09 f7 45 08 00 
