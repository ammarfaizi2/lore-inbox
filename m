Return-Path: <linux-kernel-owner+w=401wt.eu-S932613AbXAJCUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932613AbXAJCUQ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 21:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932650AbXAJCUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 21:20:16 -0500
Received: from pne-smtpout4-sn1.fre.skanova.net ([81.228.11.168]:53287 "EHLO
	pne-smtpout4-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932613AbXAJCUO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 21:20:14 -0500
X-Greylist: delayed 4179 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Jan 2007 21:20:14 EST
Date: Wed, 10 Jan 2007 03:10:19 +0200
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Jeb Cramer <cramerj@intel.com>, John Ronciak <john.ronciak@intel.com>,
       Jesse Brandeburg <jesse.brandeburg@intel.com>,
       Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
       Auke Kok <auke-jan.h.kok@intel.com>
Subject: Re: e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
Message-ID: <20070110011019.GD3803@m.safari.iki.fi>
Mail-Followup-To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jeb Cramer <cramerj@intel.com>,
	John Ronciak <john.ronciak@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	Auke Kok <auke-jan.h.kok@intel.com>
References: <20070109222708.GA15510@m.safari.iki.fi> <45A42C62.2030309@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45A42C62.2030309@intel.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2007 at 15:59:30 -0800, Auke Kok wrote:
> Sami Farin wrote:
...
> >I do "ethtool -K eth0 tso off" now and check if I get the hang again. =)
> 
> I'm unsure whether v7.2.x already automatically disables TSO for 100mbit 
> speed link, probably not. It should.

It disabled it but I enabled it just for fun.
 
> Please try our updated driver from http://e1000.sf.net/ (7.3.20) against 
> the same kernel. There are some changes with regard to the ich8/TSO driver 
> that might affect this, so re-testing is worth it for us.

I now run 7.3.20-NAPI.

BTW. the Makefile is buggy: it does not get CC from kernel's Makefile.
Using wrong compiler can cause for example a reboot when loading the module.
(At least that's what happened with gcc-2.95.3 vs 3.x.x some years ago...)
 
> also, please always include the full dmesg output. Feel free to CC 
> e1000-devel@lists.sourceforge.net on this.

I enabled TSO again.  I write again if TSO causes problems.
Why shouldn't it work with 100 Mbps?  Not that it would help a lot,
but I ask this on principle.

  /* disable TSO for pcie and 10/100 speeds, to avoid
   * some hardware issues */

Issues on the motherboard or the NIC?

2007-01-10 02:39:51.889908500 <6>ACPI: PCI interrupt for device 0000:00:19.0 disabled
2007-01-10 02:39:54.545194500 <6>Intel(R) PRO/1000 Network Driver - version 7.3.20-NAPI
2007-01-10 02:39:54.545198500 <6>Copyright (c) 1999-2006 Intel Corporation.
2007-01-10 02:39:54.545395500 <6>ACPI: PCI Interrupt 0000:00:19.0[A] -> GSI 20 (level, low) -> IRQ 22
2007-01-10 02:39:54.545435500 <7>PCI: Setting latency timer of device 0000:00:19.0 to 64
2007-01-10 02:39:54.562905500 <6>e1000: 0000:00:19.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1) 00:19:d1:00:5f:01
2007-01-10 02:39:54.638093500 <6>e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
2007-01-10 02:40:07.513619500 <6>ADDRCONF(NETDEV_UP): eth0: link is not ready
2007-01-10 02:40:07.614768500 <6>e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex, Flow Control: None
2007-01-10 02:40:07.614770500 <6>e1000: eth0: e1000_watchdog: 10/100 speed: disabling TSO
2007-01-10 02:40:07.614771500 <6>ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
2007-01-10 02:40:09.271631500 <3>e1000: eth0: e1000_reset: Hardware Error
2007-01-10 02:40:10.930000500 <6>e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex, Flow Control: None
2007-01-10 02:40:10.930049500 <6>e1000: eth0: e1000_watchdog: 10/100 speed: disabling TSO

PS. please do not delete Mail-Followup-To header field.

-- 
