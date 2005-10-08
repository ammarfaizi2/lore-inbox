Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161039AbVJHBid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161039AbVJHBid (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 21:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932614AbVJHBid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 21:38:33 -0400
Received: from fmr21.intel.com ([143.183.121.13]:51434 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S932108AbVJHBic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 21:38:32 -0400
Message-Id: <200510080138.j981cOg04614@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Jon Burgess'" <jburgess@uklinux.net>
Cc: "Andi Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>,
       <linux-netdev@vger.kernel.org>
Subject: RE: kernel performance update - 2.6.14-rc3
Date: Fri, 7 Oct 2005 18:38:24 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcXLojmAMZ9UetKWSp2NZplmfEEEXQABXMBw
In-Reply-To: <434717B7.30505@uklinux.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Burgess wrote on Friday, October 07, 2005 5:50 PM
> "Chen, Kenneth W" <kenneth.w.chen@intel.com> writes:
> > Even though
> > softirq is invoked at the end of dev_queue_xmit() via local_bh_enable(),
> > not all execution of softirq will result a __wake_up().  With higher
> > HZ rate, timer interrupt is more frequent and thus more softirq
> > invocation and leads to more __wake_up(), which then takes us to higher
> > throughput because cpu spend less time in idle.
> 
> Since the loopback xmit->rx path probably isn't being called in 
> interrupt context might something like the patch below be needed?
> 
> Please forgive me if this is wrong, i've not even tried compiling
> this change let alone tested it.

I don't think this patch has any effect.  dev_queue_xmit turns off
local_bh when calling loopback_xmit, so calls to do_softirq from
netif_rx_ni Will be a noop since do_softirq immediately return upon
seeing in_interrupt().

- Ken

