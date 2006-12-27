Return-Path: <linux-kernel-owner+w=401wt.eu-S932886AbWL0CHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932886AbWL0CHG (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 21:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932887AbWL0CHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 21:07:06 -0500
Received: from mga05.intel.com ([192.55.52.89]:9320 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932886AbWL0CHF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 21:07:05 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,211,1165219200"; 
   d="scan'208"; a="181985009:sNHT19549180"
Subject: Re: Oops in 2.6.19.1
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Chuck Ebbert <76306.1226@compuserve.com>
In-Reply-To: <200612231540.47176.s0348365@sms.ed.ac.uk>
References: <200612201421.03514.s0348365@sms.ed.ac.uk>
	 <200612231540.47176.s0348365@sms.ed.ac.uk>
Content-Type: text/plain; charset=utf-8
Date: Wed, 27 Dec 2006 10:07:12 +0800
Message-Id: <1167185232.15989.129.camel@ymzhang>
Mime-Version: 1.0
X-Mailer: Evolution 2.9.2 (2.9.2-2.fc7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-12-23 at 15:40 +0000, Alistair John Strachan wrote:
> On Wednesday 20 December 2006 14:21, Alistair John Strachan wrote:
> > Hi,
> >
> > Any ideas?
> 
> Pretty much like clockwork, it happened again. I think it's time to take this 
> seriously as a software bug, and not some hardware problem. I've ran kernels 
> since 2.6.0 on this machine without such crashes, and now two of the same in 
> 2.6.19.1? Pretty unlikely!
> 
> BUG: unable to handle kernel NULL pointer dereference at virtual address 
> 00000009
>  printing eip:
> c0156f60
> *pde = 00000000
> Oops: 0002 [#1]
> Modules linked in: ipt_recent ipt_REJECT xt_tcpudp ipt_MASQUERADE iptable_nat 
> xt_sta
> te iptable_filter ip_tables x_tables prism54 yenta_socket rsrc_nonstatic 
> pcmcia_core snd_via82xx snd_ac97_codec snd_ac97_bus
> snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd soundcore 
> usblp ehci_hcd eth1394 uhci_hcd usbcore ohci1394 i
> eee1394 via_agp agpgart vt1211 hwmon_vid hwmon ip_nat_ftp ip_nat 
> ip_conntrack_ftp ip_conntrack
> CPU:    0
> EIP:    0060:[<c0156f60>]    Not tainted VLI
> EFLAGS: 00010246   (2.6.19.1 #1)
> EIP is at pipe_poll+0xa0/0xb0
> eax: 00000008   ebx: 00000000   ecx: 00000008   edx: 00000000
> esi: ee1b9e9c   edi: f4d80a00   ebp: ee1b9c1c   esp: ee1b9c0c
> ds: 007b   es: 007b   ss: 0068
> Process java (pid: 5374, ti=ee1b8000 task=f7117560 task.ti=ee1b8000)
> Stack: 00000000 00000000 ee1b9e9c f6c17160 ee1b9fa4 c015d7f3 ee1b9c54 ee1b9fac
>        082dff90 00000010 082dffa0 00000000 ee1b9e94 ee1b9e94 00000002 ee1b9eac
>        00000000 ee1b9e94 c015e580 00000000 00000000 00000002 f6c17160 00000000
> Call Trace:
>  [<c015d7f3>] do_sys_poll+0x253/0x480
>  [<c015da53>] sys_poll+0x33/0x50
>  [<c0102c97>] syscall_call+0x7/0xb
>  [<b7f26402>] 0xb7f26402
>  =======================
> Code: 58 01 00 00 0f 4f c2 09 c1 89 c8 83 c8 08 85 db 0f 44 c8 8b 5d f4 89 c8 
> 8b 75
> f8 8b 7d fc 89 ec 5d c3 89 ca 8b 46 6c 83 ca 10 3b <87> 68 01 00 00 0f 45 ca 
> eb b6 8d b6 00 00 00 00 55 b8 01 00 00
Above codes look weird. Could you disassemble kernel image and post
the part around address 0xc0156f60?

"87 68 01 00 00" is instruction xchg, but if I disassemble from the begining,
I couldn't see instruct xchg.


> EIP: [<c0156f60>] pipe_poll+0xa0/0xb0 SS:ESP 0068:ee1b9c0c
> 
