Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbUEFUv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbUEFUv2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 16:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262956AbUEFUv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 16:51:28 -0400
Received: from potato.cts.ucla.edu ([149.142.36.49]:29355 "EHLO
	potato.cts.ucla.edu") by vger.kernel.org with ESMTP id S262329AbUEFUvV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 16:51:21 -0400
Date: Thu, 6 May 2004 13:50:17 -0700 (PDT)
From: Chris Stromsoe <cbs@cts.ucla.edu>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: linux-kernel@vger.kernel.org, sct@redhat.com, davem@redhat.com
Subject: Re: two lockups with 2.4.25
In-Reply-To: <20040503125829.GB29160@logos.cnet>
Message-ID: <Pine.LNX.4.58.0405061345520.14304@potato.cts.ucla.edu>
References: <Pine.LNX.4.58.0404201554590.4433@potato.cts.ucla.edu>
 <20040503125829.GB29160@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 May 2004, Marcelo Tosatti wrote:

> > >>EIP; 00000001 Before first symbol   <=====
> >
> > Trace; c019cd05 <sys_semtimedop+551/684>
> > Trace; f8d0c83d <[eepro100]speedo_start_xmit+16d/1f4>
> > Trace; c0231403 <nf_hook_slow+103/180>
> > Trace; c022648d <memcpy_toiovec+35/64>
> > Trace; c0224b3f <skb_release_data+6b/74>
> > Trace; c0224b56 <kfree_skbmem+e/70>
> > Trace; c0224ce1 <__kfree_skb+129/134>
> > Trace; c0253926 <tcp_v4_destroy_sock+82/170>
> > Trace; c0223a93 <sk_free+6f/78>
> > Trace; c0244711 <tcp_close+815/820>
> > Trace; c014c8ec <destroy_inode+5c/64>
> > Trace; c014b37b <dput+1b/15c>
> > Trace; c01218f6 <sys_rt_sigaction+92/13c>
> > Trace; c010c605 <sys_ipc+3d/238>
> > Trace; c0106ed3 <system_call+33/38>
> > Proc;  mimedefang
>
> There's also a lot of network activity.

network activity is constant.  The machine takes email messages, scans
them with a virus scanner, and reports a status code all over the network.
It handles between 600k and 750k email messages per day.

Messages that carry a virus payload are locally quarantined on a JFS
partition that is built on top of a raid5 MD.  All of the system
partitions are on /dev/sda.  The md0 is built out of sdb1, sdc1, and sdd1.
See my follow-up message from several days ago with message-id
<Pine.LNX.4.58.0404292322460.16175@potato.cts.ucla.edu> and the subject
"now happening with 2.4.26, Re: two lockups with 2.4.25" for more
extensive information.



-Chris


On Mon, 3 May 2004, Marcelo Tosatti wrote:

> On Tue, Apr 20, 2004 at 04:01:32PM -0700, Chris Stromsoe wrote:
> > I had two different machines lock up within hours of each other this
> > morning.  They have the exact same hardware and had very similar uptimes
> > (within hours of each other).
> >
> > Both machines have a single SCSI disk on an onboard adaptec controller.
> > All partitions are ext3.  There are 3 other disks arranged in a RAID5
> > partition that are formatted JFS.
> >
> > The machines run as virus quarantine servers, writing about 50k messages
> > to disk per day.  The files are written out into directories as
> > year/month/day/hour/filename.  There are usually around 2k to 3k files per
> > directory.
> >
> > Both machines locked up hard.  I was able to get sysrq+t output from one
> > machine, but nothing from the other (it has no serial console).  I ran the
> > output through ksymoops.  It's listed below.
> >
> >
> >
> > -Chris
> >
> >
> > ksymoops 2.4.5 on i686 2.4.25.  Options used
> >      -V (default)
> >      -k /proc/ksyms (specified)
> >      -l /proc/modules (specified)
> >      -o /lib/modules/2.4.25/ (specified)
> >      -m /boot/System.map-2.4.25 (specified)
> >
> > Pid: 26885, comm:               sophie
> > EIP: 0010:[<c0110ed7>] CPU: 1 EFLAGS: 00000202    Not tainted
> > Using defaults from ksymoops -t elf32-i386 -a i386
> > EAX: 00000001 EBX: 00000001 ECX: 00000202 EDX: 01000000
> > ESI: f4762cc0 EDI: 081a1d28 EBP: e806fe94 DS: 0018 ES: 0018
> > Warning (Oops_set_regs): garbage 'DS: 0018 ES: 0018' at end of register line ignored
> > CR0: 8005003b CR2: 081a1d28 CR3: 14c2c000 CR4: 00000690
> > Call Trace:    [<c011100f>] [<c01259b7>] [<c01260de>] [<c01132f9>] [<c0113158>]
> >   [<c0224ce1>] [<c01145e3>] [<c0106fc4>]
> > Warning (Oops_read): Code line not seen, dumping what data is available
> >
> >
> > >>EIP; c0110ed7 <flush_tlb_others+9b/bc>   <=====
> >
> > >>EDX; 01000000 Before first symbol
> > >>ESI; f4762cc0 <_end+343c85cc/3896e90c>
> > >>EDI; 081a1d28 Before first symbol
> > >>EBP; e806fe94 <_end+27cd57a0/3896e90c>
> >
> > Trace; c011100f <flush_tlb_page+6f/7c>
> > Trace; c01259b7 <do_wp_page+223/284>
> > Trace; c01260de <handle_mm_fault+82/b8>
> > Trace; c01132f9 <do_page_fault+1a1/4ed>
> > Trace; c0113158 <do_page_fault+0/4ed>
> > Trace; c0224ce1 <__kfree_skb+129/134>
> > Trace; c01145e3 <schedule+45b/520>
> > Trace; c0106fc4 <error_code+34/3c>
>
> The thing is flush_tlb_others can't block. It calls invlpg.
>
> > init          R C3FFBF28     0     1      0 18517               (NOTLB)
> > Call Trace:    [<c0130fc1>] [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>]
> >   [<c0106ed3>]
> > sophie        R current      0 26885  12367               26884 (NOTLB)
> > Call Trace:    [<c0106fc4>]
> > mimedefang    R DA151F28     4 26886  12405         26887 26879 (NOTLB)
> > Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> > mimedefang    R EF435F28  2408 26887  12405         26888 26886 (NOTLB)
> > Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> > mimedefang    R CC989F28     0 26888  12405         26889 26887 (NOTLB)
> > Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> > mimedefang    R E5A83F28     0 26889  12405         26890 26888 (NOTLB)
> > Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> > mimedefang    R F67E5F28     0 26890  12405               26889 (NOTLB)
> > Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> > Warning (Oops_read): Code line not seen, dumping what data is available
> >
>
> > >>EIP; c3fa2000 <_end+3c0790c/3896e90c>   <=====
> >
> > Trace; c0194c68 <jfsIOWait+13c/168>
> > Trace; c0105680 <arch_kernel_thread+28/38>
> > Proc;  jfsCommit
> >
> > >>EIP; f70c0cc0 <_end+36d265cc/3896e90c>   <=====
> >
> > Trace; c019776b <txLazyCommit+23/ac>
> > Trace; c0197960 <jfs_lazycommit+16c/1f4>
> > Trace; c0105680 <arch_kernel_thread+28/38>
> > Proc;  jfsSync
> >
> > >>EIP; c0366180 <TxAnchor+40/60>   <=====
> >
> > Trace; c0197ed3 <jfs_sync+25b/28c>
> > Trace; c0105680 <arch_kernel_thread+28/38>
> > Proc;  ahc_dv_0
>
> This might be a problem in JFS? shaggy, can you take a look at this?
>
>
> > Trace; c0248577 <tcp_clean_rtx_queue+18f/2fc>
> > Trace; c0224b3f <skb_release_data+6b/74>
> > Trace; c0224b56 <kfree_skbmem+e/70>
> > Trace; c0224ce1 <__kfree_skb+129/134>
> > Trace; c024c369 <tcp_rcv_state_process+9e5/9f1>
> > Trace; c0131497 <__free_pages+1f/24>
> > Trace; c02539fe <tcp_v4_destroy_sock+15a/170>
> > Trace; c0223a93 <sk_free+6f/78>
> > Trace; c0244711 <tcp_close+815/820>
> > Trace; c014c8ec <destroy_inode+5c/64>
> > Trace; c014b37b <dput+1b/15c>
> > Trace; c01218f6 <sys_rt_sigaction+92/13c>
> > Trace; c010c605 <sys_ipc+3d/238>
> > Trace; c0106ed3 <system_call+33/38>
> > Proc;  apache
> >
> > >>EIP; 00000001 Before first symbol   <=====
> >
> > Trace; c019cd05 <sys_semtimedop+551/684>
> > Trace; f8d0c83d <[eepro100]speedo_start_xmit+16d/1f4>
> > Trace; c0231403 <nf_hook_slow+103/180>
> > Trace; c022648d <memcpy_toiovec+35/64>
> > Trace; c0224b3f <skb_release_data+6b/74>
> > Trace; c0224b56 <kfree_skbmem+e/70>
> > Trace; c0224ce1 <__kfree_skb+129/134>
> > Trace; c0253926 <tcp_v4_destroy_sock+82/170>
> > Trace; c0223a93 <sk_free+6f/78>
> > Trace; c0244711 <tcp_close+815/820>
> > Trace; c014c8ec <destroy_inode+5c/64>
> > Trace; c014b37b <dput+1b/15c>
> > Trace; c01218f6 <sys_rt_sigaction+92/13c>
> > Trace; c010c605 <sys_ipc+3d/238>
> > Trace; c0106ed3 <system_call+33/38>
> > Proc;  mimedefang
>
> There's also a lot of network activity.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
