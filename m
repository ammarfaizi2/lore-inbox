Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261795AbULGM3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbULGM3V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 07:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbULGM3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 07:29:20 -0500
Received: from mx02.cybersurf.com ([209.197.145.105]:19343 "EHLO
	mx02.cybersurf.com") by vger.kernel.org with ESMTP id S261795AbULGM3L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 07:29:11 -0500
Subject: Re: Hard freeze with 2.6.10-rc3 and QoS, worked fine with 2.6.9
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Cataldo <tomc@compaqnet.fr>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, tgraf@suug.ch,
       "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20041206224441.628e7885.akpm@osdl.org>
References: <1102380430.6103.6.camel@buffy>
	 <20041206224441.628e7885.akpm@osdl.org>
Content-Type: text/plain
Organization: jamalopolous
Message-Id: <1102422544.1088.98.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 07 Dec 2004 07:29:04 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you do a: 
tc -V

This seems to point to probably be a backward compat issue which was
overlooked in the stats.

cheers,
jamal

On Tue, 2004-12-07 at 01:44, Andrew Morton wrote:
> Thomas Cataldo <tomc@compaqnet.fr> wrote:
> >
> >  Tonight I upgraded to 2.6.10-rc3. Everything was fine until I started
> >  wondershaper to setup my Qos rules :
> > 
> >  wondershaper eth0 255 16
> > 
> >  And the machine freezed hard. No magic sysrq working, no oops in my
> >  logs.
> > 
> >  The computer is an x86 smp (dual p3)
> > 
> >  wondershaper was working fine with 2.6.9.
> 
> Me too, with your .config:
> 
> Using http://lartc.org/wondershaper/wondershaper-1.1a.tar.gz
> 
> vmm:/home/akpm/wondershaper-1.1a# ./wshaper eth0 255 16
> 
> 
> u32 classifier
>     Perfomance counters on
>     input device check on 
>     Actions configured    
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
>  printing eip:                                                              
> c0290b58      
> *pde = 00000000
> Oops: 0002 [#1]
> SMP            
> Modules linked in: police sch_ingress cls_u32 sch_sfq sch_cbq usbcore
> CPU:    1                                                            
> EIP:    0060:[<c0290b58>]    Not tainted VLI
> EFLAGS: 00010206   (2.6.10-rc3)             
> EIP is at _spin_lock_bh+0x10/0x20
> eax: cf690000   ebx: ce0d4d80   ecx: 00000008   edx: 00000000
> esi: cf691ba0   edi: 00000000   ebp: 00000000   esp: cf691b48
> ds: 007b   es: 007b   ss: 0068                               
> Process tc (pid: 2743, threadinfo=cf690000 task=cf07b520)
> Stack: c02372ab ce0d4d80 cd4d8800 cebd1c40 ce0d4d80 c0237346 ce0d4d80 00000008 
>        00000000 00000000 00000000 cf691ba0 cf691ba0 c02478d6 ce0d4d80 00000008 
>        00000000 cf691ba0 ce0d4d80 cf6a6070 30960094 cec44380 00000000 00019000 
> Call Trace:                                                                    
>  [<c02372ab>] gnet_stats_start_copy_compat+0x1b/0x98
>  [<c0237346>] gnet_stats_start_copy+0x1e/0x24       
>  [<c02478d6>] tcf_action_copy_stats+0x26/0xa0
>  [<c02473e2>] tcf_action_dump_old+0x36/0x3c  
>  [<d0807174>] u32_dump+0x2c8/0x344 [cls_u32]
>  [<d08071a6>] u32_dump+0x2fa/0x344 [cls_u32]
>  [<c0246cf9>] tcf_fill_node+0x11d/0x170     
>  [<c0246d9c>] tfilter_notify+0x50/0xa0 
>  [<c0246bae>] tc_ctl_tfilter+0x542/0x570
>  [<c0240705>] rtnetlink_rcv+0x23d/0x360 
>  [<c0249f08>] netlink_data_ready+0x1c/0x54
>  [<c02495c5>] netlink_sendskb+0x21/0x40   
>  [<c024970b>] netlink_unicast+0xe3/0xec
>  [<c0249d04>] netlink_sendmsg+0x27c/0x28c
>  [<c02306d9>] sock_sendmsg+0xd5/0xf8     
>  [<c02306d9>] sock_sendmsg+0xd5/0xf8
>  [<c01c0a70>] copy_from_user+0x30/0x60
>  [<c01c0a70>] copy_from_user+0x30/0x60
>  [<c0127cfc>] autoremove_wake_function+0x0/0x40
>  [<c0231db7>] sys_sendmsg+0x18f/0x1f4          
>  [<c013c068>] handle_mm_fault+0x80/0x11c
>  [<c010fc3b>] do_page_fault+0x1a3/0x554 
>  [<c01c0a70>] copy_from_user+0x30/0x60 
>  [<c02321bc>] sys_socketcall+0x1d8/0x1f4
>  [<c01021cd>] sysenter_past_esp+0x52/0x71
> Code: 3a 00 7e f9 fa eb e9 c3 8d 76 00 fa f0 fe 08 79 09 f3 90 80 38 00 7e f9 eb f2 c3 89 c2 b8 00 e0 ff ff 21 e0 81 
>  <0>Kernel panic - not syncing: Fatal exception in interrupt                                                        
> Somehow I don't think this is because "Performance" was misspelled ;)
> 
> tcf_act_hdr.stats_lock is NULL in tcf_action_copy_stats()
> 
> 
> 

