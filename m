Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266078AbUFWQEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266078AbUFWQEI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 12:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265790AbUFWQEC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 12:04:02 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:41347 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S265930AbUFWQDZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 12:03:25 -0400
Date: Wed, 23 Jun 2004 18:03:20 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: jbglaw@lug-owl.de, linux-kernel@vger.kernel.org, miller@techsource.com
Subject: Re: Stop the Linux kernel madness
Message-ID: <20040623160320.GA28370@vana.vc.cvut.cz>
References: <A095D7F069C@vcnet.vc.cvut.cz> <20040622151236.GE20632@lug-owl.de> <20040622173215.GA6300@infradead.org> <20040622184220.GF20632@lug-owl.de> <40D99A93.8030900@techsource.com> <20040623150314.GA24169@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040623150314.GA24169@infradead.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2004 at 04:03:14PM +0100, Christoph Hellwig wrote:
> On Wed, Jun 23, 2004 at 10:58:27AM -0400, Timothy Miller wrote:
> > Whatever it is that VMware needs in the kernel can probably be 
> > generalized in some way that makes it useful to other things (like 
> > Win4Lin) and then merged into mainline.
> 
> We already have drivers/net/tun.c thaqt works nicely with Hercules and MoL
> for me, but I guess the vmware folks want some additional deep magic.

Unless I missed something, there can be only one userspace reader/writter
attached to the device, while vmnet works like real network segment to
which you can connect any number of userspace processes, and each of
processes gets only packets which are targeted for it (as each process
has its own MAC address). And vmnet interface does not have to have 
any representation in host's networking (it can be used just as a channel 
for communication between two VMs), which is important if your guests 
are running potentially dangerous code, like network worms.

vmnet module actually provides tun-like character device, but with several
differences:
* You can connect any number of userspace processes to it.
* You can connect kernel end to nothing (complete guest-host separation), or
* You can create new network device for kernel end (you'll route between
  guests and real world) or
* You can attach this character device to some existing network device,
  creating "bridge".

Of these features tun supports only third (creating new kernel network device),
and with help of "normal" bridge also fourth. Correct me if I'm wrong.
					Best regards,
						Petr Vandrovec

