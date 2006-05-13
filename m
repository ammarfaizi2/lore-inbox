Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbWEMFVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbWEMFVO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 01:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbWEMFVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 01:21:14 -0400
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:65449
	"EHLO bifrost.lang.hm") by vger.kernel.org with ESMTP
	id S932340AbWEMFVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 01:21:13 -0400
Date: Fri, 12 May 2006 22:21:07 -0700 (PDT)
From: David Lang <david@lang.hm>
X-X-Sender: dlang@david.lang.hm
To: Roger Luethi <rl@hellgate.ch>
cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: network freeze with nforce-A939 integrated rhine card
In-Reply-To: <20060512214109.GD2274@k3.hellgate.ch>
Message-ID: <Pine.LNX.4.62.0605122209330.2803@qnivq.ynat.uz>
References: <Pine.LNX.4.62.0605112235170.2802@qnivq.ynat.uz>
 <20060512214109.GD2274@k3.hellgate.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 May 2006, Roger Luethi wrote:

> On Thu, 11 May 2006 22:59:44 -0700, David Lang wrote:
>> I haven't had time to go back and find where is started (my prior kernel
>> was 2.6.15-rc7), but with 2.6.17-rc1/2/3/4 I've been running into a
>> problem where when transfering large amounts of data (trying to ftp a TB
>
> "where is started" sounds as if it used to work at some point. In your
> second posting, however, you note that the problem goes back at least to
> 2.6.13. So are there any kernels known not to exhibit the problem you
> described?

when I posted this origionally I thought it was new in 2.6.17-rc, however 
since my testing with older kernels hasn't found me a working one yet I 
suspect that other factors have been involved with makeing it work.

these failures have been on multi-gig files ftp'd from the raid array on 
my machine to the raid array on the replacement machine. In the past I've 
sucessfully transfered similar sized files to/from my tivo (slow network), 
my laptop (slow drive), and smaller sets of files to single drives on 
other systems (7200rpm drives, but not to arrays).

as I type this I'm starting a test going from a single drive on this 
machine to the raid array on the remote machine to transfer ~84G of data. 
My suspicion is that this is going to work.

>> when I say shut down I mean that it looses link and requires powering down
>> the box (hard power down, not just power off from the front panel),
>> disabling the network card in the BIOS, booting (as far as lilo is
>> enough), powering down again, enabling the card and booting again.
>
> So there are two problem areas: 1) the chip hangs itself without the driver
> noticing and 2) the BIOS fails to bring the chip back to life afterwards.

yes

>> there is no indication of trouble before the halt (it's transfering at
>> full speed), the only think in the log is
>> May 11 22:23:57 david kernel: eth0: link down
>> May 11 22:24:00 david kernel: eth0: link up, 100Mbps, full-duplex, lpa
>> 0xCDE1
>> May 11 22:24:22 david kernel: eth0: link down
>>
>> if I don't do the disable/enable in the bios cycle and just power cycle
>> the system the card does not initialize properly (ethtool reports
>> autonegotiation disabled, 10Mb. will generate an 'unsupported' error if I
>> try to enable the card)
>
> Any difference in the kernel log when booting with (or ethtooling) a
> comatose chip?

I haven't checked the boot logs, I'll do that. ethtool hasn't generated 
any logs that I've seen. after the current transfer finishes I'll trigger 
the bug and test this.

>> dlang@david:~$ /sbin/lspci
>> 00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0204
>> 00:00.1 Host bridge: VIA Technologies, Inc.: Unknown device 1204
>> 00:00.2 Host bridge: VIA Technologies, Inc.: Unknown device 2204
>> 00:00.3 Host bridge: VIA Technologies, Inc.: Unknown device 3204
>> 00:00.4 Host bridge: VIA Technologies, Inc.: Unknown device 4204
>> 00:00.7 Host bridge: VIA Technologies, Inc.: Unknown device 7204
>> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge [K8T800 South]
>> 00:08.0 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
>> 00:08.1 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
>> 00:0a.0 Ethernet controller: Olicom OC-2326 (rev 01)
>> 00:0f.0 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C/VT8235 PIPC Bus Master IDE (rev 06)
>> 00:10.0 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 81)
>> 00:10.1 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 81)
>> 00:10.2 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 81)
>> 00:10.3 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 81)
>> 00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
>> 00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [K8T800 South]
>> 00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
>> 00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 78)
>> 00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
>> 00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
>> 00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
>> 00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
>> 01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (rev 01)
>
> Odd. This doesn't look at all like the list I'd expect from an nforce-A939.
> I thought Nvidia devices featured rather prominently in the device lists of
> nforce-based boards!?

you're right, it's the new server that has the nforce board. I'll have to 
check the motherboard version when I reboot it.

David Lang

