Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266170AbUJLQON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266170AbUJLQON (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 12:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266163AbUJLQOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 12:14:08 -0400
Received: from dsl-kpogw5jd0.dial.inet.fi ([80.223.105.208]:49361 "EHLO
	safari.iki.fi") by vger.kernel.org with ESMTP id S266096AbUJLQLw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 12:11:52 -0400
Date: Tue, 12 Oct 2004 19:11:50 +0300
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc4 Oops in s_show / prune_dcache
Message-ID: <20041012161150.GC15056@m.safari.iki.fi>
Mail-Followup-To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20041012122950.GA24892@m.safari.iki.fi> <20041012140016.GY23987@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041012140016.GY23987@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2004 at 03:00:16PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Tue, Oct 12, 2004 at 03:29:50PM +0300, Sami Farin wrote:
> > CPU:    0
> > EIP:    0060:[<c013e798>]    Not tainted VLI
> > EFLAGS: 00210006   (2.6.9-rc4) 
> > EIP is at s_show+0x54/0x1b4
> > eax: c0368f15   ebx: c0368f15   ecx: 14000008   edx: 0000000a
> > esi: c132c860   edi: c132c874   ebp: ce5d8f2c   esp: ce5d8f00
> > ds: 007b   es: 007b   ss: 0068
> > Process ss (pid: 20558, threadinfo=ce5d8000 task=c3787450)
> > Stack: c053da20 c132c860 00000000 c037f356 00000000 c132c7fc c132c7fc 00000008 
> >        00000000 000008b2 000056f4 ce5d8f6c c0169dba c053da20 c132c860 00000000 
> >        cf4fea60 ce5d8fb0 c053da38 ce5d8f64 000002ed c053da38 0000000e 00000035 
> 
> s_show() from mm/slab.c; looks like cachep->lists.slabs_full.next == 0x14000008
> which is certainly not a kernel pointer...

Certainly not a valid one... :)

I just noticed that udevd didn't create /dev/cpu/microcode (it made
/dev/microcode) so microcode_ctl failed to run for 2.6.9-rc4.
I hope old microcode does not cause this kinds of things in the
kernel-land.
kernel: microcode: CPU0 updated from revision 0x4 to 0xa, date = 05051999 
( Celeron Mendocino Original OEM 8) )

One minute before I was going to boot from 2.6.9-rc2-bk7-gcc2593 to 2.6.9-rc4,
I got more slab fun.  2.6.9-rc2-bk7 ran nicely for 18 days before this.

Oct 12 01:04:01 safari kernel: ------------[ cut here ]------------
Oct 12 01:04:01 safari kernel: kernel BUG at mm/slab.c:1900!
Oct 12 01:04:01 safari kernel: invalid operand: 0000 [#1]
Oct 12 01:04:01 safari kernel: SMP 
Oct 12 01:04:01 safari kernel: Modules linked in: pppoe pppox ppp_generic slhc
        ip6t_owner nls_utf8 sch_hfsc cls_fw cls_route sch_ingress sch_red sch_tbf
        sch_teql sch_prio sch_gred cls_rsvp cls_rsvp6 cls_tcindex sch_cbq sch_dsmark
        ipt_ttl ipt_tos ipt_tcpmss ipt_sctp ipt_recent ipt_pkttype ipt_physdev
        ipt_mark ipt_mac ipt_iprange ipt_helper ipt_esp ipt_ecn ipt_dscp ipt_conntrack
        ipt_ah ipt_addrtype ipt_ULOG ipt_TOS ipt_TCPMSS ipt_SAME ipt_REDIRECT
        ipt_NOTRACK ipt_NETMAP ipt_MASQUERADE ipt_MARK ipt_DSCP ipt_CLASSIFY xfs
        snd_seq_midi snd_seq_oss snd_seq_midi_event snd_seq lp parport_pc parport
        w83781d i2c_sensor mga i2c_piix4 tuner tvaudio msp3400 bttv video_buf
        i2c_algo_bit v4l2_common btcx_risc i2c_core videodev ohci_hcd loop
        ipt_connlimit ipt_length ipt_TARPIT ipt_ECN ipt_state dm_mod ipt_multiport
        ipt_owner cls_u32 sch_sfq sch_htb ipt_REJECT ip6t_LOG ipt_LOG ipt_limit
        uhci_hcd ip6table_filter ip6_tables md5 ipv6 snd_ens1371 snd_rawmidi
        iptable_raw snd_seq_device iptable_mangle snd_pcm_oss iptable_nat snd_mixer_
Oct 12 01:04:01 safari kernel: ss ip_conntrack snd_pcm iptable_filter
        ip_tables snd_timer snd_page_alloc snd_ac97_codec snd soundcore irlan irda
        crc_ccitt 8139too mii floppy sg scsi_mod
Oct 12 01:04:01 safari kernel: CPU:    0
Oct 12 01:04:01 safari kernel: EIP:    0060:[<c01415fd>]    Not tainted VLI
Oct 12 01:04:01 safari kernel: EFLAGS: 00210006   (2.6.9-rc2-bk7-gcc2953) 
Oct 12 01:04:01 safari kernel: EIP is at cache_free_debugcheck+0x141/0x1c0
Oct 12 01:04:01 safari kernel: eax: 012f254d   ebx: ca2ae020   ecx: 033a6c08   edx: 00000068
Oct 12 01:04:01 safari kernel: esi: ca2ae6f8   edi: c12d99e0   ebp: c19dcef0   esp: c19dcee0
Oct 12 01:04:01 safari kernel: ds: 007b   es: 007b   ss: 0068
Oct 12 01:04:01 safari kernel: Process su (pid: 8467, threadinfo=c19dc000 task=cc3852b0)
Oct 12 01:04:01 safari kernel: Stack: c12de03c c12d99e0 ca2ae6fc 000000a8 c19dcf14 c01420fa c12d99e0 ca2ae6fc 
Oct 12 01:04:01 safari kernel:        c0156085 ca2ae6fc c12e3a70 c4e775cc 00200282 c19dcf34 c0156085 c12d99e0 
Oct 12 01:04:01 safari kernel:        ca2ae6fc c4e7767c ca2ae6fc c4e776a8 c186e230 c19dcf3c c0155f93 c19dcf50 
Oct 12 01:04:01 safari kernel: Call Trace:
Oct 12 01:04:01 safari kernel:  [<c0106163>] show_stack+0x7f/0x8c
Oct 12 01:04:01 safari kernel:  [<c01062a2>] show_registers+0x112/0x184
Oct 12 01:04:01 safari kernel:  [<c010646b>] die+0xe7/0x16c
Oct 12 01:04:01 safari kernel:  [<c010689b>] do_invalid_op+0xbf/0xcc
Oct 12 01:04:01 safari kernel:  [<c0348cc3>] error_code+0x2f/0x38
Oct 12 01:04:01 safari kernel:  [<c01420fa>] kmem_cache_free+0x36/0x74
Oct 12 01:04:01 safari kernel:  [<c0156085>] __fput+0xed/0x124
Oct 12 01:04:01 safari kernel:  [<c0155f93>] fput+0x17/0x1c
Oct 12 01:04:01 safari kernel:  [<c0148cb5>] remove_vm_struct+0x6d/0x94
Oct 12 01:04:01 safari kernel:  [<c014a455>] unmap_vma+0x59/0x60
Oct 12 01:04:01 safari kernel:  [<c014a471>] unmap_vma_list+0x15/0x28
Oct 12 01:04:01 safari kernel:  [<c014a818>] do_munmap+0x130/0x13c
Oct 12 01:04:01 safari kernel:  [<c014a870>] sys_munmap+0x4c/0x6c
Oct 12 01:04:01 safari kernel:  [<c034823b>] syscall_call+0x7/0xb
Oct 12 01:04:01 safari kernel: Code: 01 74 11 56 57 e8 40 e8 ff ff 89 c2 8b 45 10 89 02 83 c4 08 8b 4b 0c 8b 57 50 89 f0 29 c8 89 55 fc 31 d2 f7 75 fc 3b 47 58 72 08 <0f> 0b 6c 07 02 0d 36 c0 0f af 45 fc 01 c8 39 c6 74 08 0f 0b 6d 
Oct 12 01:04:01 safari kernel:        c0156085 ca2ae6fc c12e3a70 c4e775cc 00200282 c19dcf34 c0156085 c12d99e0 
Oct 12 01:04:01 safari kernel:        ca2ae6fc c4e7767c ca2ae6fc c4e776a8 c186e230 c19dcf3c c0155f93 c19dcf50 
Oct 12 01:04:01 safari kernel: Call Trace:
Oct 12 01:04:01 safari kernel:  [<c0106163>] show_stack+0x7f/0x8c
Oct 12 01:04:01 safari kernel:  [<c01062a2>] show_registers+0x112/0x184
Oct 12 01:04:01 safari kernel:  [<c010646b>] die+0xe7/0x16c
Oct 12 01:04:01 safari kernel:  [<c010689b>] do_invalid_op+0xbf/0xcc
Oct 12 01:04:01 safari kernel:  [<c0348cc3>] error_code+0x2f/0x38
Oct 12 01:04:01 safari kernel:  [<c01420fa>] kmem_cache_free+0x36/0x74
Oct 12 01:04:01 safari kernel:  [<c0156085>] __fput+0xed/0x124
Oct 12 01:04:01 safari kernel:  [<c0155f93>] fput+0x17/0x1c
Oct 12 01:04:01 safari kernel:  [<c0148cb5>] remove_vm_struct+0x6d/0x94
Oct 12 01:04:01 safari kernel:  [<c014a455>] unmap_vma+0x59/0x60
Oct 12 01:04:01 safari kernel:  [<c014a471>] unmap_vma_list+0x15/0x28
Oct 12 01:04:01 safari kernel:  [<c014a818>] do_munmap+0x130/0x13c
Oct 12 01:04:01 safari kernel:  [<c014a870>] sys_munmap+0x4c/0x6c
Oct 12 01:04:01 safari kernel:  [<c034823b>] syscall_call+0x7/0xb
Oct 12 01:04:01 safari kernel: Code: 01 74 11 56 57 e8 40 e8 ff ff 89 c2 8b 45 10 89 02 83 c4 08 8b 4b 0c 8b 57 50 89 f0 29 c8 89 55 fc 31 d2 f7 75 fc 3b 47 58 72 08 <0f> 0b 6c 07 02 0d 36 c0 0f af 45 fc 01 c8 39 c6 74 08 0f 0b 6d 

I had done "su -l luser" earlier, then pressed ^D in the luser's bash
and got the Oops.

-- 
