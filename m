Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752190AbWJ0Nt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752190AbWJ0Nt4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 09:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752191AbWJ0Nt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 09:49:56 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:23030 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1752190AbWJ0Ntz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 09:49:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n4y2XyrCiitOYc7JPDm+wyEGXDoxoP9QNV0E/jBBnDFaqTJuxudXfbdpRNZpnW4Hm7OB11gi5QZubvKlE7M1z85NdYYCbLeAj8By0vda4KQP7s+u4Y1eH/QYcrT7HCqf6q/63Sssj8Pvc1E0PV2AdGJMR/i1XwE+N5C5vPdjx4E=
Message-ID: <b6a2187b0610270649t4cc71781y8e1695f02e1c608e@mail.gmail.com>
Date: Fri, 27 Oct 2006 21:49:54 +0800
From: "Jeff Chua" <jeff.chua.linux@gmail.com>
To: "Adrian Bunk" <bunk@stusta.de>
Subject: Re: linux-2.6.19-rc2 tg3 problem
Cc: linux-kernel@vger.kernel.org, "David Miller" <davem@davemloft.net>
In-Reply-To: <20061026152455.GI27968@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b6a2187b0610230824m38ce6fb2j65cd26099e982449@mail.gmail.com>
	 <20061025013022.GG27968@stusta.de>
	 <b6a2187b0610251754x7dc2c51aoad2244b8cdcb1c09@mail.gmail.com>
	 <20061026152455.GI27968@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/06, Adrian Bunk <bunk@stusta.de> wrote:

> That wasn't clear from your bug report.

Sorry. Didn't want to bombard with too much unnecessary info.


> You said 2.6.18-rc2 -> 2.6.19-rc2 broke.
> Can you identify between which -rc kernels it broke?

Ok, I managed to trace down to ..

      2.6.18 ok
      2.6.19-rc1 bad


> Please send complete "dmesg -s 1000000" for the time after tg3 loads for
> both the last working and the first non-working -rc kernel.


2.6.18 (good) ...

tg3.c:v3.65 (August 07, 2006)
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:02:00.0 to 64
eth0: Tigon3 [partno(BCM5751PKFBG) rev 4001 PHY(5750)] (PCI Express)
10/100/1000BaseT Ethernet 00:13:72:7b:2a:f0
eth0: RXcsums[1] LinkChgREG[1] MIirq[1] ASF[0] Split[0] WireSpeed[1] TSOcap[1]
eth0: dma_rwctrl[76180000] dma_mask[64-bit]
ip_tables: (C) 2000-2006 Netfilter Core Team
ip_conntrack version 2.4 (8192 buckets, 65536 max) - 224 bytes per conntrack
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.



2.6.19 (bad) ...

tg3.c:v3.66 (September 23, 2006)
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
tg3: Cannot find proper PCI device base address, aborting.
ACPI: PCI interrupt for device 0000:02:00.0 disabled
ip_tables: (C) 2000-2006 Netfilter Core Team
ip_conntrack version 2.4 (8192 buckets, 65536 max) - 228 bytes per conntrack




gcc version 3.4.5
Dell Optiplex DualCore GX620.
Intel(R) Pentium(R) D CPU 3.00GHz stepping 07


Diff of the two config ...

  .config (2.6.18) ...
< CONFIG_TCP_CONG_BIC=y

 .config (2.6.19-rc1) ...
> CONFIG_HT_IRQ=y
> CONFIG_INET_XFRM_MODE_BEET=y
> CONFIG_TCP_CONG_CUBIC=y
> CONFIG_DEFAULT_TCP_CONG="cubic"


Thanks,
Jeff.
