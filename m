Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318291AbSG3Oal>; Tue, 30 Jul 2002 10:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318294AbSG3Oak>; Tue, 30 Jul 2002 10:30:40 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:7678 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318291AbSG3O3s>; Tue, 30 Jul 2002 10:29:48 -0400
Subject: Re: questions about network device drivers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Abraham vd Merwe <abraham@2d3d.co.za>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <20020730161505.A23281@crystal.2d3d.co.za>
References: <20020730161505.A23281@crystal.2d3d.co.za>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 30 Jul 2002 16:48:46 +0100
Message-Id: <1028044126.6726.35.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-30 at 15:15, Abraham vd Merwe wrote:
> hard_start_xmit() method
> ========================
> 
> when should this function return 0 and when should it return 1 and in which
> cases should it do netif_stop_queue() and/or free the dev_kfree_skb() ?

0 - OK
1 - I am busy, give me it later.

If you return 1 be sure to netif_stop_queue. The netif_wake_queue will
continue transmission


> is there any way to control alignment of sk_buff's that gets passed to this
> function? e.g. if I want the buffer to be aligned on 16-bit boundary and/or
> be padded to a 16-bit boundary - is there any way to tell the kernel to pass
> the driver buffers with those characterestics?

There is not. You can expect just about every packet to be 16bit aligned

> when errors occur that have details error fields in the net_device_stats
> structure, am I supposed to increment both the total error count and the
> detailed error count or both? also, what about dropped packets?

total and specific error.

dropped - not sure. Its not a precise science since cards vary
themselves how their hardware accounts such things

> tx_timeout() method
> =================
> 
> there is no way to return an error in the tx_timeout method. what should I
> do when an error occurs in that function (e.g. I'm unable to reset the
> controller)? panic? that seems a bit excessive...

Try again ? If that fails I guess you initiate the self destruct
sequence for just that driver.

>
