Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265136AbUFWSZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265136AbUFWSZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 14:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265789AbUFWSZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 14:25:29 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:16256 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S265136AbUFWSZ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 14:25:27 -0400
Date: Wed, 23 Jun 2004 20:26:13 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Christoph Hellwig <hch@infradead.org>, jbglaw@lug-owl.de,
       linux-kernel@vger.kernel.org, miller@techsource.com
Subject: Re: Stop the Linux kernel madness
Message-ID: <20040623182613.GA1458@ucw.cz>
References: <A095D7F069C@vcnet.vc.cvut.cz> <20040622151236.GE20632@lug-owl.de> <20040622173215.GA6300@infradead.org> <20040622184220.GF20632@lug-owl.de> <40D99A93.8030900@techsource.com> <20040623150314.GA24169@infradead.org> <20040623160320.GA28370@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040623160320.GA28370@vana.vc.cvut.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2004 at 06:03:20PM +0200, Petr Vandrovec wrote:
> On Wed, Jun 23, 2004 at 04:03:14PM +0100, Christoph Hellwig wrote:
> > On Wed, Jun 23, 2004 at 10:58:27AM -0400, Timothy Miller wrote:
> > > Whatever it is that VMware needs in the kernel can probably be 
> > > generalized in some way that makes it useful to other things (like 
> > > Win4Lin) and then merged into mainline.
> > 
> > We already have drivers/net/tun.c thaqt works nicely with Hercules and MoL
> > for me, but I guess the vmware folks want some additional deep magic.
> 
> Unless I missed something, there can be only one userspace reader/writter
> attached to the device, while vmnet works like real network segment to
> which you can connect any number of userspace processes, and each of
> processes gets only packets which are targeted for it (as each process
> has its own MAC address). And vmnet interface does not have to have 
> any representation in host's networking (it can be used just as a channel 
> for communication between two VMs), which is important if your guests 
> are running potentially dangerous code, like network worms.
> 
> vmnet module actually provides tun-like character device, but with several
> differences:
> * You can connect any number of userspace processes to it.
> * You can connect kernel end to nothing (complete guest-host separation), or

These can be done purely in userspace - a daemon can exchange the data
between the processes (VMs).

> * You can create new network device for kernel end (you'll route between
>   guests and real world) or

This can be done with tun, preferably opened by the abovementioned
daemon.

> * You can attach this character device to some existing network device,
>   creating "bridge".

And this is IMO pretty ugly to do. It is probably needed to get NetBEUI
working between the VM and real network.

> Of these features tun supports only third (creating new kernel network device),
> and with help of "normal" bridge also fourth. Correct me if I'm wrong.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
