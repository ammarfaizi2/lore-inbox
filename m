Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269221AbUIIAbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269221AbUIIAbx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 20:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269234AbUIIAbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 20:31:53 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:22476 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269221AbUIIAbv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 20:31:51 -0400
Message-ID: <9e473391040908173179bf4647@mail.gmail.com>
Date: Wed, 8 Sep 2004 20:31:50 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: multi-domain PCI and sysfs
Cc: "David S. Miller" <davem@davemloft.net>, jbarnes@engr.sgi.com,
       willy@debian.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1094683264.12335.35.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e4733910409041300139dabe0@mail.gmail.com>
	 <200409072115.09856.jbarnes@engr.sgi.com>
	 <20040907211637.20de06f4.davem@davemloft.net>
	 <200409072125.41153.jbarnes@engr.sgi.com>
	 <9e47339104090723554eb021e4@mail.gmail.com>
	 <20040908112143.330a9301.davem@davemloft.net>
	 <1094683264.12335.35.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Sep 2004 23:41:05 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> The only way I can see VGA routing working is to have some kind of arch
> code that can tell you which devices are on the same VGA legacy tree.
> That then allows a vga layer to walk VGA devices and ask arch code the
> typically simple question

This is the core problem, I'm missing this piece of data. I need it to
know how many VGA devices to create since there needs to be one for
each VGA legacy tree.

All of my previous replies were confused since I was associating VGA
legacy trees and PCI domains, which apparently have nothing to do with
each other. I'm working on hardware that has neither multiple legacy
trees or domains so I have no experience in dealing with them.

I think the problem is more basic than building a VGA device. I
wouldn't be having trouble if there were structures for each "PCI IO
space". An x86 machine would have one of these structs. Other
architectures would have multiple ones. You need these structs to find
any PCI legacy device, the problem is not specific to VGA.

Shouldn't we first create a cross platform structure that represents
the "PCI IO spaces" available in the system? Then I could walk this
list and easily know how many VGA devices to create. Each VGA device
would then use this structure to know the PCI base address for each
"IO space" operation.

I suspect "PCI IO spaces" are a function of PCI bridge chips. We
already have structures corresponding to these chips.  Maybe all I
need to know is how to query a bridge chips config and see if it is
implementing a "PCI IO space". Then I could walk the bridge structures
and know how many VGA devices to create.

-- 
Jon Smirl
jonsmirl@gmail.com
