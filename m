Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbWELVlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWELVlY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 17:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbWELVlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 17:41:24 -0400
Received: from mail17.bluewin.ch ([195.186.18.64]:22772 "EHLO
	mail17.bluewin.ch") by vger.kernel.org with ESMTP id S1750853AbWELVlX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 17:41:23 -0400
Date: Fri, 12 May 2006 23:41:09 +0200
From: Roger Luethi <rl@hellgate.ch>
To: David Lang <david@lang.hm>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: network freeze with nforce-A939 integrated rhine card
Message-ID: <20060512214109.GD2274@k3.hellgate.ch>
References: <Pine.LNX.4.62.0605112235170.2802@qnivq.ynat.uz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0605112235170.2802@qnivq.ynat.uz>
X-Operating-System: Linux 2.6.17-rc2 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2006 22:59:44 -0700, David Lang wrote:
> I haven't had time to go back and find where is started (my prior kernel 
> was 2.6.15-rc7), but with 2.6.17-rc1/2/3/4 I've been running into a 
> problem where when transfering large amounts of data (trying to ftp a TB 

"where is started" sounds as if it used to work at some point. In your
second posting, however, you note that the problem goes back at least to
2.6.13. So are there any kernels known not to exhibit the problem you
described?

> when I say shut down I mean that it looses link and requires powering down 
> the box (hard power down, not just power off from the front panel), 
> disabling the network card in the BIOS, booting (as far as lilo is 
> enough), powering down again, enabling the card and booting again.

So there are two problem areas: 1) the chip hangs itself without the driver
noticing and 2) the BIOS fails to bring the chip back to life afterwards.

> there is no indication of trouble before the halt (it's transfering at 
> full speed), the only think in the log is
> May 11 22:23:57 david kernel: eth0: link down
> May 11 22:24:00 david kernel: eth0: link up, 100Mbps, full-duplex, lpa 
> 0xCDE1
> May 11 22:24:22 david kernel: eth0: link down
> 
> if I don't do the disable/enable in the bios cycle and just power cycle 
> the system the card does not initialize properly (ethtool reports 
> autonegotiation disabled, 10Mb. will generate an 'unsupported' error if I 
> try to enable the card)

Any difference in the kernel log when booting with (or ethtooling) a
comatose chip?

> dlang@david:~$ /sbin/lspci
> 00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0204
> 00:00.1 Host bridge: VIA Technologies, Inc.: Unknown device 1204
> 00:00.2 Host bridge: VIA Technologies, Inc.: Unknown device 2204
> 00:00.3 Host bridge: VIA Technologies, Inc.: Unknown device 3204
> 00:00.4 Host bridge: VIA Technologies, Inc.: Unknown device 4204
> 00:00.7 Host bridge: VIA Technologies, Inc.: Unknown device 7204
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge [K8T800 South]
> 00:08.0 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
> 00:08.1 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
> 00:0a.0 Ethernet controller: Olicom OC-2326 (rev 01)
> 00:0f.0 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C/VT8235 PIPC Bus Master IDE (rev 06)
> 00:10.0 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 81)
> 00:10.1 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 81)
> 00:10.2 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 81)
> 00:10.3 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 81)
> 00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
> 00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [K8T800 South]
> 00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
> 00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 78)
> 00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
> 00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
> 00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
> 00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
> 01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (rev 01)

Odd. This doesn't look at all like the list I'd expect from an nforce-A939.
I thought Nvidia devices featured rather prominently in the device lists of
nforce-based boards!?

Roger
