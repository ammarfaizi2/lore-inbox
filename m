Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269704AbUJMOA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269704AbUJMOA4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 10:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269706AbUJMOA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 10:00:56 -0400
Received: from mail4.utc.com ([192.249.46.193]:50593 "EHLO mail4.utc.com")
	by vger.kernel.org with ESMTP id S269704AbUJMOAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 10:00:51 -0400
Message-ID: <416D34EC.7080400@cybsft.com>
Date: Wed, 13 Oct 2004 09:00:12 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Wen-chien Jesse Sung <jesse@cola.voip.idv.tw>,
       Mark_H_Johnson@Raytheon.com
Subject: Re: [patch] VP-2.6.9-rc4-mm1-T8
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <416C452E.4080006@cybsft.com> <20041013054532.GB31811@elte.hu>
In-Reply-To: <20041013054532.GB31811@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * K.R. Foley <kr@cybsft.com> wrote:
> 
> 
>>Booted part way this time but then soft locked. [...]
> 
> 
> the soft lock it seems was due to a mutex assert in the TCP code. Now i
> see that you have the ipv6 module loaded. Would it be possible to
> disable ipv6 briefly, to see whether there are other issues?

Yes. I don't need and will disable when building T9.

> 
> 
>>Mouse was still working but not KB. Any idea why the KB is not working
>>with these? I am rebuilding with all of the pwr managment off because
>>I am still getting acpi messages in the boot :-/ [...]
> 
> 
> hm, the keyboard should be working - i have not seen any specific
> keyboard problems with PREEMPT_REALTIME enabled (except in the very
> early stages of this feature). So it must be something else. Is this a
> PS2 or an USB keyboard?

PS2 keyboard. For clarification, I have intermittent problems with the 
keyboard on this machine with anything to do with preempt. Sometimes it 
works on boot sometimes it does not. Actually since it is so 
unpredictable, I can't even say for sure that it has to do with preempt, 
but it hasn't failed yet on rc4-mm1. I have tried to find a pattern and 
have yet to do so. Possibly pertinent info:

Iwill MB dual 2.6G Xeon 512 ram

00:00.0 Host bridge: Intel Corp. E7505 Memory Controller Hub (rev 03)
00:00.1 Class ff00: Intel Corp. E7000 Series RAS Controller (rev 03)
00:01.0 PCI bridge: Intel Corp. E7000 Series Processor to AGP Controller 
(rev 03)
00:02.0 PCI bridge: Intel Corp. E7000 Series Hub Interface B PCI-to-PCI 
Bridge (rev 03)
00:1d.0 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #1 (rev 02)
00:1d.1 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #2 (rev 02)
00:1d.2 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #3 (rev 02)
00:1d.7 USB Controller: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller 
(rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface to PCI 
Bridge (rev 82)
00:1f.0 ISA bridge: Intel Corp. 82801DB (ICH4) LPC Bridge (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801DB (ICH4) Ultra ATA 100 Storage 
Controller (rev 02)
00:1f.3 SMBus: Intel Corp. 82801DB/DBM (ICH4) SMBus Controller (rev 02)
01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 MX 
440] (rev a3)
02:1c.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 03)
02:1d.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 03)
02:1e.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 03)
02:1f.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 03)
04:04.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5702X 
Gigabit Ethernet (rev 02)
05:01.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] 
(rev 78)


> 
> 
>>Oct 12 15:33:39 swdev14 kernel: NET: Registered protocol family 10
>>Oct 12 15:33:39 swdev14 kernel: IPv6 over IPv4 tunneling driver
>>Oct 12 15:33:40 swdev14 kernel: ------------[ cut here ]------------
>>Oct 12 15:33:40 swdev14 kernel: kernel BUG at kernel/mutex.c:185!
> 
> 
>>Oct 12 15:33:40 swdev14 kernel: EIP is at _rw_mutex_write_unlock+0x25/0x2f
> 
> 
>>Oct 12 15:33:40 swdev14 kernel: Call Trace:
>>Oct 12 15:33:40 swdev14 kernel:  [<c0253738>] tcp_listen_start+0x175/0x1d1
>>Oct 12 15:33:40 swdev14 kernel:  [<c029a33a>] _spin_unlock_bh+0x1a/0x34
>>Oct 12 15:33:40 swdev14 kernel:  [<c0275a8c>] inet_listen+0x65/0x7a
>>Oct 12 15:33:40 swdev14 kernel:  [<c02287ea>] sys_listen+0x5c/0x74
>>Oct 12 15:33:40 swdev14 kernel:  [<c02294a4>] sys_socketcall+0xb1/0x239
>>Oct 12 15:33:40 swdev14 kernel:  [<c015ae81>] sys_close+0x75/0x91
> 
> 
> this assert says that a write_unlock() was done before the mutex was
> initialized - which is a no-no. Note that the stock kernel does not do
> this checking and there's a chance that it has a true bug here which it
> ignores silently. The more likely scenario is that the kernel mutex code
> somewhere changed an assumption which broke the code. I'll try to
> reproduce this.
> 
> 	Ingo
> 

