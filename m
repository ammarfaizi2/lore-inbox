Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269935AbUJVONo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269935AbUJVONo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 10:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269969AbUJVONn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 10:13:43 -0400
Received: from mail3.utc.com ([192.249.46.192]:38576 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S269935AbUJVONJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 10:13:09 -0400
Message-ID: <41791564.20200@cybsft.com>
Date: Fri, 22 Oct 2004 09:12:52 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U9
References: <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>	 <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu>	 <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu>	 <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu>	 <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu>	 <20041021132717.GA29153@elte.hu>  <4177FADC.6030905@cybsft.com>	 <1098384016.27089.42.camel@thomas>  <41780687.8030408@cybsft.com> <1098385049.27089.51.camel@thomas>
In-Reply-To: <1098385049.27089.51.camel@thomas>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
> On Thu, 2004-10-21 at 20:57, K.R. Foley wrote:
> 
>>>I guess, you don't have a tulip network card in your box, as the module
>>>is removed.
>>>
>>>The question is, if it got registered correctly before the removal.
>>
>>Actually I do have the tulip card in the box and I am pulling this stuff 
>>from the logs over that connection now. Here are the next lines from the 
>>log that might help.
> 
> 

More info on this:

As mentioned before, I get this on boot (every boot):

Oct 21 12:33:22 porky kernel: Linux Tulip driver version 1.1.13 (May 11, 
2002)
Oct 21 12:33:22 porky kernel: PCI: Found IRQ 5 for device 0000:04:0a.0
Oct 21 12:33:22 porky kernel: PCI: Sharing IRQ 5 with 0000:04:05.1
Oct 21 12:33:22 porky kernel: tulip0:  EEPROM default media type Autosense.
Oct 21 12:33:22 porky kernel: tulip0:  Index #0 - Media MII (#11) 
described by a 21140 MII PHY (1) block.
Oct 21 12:33:22 porky kernel: tulip0:  MII transceiver #3 config 3100 
status 7809 advertising 01e1.
Oct 21 12:33:22 porky kernel: eth0: Digital DS21140 Tulip rev 32 at 
0xe480, 00:00:C0:7F:A0:E9, IRQ 5.
Oct 21 12:33:22 porky kernel: BUG: atomic counter underflow at:
Oct 21 12:33:22 porky kernel:  [<c0254dd8>] qdisc_destroy+0x98/0xa0 (12)
Oct 21 12:33:22 porky kernel:  [<c0254fed>] dev_shutdown+0x3d/0xa0 (16)
Oct 21 12:33:22 porky kernel:  [<c024773b>] 
unregister_netdevice+0x13b/0x280 (28)
Oct 21 12:33:22 porky netfs: Mounting other filesystems:  succeeded
Oct 21 12:33:22 porky kernel:  [<c0112fb0>] mcount+0x14/0x18 (12)
Oct 21 12:33:22 porky kernel:  [<e09a6160>] tulip_remove_one+0x0/0xa0 
[tulip] (4)
Oct 21 12:33:22 porky kernel:  [<c02058de>] unregister_netdev+0x1e/0x30 (24)
Oct 21 12:33:22 porky kernel:  [<e09a618f>] tulip_remove_one+0x2f/0xa0 
[tulip] (16)
Oct 21 12:33:22 porky kernel:  [<c01f2907>] 
device_release_driver+0x67/0x70 (8)
Oct 21 12:33:22 porky kernel:  [<c0112fb0>] mcount+0x14/0x18 (8)
Oct 21 12:33:22 porky kernel:  [<c01c4e26>] pci_device_remove+0x76/0x80 (20)
Oct 21 12:33:22 porky kernel:  [<c01f573b>] 
device_detach_shutdown+0xb/0x40 (12)
Oct 21 12:33:22 porky kernel:  [<c01f2907>] 
device_release_driver+0x67/0x70 (12)
Oct 21 12:33:22 porky kernel:  [<c01f293b>] driver_detach+0x2b/0x40 (24)
Oct 21 12:33:22 porky kernel:  [<c01f2daf>] bus_remove_driver+0x3f/0x70 (20)
Oct 21 12:33:22 porky kernel:  [<c01f32b9>] driver_unregister+0x19/0x30 (20)
Oct 21 12:33:22 porky kernel:  [<c01c50cc>] 
pci_unregister_driver+0x1c/0x30 (16)
Oct 21 12:33:22 porky kernel:  [<e09a7767>] tulip_cleanup+0x17/0x1b 
[tulip] (16)
Oct 21 12:33:22 porky kernel:  [<c0139801>] 
sys_delete_module+0x121/0x150 (12)
Oct 21 12:33:22 porky kernel:  [<c01531a1>] sys_munmap+0x51/0x60 (64)
Oct 21 12:33:22 porky kernel:  [<c0116a20>] do_page_fault+0x0/0x660 (16)
Oct 21 12:33:22 porky kernel:  [<c0106719>] sysenter_past_esp+0x52/0x71 (16)
Oct 21 12:33:22 porky kernel: preempt count: 00000001
Oct 21 12:33:22 porky kernel: . 1-level deep critical section nesting:
Oct 21 12:33:22 porky kernel: .. entry 1: print_traces+0x1d/0x60 / 
(dump_stack+0x23/0x30)
Oct 21 12:33:22 porky kernel:
Oct 21 12:33:22 porky kernel: tulip 0000:04:0a.0: Device was removed 
without properly calling pci_disable_device(). This may need fixing.

I am not sure why the tulip driver is being loaded,unloaded,reloaded 
every time on boot? Anyway, I wanted to check to see if I could generate 
the above bug on subsequent unloads of the module. I downed the network 
and the unloaded the tulip module. I did get the message below when 
unloading the module but no "BUG: atomic counter underflow" message.

Oct 22 05:43:33 porky kernel: tulip 0000:04:0a.0: Device was removed 
without properly calling pci_disable_device(). This may need fixing.
Oct 22 05:43:33 porky net.agent[921]: remove event not handled

kr
