Return-Path: <linux-kernel-owner+w=401wt.eu-S932636AbXAJBsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932636AbXAJBsI (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 20:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932637AbXAJBsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 20:48:08 -0500
Received: from mga03.intel.com ([143.182.124.21]:44609 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932636AbXAJBsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 20:48:07 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.13,165,1167638400"; 
   d="scan'208"; a="167157752:sNHT25026183"
Message-ID: <45A445D4.8090206@intel.com>
Date: Tue, 09 Jan 2007 17:48:04 -0800
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.9 (X11/20061228)
MIME-Version: 1.0
To: 7atbggg02@sneakemail.com
CC: linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeb Cramer <cramerj@intel.com>, John Ronciak <john.ronciak@intel.com>,
       Jesse Brandeburg <jesse.brandeburg@intel.com>,
       Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Subject: Re: e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
References: <20070109222708.GA15510@m.safari.iki.fi> <45A42C62.2030309@intel.com> <20070110011019.GD3803@m.safari.iki.fi>
In-Reply-To: <20070110011019.GD3803@m.safari.iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sami Farin wrote:
> On Tue, Jan 09, 2007 at 15:59:30 -0800, Auke Kok wrote:
>> Sami Farin wrote:
> ...
>>> I do "ethtool -K eth0 tso off" now and check if I get the hang again. =)
>> I'm unsure whether v7.2.x already automatically disables TSO for 100mbit 
>> speed link, probably not. It should.
> 
> It disabled it but I enabled it just for fun.
>  
>> Please try our updated driver from http://e1000.sf.net/ (7.3.20) against 
>> the same kernel. There are some changes with regard to the ich8/TSO driver 
>> that might affect this, so re-testing is worth it for us.
> 
> I now run 7.3.20-NAPI.
> 
> BTW. the Makefile is buggy: it does not get CC from kernel's Makefile.
> Using wrong compiler can cause for example a reboot when loading the module.
> (At least that's what happened with gcc-2.95.3 vs 3.x.x some years ago...)

I'll look into that, do you have any suggestions?

>> also, please always include the full dmesg output. Feel free to CC 
>> e1000-devel@lists.sourceforge.net on this.
> 
> I enabled TSO again.  I write again if TSO causes problems.

There are known problems with that configuration, that's why the newer drivers disable 
TSO for 10/100 speeds.

do you really think that you can see the performance gain fro musing TSO at those speeds 
anyway? we don't ;). In any case you should keep TSO off for 10/100 speeds.

> Why shouldn't it work with 100 Mbps?  Not that it would help a lot,
> but I ask this on principle.
> 
>   /* disable TSO for pcie and 10/100 speeds, to avoid
>    * some hardware issues */
> 
> Issues on the motherboard or the NIC?

we (the e1000 team) don't write drivers for the motherboard, but only for the NIC 
component, so I hope that answers your question.

> 2007-01-10 02:39:51.889908500 <6>ACPI: PCI interrupt for device 0000:00:19.0 disabled
> 2007-01-10 02:39:54.545194500 <6>Intel(R) PRO/1000 Network Driver - version 7.3.20-NAPI
> 2007-01-10 02:39:54.545198500 <6>Copyright (c) 1999-2006 Intel Corporation.
> 2007-01-10 02:39:54.545395500 <6>ACPI: PCI Interrupt 0000:00:19.0[A] -> GSI 20 (level, low) -> IRQ 22
> 2007-01-10 02:39:54.545435500 <7>PCI: Setting latency timer of device 0000:00:19.0 to 64
> 2007-01-10 02:39:54.562905500 <6>e1000: 0000:00:19.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1) 00:19:d1:00:5f:01
> 2007-01-10 02:39:54.638093500 <6>e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
> 2007-01-10 02:40:07.513619500 <6>ADDRCONF(NETDEV_UP): eth0: link is not ready
> 2007-01-10 02:40:07.614768500 <6>e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex, Flow Control: None
> 2007-01-10 02:40:07.614770500 <6>e1000: eth0: e1000_watchdog: 10/100 speed: disabling TSO
> 2007-01-10 02:40:07.614771500 <6>ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> 2007-01-10 02:40:09.271631500 <3>e1000: eth0: e1000_reset: Hardware Error
> 2007-01-10 02:40:10.930000500 <6>e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex, Flow Control: None
> 2007-01-10 02:40:10.930049500 <6>e1000: eth0: e1000_watchdog: 10/100 speed: disabling TSO
> 
> PS. please do not delete Mail-Followup-To header field.

I hit "reply-all" and I have no control over which field thunderbird removes or adds. I 
have to manually add your e-mail address too? Maybe your mail client is broken instead? 
Don't you want to receive replies?

Cheers,

Auke
