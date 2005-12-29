Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbVL2Ozt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbVL2Ozt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 09:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbVL2Ozt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 09:55:49 -0500
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:11433 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750750AbVL2Ozt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 09:55:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=3wdb2w7oWEtfr6mb6Hd93HqvlqSgz4k1dCLx6QyE3CQS0DX9WcJVEcUfMGa15ZEF6urFYib+g4P9xBnWB1kbuYA/pR6PtdJYSkX//x1LkX0j97zEEyZX0ChqmWKbn/c9Hs8hdiNtrTa8xO40sRQGr0GIm+4MFTdD36zCWF8Y/90=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net,
       Fuad Abinader Jr <fabinader@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Bridge code Oops with 2.6.14.2 (was: Re: [uml-devel] RE: [uml-user] guest soft lockup after mounting root fs in skasmode)
Date: Thu, 29 Dec 2005 15:55:43 +0100
User-Agent: KMail/1.8.3
Cc: "Brock, Anthony - NET" <Anthony.Brock@oregonstate.edu>,
       "Juraj Holtak" <juraj@proaut.org>,
       "Antoine Martin" <antoine@nagafix.co.uk>
References: <7B4268E5ACB878429B58D4BE5B780E83506DF8@NWS-EXCH2.nws.oregonstate.edu>
In-Reply-To: <7B4268E5ACB878429B58D4BE5B780E83506DF8@NWS-EXCH2.nws.oregonstate.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512291555.44379.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 December 2005 22:38, Brock, Anthony - NET wrote:
> In fact, one of my production servers developed a rather serious issue
> when I upgraded the host kernel from 2.6.13.2 to 2.6.14.2 (both using
> SKAS3-v8.2). The host server would "freeze" hard when shutting down the
> guest instances (no network, console, etc). The issue disappeared when I
> reverted the host back to 2.6.13.2.

> Eventually I traced it back to an instance that was still running a
> 2.6.7 guest kernel. It triggered either during shutdown or within 0-5
> seconds after the instance was "killed" (the guest kernel wouldn't exit
> cleanly). The issue disappeared once I upgraded it to a more recent
> version. Unfortunately, only one of the "freezes" dumped any information
> (see below). Every other "freeze" resulted in a non-responsive system
> where I had to power-cycle to recover.

> So, either SKAS3, the tuntap device, network bridges, or some other host
> component associated with UML instances still has some issues.

The components executing, in the stack trace below, are the network driver, 
which seems e100 driver, in NAPI (i.e. polling) mode, which is used for high 
network traffic only, normally, and the bridge code.

In the thread 

[uml-user] Kernel panic when using NS-2 and UML//TAP devices/ebtables

Fuad Abinader Jr, which I CC:ed on this mail, reports another crash (a 
different one) coming from the use of bridge code (in that case, a BUG_ON 
triggering).

I don't know if there is any association between them, however it seems that 
the bridge code is showing more than one instability.

I can't help more, however - the next step is filing a bug to network 
developers, upstream. For now I'm CC:ing LKML.

> Unable to handle kernel NULL pointer dereference at virtual address
> 00000000
>  printing eip:
> f8be14f4
> *pde = 00000000
> Oops: 0000 [#1]
> SMP
> Modules linked in: autofs4 tun ipv6 bridge floppy pcspkr hw_random
> i2c_amd8111 generic amd74xx shpchp pci_hotplug ohci_hcd usbcore raid1
> md_mod dm_mod rtc w83627hf eeprom lm85 hwmon_vid i2c_isa i2c_amd756
> i2c_core tg3 e100 mii psmouse ide_generic ide_disk ide_cd cdrom ide_core
> unix
> CPU:    1
> EIP:    0060:[<f8be14f4>]    Not tainted VLI
> EFLAGS: 00010287   (2.6.14.2-skas3-v8.2)
> EIP is at br_nf_forward_ip+0xa2/0x16a [bridge]
> eax: 00000000   ebx: d7b59dc0   ecx: ea4a5380   edx: 00000080
> esi: 00000002   edi: 00000002   ebp: f8bdbdb7   esp: e172bcc8
> ds: 007b   es: 007b   ss: 0068
> Process linux-2.6.7-02- (pid: 4049, threadinfo=e172a000 task=e99ed550)
> Stack: 80000000 c03e7350 c02d44e7 00000002 e172bd58 f8be1334 80000000
> ea4a5380
>        e172bd40 80000000 c03e7350 c02d44e7 00000002 e172bd7c f2641000
> efd7e800
>        f8bdbdb7 00000002 e172bd7c c03e7350 f8bdbdb7 c02d4564 c03e7350
> e172bd7c
> Call Trace:
>  [<c02d44e7>] nf_iterate+0x66/0x8a
>  [<f8be1334>] br_nf_forward_finish+0x0/0x11e [bridge]
>  [<c02d44e7>] nf_iterate+0x66/0x8a
>  [<f8bdbdb7>] br_forward_finish+0x0/0x6b [bridge]
>  [<f8bdbdb7>] br_forward_finish+0x0/0x6b [bridge]
>  [<c02d4564>] nf_hook_slow+0x59/0x10e
>  [<f8bdbdb7>] br_forward_finish+0x0/0x6b [bridge]
>  [<f8bdbefa>] __br_forward+0x63/0x7c [bridge]
>  [<f8bdbdb7>] br_forward_finish+0x0/0x6b [bridge]
>  [<f8bdc11b>] br_flood_forward+0x27/0x2c [bridge]
>  [<f8bdbe97>] __br_forward+0x0/0x7c [bridge]
>  [<f8bdcb1b>] br_handle_frame_finish+0x11b/0x137 [bridge]
>  [<f8be094c>] br_nf_pre_routing_finish+0x1a6/0x36b [bridge]
>  [<f8bdca00>] br_handle_frame_finish+0x0/0x137 [bridge]
>  [<f8be07a6>] br_nf_pre_routing_finish+0x0/0x36b [bridge]
>  [<f8be07a6>] br_nf_pre_routing_finish+0x0/0x36b [bridge]
>  [<c02d4564>] nf_hook_slow+0x59/0x10e
>  [<f8be07a6>] br_nf_pre_routing_finish+0x0/0x36b [bridge]
>  [<f8bdca00>] br_handle_frame_finish+0x0/0x137 [bridge]
>  [<f8be11a6>] br_nf_pre_routing+0x332/0x457 [bridge]
>  [<f8be07a6>] br_nf_pre_routing_finish+0x0/0x36b [bridge]
>  [<c02d44e7>] nf_iterate+0x66/0x8a
>  [<f8bdca00>] br_handle_frame_finish+0x0/0x137 [bridge]
>  [<f8bdca00>] br_handle_frame_finish+0x0/0x137 [bridge]
>  [<c02d4564>] nf_hook_slow+0x59/0x10e
>  [<f8bdca00>] br_handle_frame_finish+0x0/0x137 [bridge]
>  [<f8bdccec>] br_handle_frame+0x1b5/0x229 [bridge]
>  [<f8bdca00>] br_handle_frame_finish+0x0/0x137 [bridge]
>  [<c027e6e9>] netif_receive_skb+0x1af/0x334
>  [<f8a74bf5>] e100_poll+0x1cf/0x70c [e100]
>  [<c027ea36>] net_rx_action+0xc1/0x197
>  [<c01206a2>] __do_softirq+0x72/0xdd
>  [<c0120740>] do_softirq+0x33/0x35
>  [<c0104e7e>] do_IRQ+0x1e/0x24
>  [<c0103772>] common_interrupt+0x1a/0x20
> Code: c1 e2 06 8d 82 90 71 3e c0 3b 82 90 71 3e c0 74 58 c7 44 24 18 00
> 00 00 80 c7 44 24 14 34 13 be f8 8b 44 24 3c 8b 80 ec 02 00 00 <8b> 00
> 8b 40 0c 89 44 24 10 8b 44 24 38 8b 80 ec 02 00 00 8b 00
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log
> files for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://ads.osdn.com/?ad_idv37&alloc_id865&op=Click
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com
