Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261656AbVAXU4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbVAXU4a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 15:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbVAXUy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 15:54:59 -0500
Received: from [63.81.117.10] ([63.81.117.10]:30703 "EHLO mail00hq.adic.com")
	by vger.kernel.org with ESMTP id S261651AbVAXUri (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 15:47:38 -0500
Message-ID: <41F55EE1.5090702@xfs.org>
Date: Mon, 24 Jan 2005 14:47:29 -0600
From: Steve Lord <lord@xfs.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <jejb@steeleye.com>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, Mel Gorman <mel@csn.ul.ie>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Grant Grundler <grundler@parisc-linux.org>
Subject: Re: [PATCH] Avoiding fragmentation through different allocator
References: <20050120101300.26FA5E598@skynet.csn.ul.ie>	 <20050121142854.GH19973@logos.cnet>	 <Pine.LNX.4.58.0501222128380.18282@skynet>	 <20050122215949.GD26391@logos.cnet>	 <Pine.LNX.4.58.0501241141450.5286@skynet>	 <20050124122952.GA5739@logos.cnet> <1106585052.5513.26.camel@mulgrave>
In-Reply-To: <1106585052.5513.26.camel@mulgrave>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Jan 2005 20:47:32.0367 (UTC) FILETIME=[ED1F89F0:01C50255]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:

> 
> Well, the basic advice would be not to worry too much about
> fragmentation from the point of view of I/O devices.  They mostly all do
> scatter gather (SG) onboard as an intelligent processing operation and
> they're very good at it.
> 
> No one has ever really measured an effect we can say "This is due to the
> card's SG engine".  So, the rule we tend to follow is that if SG element
> reduction comes for free, we take it.  The issue that actually causes
> problems isn't the reduction in processing overhead, it's that the
> device's SG list is usually finite in size and so it's worth conserving
> if we can; however it's mostly not worth conserving at the expense of
> processor cycles.
> 

Depends on the device at the other end of the scsi/fiber channel.
We have seen the processor in raid devices get maxed out by linux
when it is not maxed out by windows. Windows tends to be more device
friendly (I hate to say it), by sending larger and fewer scatter gather
elements than linux does.

Running an LSI raid over fiberchannel with 4 ports, windows was
able to sustain ~830 Mbytes/sec, basically channel speed using
only 1500 commands a second. Linux peaked at 550 Mbytes/sec using
over 4000 scsi commands to do it - the sustained rate was more
like 350 Mbytes/sec, I think at the end of the day linux was
sending 128K per scsi request. These numbers predate the current
linux scsi and io code, and I do not have the hardware to rerun
them right now.

I realize this is one data point on one end of the scale, but I
just wanted to make the point that there are cases where it
does matter. Hopefully William's little change from last
year has helped out a lot.

Steve
