Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbWIBFqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWIBFqi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 01:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWIBFqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 01:46:37 -0400
Received: from mga09.intel.com ([134.134.136.24]:40309 "EHLO
	orsmga102-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750779AbWIBFqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 01:46:37 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,202,1154934000"; 
   d="scan'208"; a="119715754:sNHT18385080"
Message-ID: <44F91A67.6020505@intel.com>
Date: Fri, 01 Sep 2006 22:45:11 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Paul Aviles <paul.aviles@palei.com>
CC: linux-kernel@vger.kernel.org, NetDev <netdev@vger.kernel.org>
Subject: Re: e1000 Detected Tx Unit Hang
References: <000f01c6ce49$affd37e0$3224050a@avilespaxp>
In-Reply-To: <000f01c6ce49$affd37e0$3224050a@avilespaxp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Aviles wrote:
> I am getting "e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang" 
> using stock 2.6.17.11, 2.6.17.5 or 2.6.17.4 kernels on centos 4.3.
> 
> The server is a Tyan GS10 and is connected to a Netgear GS724T Gig 
> switch. I can easily reproduce the problem by trying to do a large ftp 
> transfer to the server. It does not happen if the server is connected to 
> a dummy 100 Mb switch, only when is connected to the Gig switch.
> I have also tried the options line below disabling tso, tx and rx in the 
> modprobe.conf without any luck.
> 
> options e1000 XsumRX=0 Speed=1000 Duplex=2 InterruptThrottleRate=0 
> FlowControl=3 RxDescriptors=4096 TxDescriptors=4096 RxIntDelay=0 
> TxIntDelay=0
> 
> in /var/log/kernel I get the following...
> 
> Sep  1 23:53:01 www kernel: e1000: eth0: e1000_clean_tx_irq: Detected Tx 
> Unit Hang
> Sep  1 23:53:01 www kernel:   Tx Queue             <0>
> Sep  1 23:53:01 www kernel:   TDH                  <4c4>
> Sep  1 23:53:01 www kernel:   TDT                  <4c9>
> Sep  1 23:53:01 www kernel:   next_to_use          <4c9>
> Sep  1 23:53:01 www kernel:   next_to_clean        <4c4>
> Sep  1 23:53:01 www kernel: buffer_info[next_to_clean]
> Sep  1 23:53:01 www kernel:   time_stamp           <ffff9c60>
> Sep  1 23:53:01 www kernel:   next_to_watch        <4c4>
> Sep  1 23:53:01 www kernel:   jiffies              <ffff9d96>
> Sep  1 23:53:01 www kernel:   next_to_watch.status <0>
> .
> repeats the same as above a few times....
> .
> Sep  1 23:53:10 www kernel: NETDEV WATCHDOG: eth0: transmit timed out
> Sep  1 23:53:13 www kernel: e1000: eth0: e1000_watchdog_task: NIC Link 
> is Up 1000 Mbps Full Duplex
> 
> then the server locks up, no response from the keyboard at all and must 
> be forced down with a power kill.
> 
> Here is my driver info,
> 
> driver: e1000
> version: 7.0.33-k2-NAPI
> firmware-version: N/A
> bus-info: 0000:02:01.0
> 
> What else could I check?

[adding netdev to cc, this is a NET issue]

This is a known issue and there are several discussions and bugs filed on this. 
  Please read this one where most is documented, and also the netdev

http://sourceforge.net/tracker/index.php?func=detail&aid=1463045&group_id=42302&atid=447449

more links and information available on http://e1000.sf.net/

Your debugging information might be needed and helpful, so please take the 
trouble of digging in the previous bugreports and reporting anything that might 
be relevant there.

The full lockup is certainly not good, but should not necessarily be related to 
the tx hang (or the cause of that). It is likely that interrupt sharing might 
be a problem here; what kind of e1000 nic is this? lspci -vv?

Cheers,

Auke

-- 
VGER BF report: H 0.00334085
