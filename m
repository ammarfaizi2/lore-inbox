Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbWFSKrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbWFSKrW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 06:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbWFSKrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 06:47:22 -0400
Received: from www.osadl.org ([213.239.205.134]:32166 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932368AbWFSKrV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 06:47:21 -0400
Subject: Re: [patch 0/5] [PATCH,RFC] vfs: per-superblock unused dentries
	list (2nd version)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: David Chinner <dgc@sgi.com>, Ingo Molnar <mingo@elte.hu>, neilb@suse.de,
       jblunck@suse.de, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
       balbir@in.ibm.com
In-Reply-To: <20060618233339.dba0fc86.akpm@osdl.org>
References: <20060601095125.773684000@hasse.suse.de>
	 <17539.35118.103025.716435@cse.unsw.edu.au>
	 <20060616155120.GA6824@hasse.suse.de>
	 <17555.12234.347353.670918@cse.unsw.edu.au>
	 <20060618235654.GB2114946@melbourne.sgi.com>
	 <17557.61307.364404.640539@cse.unsw.edu.au>
	 <20060619010013.GC2114946@melbourne.sgi.com>
	 <17557.64512.496195.714144@cse.unsw.edu.au>
	 <20060619055523.GS2795448@melbourne.sgi.com>
	 <20060618233339.dba0fc86.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 19 Jun 2006 12:48:44 +0200
Message-Id: <1150714124.27073.67.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-18 at 23:33 -0700, Andrew Morton wrote:
> > ....
> >     eth3      device: S2io Inc. Xframe 10 Gigabit Ethernet PCI-X (rev 03)
> >     eth3      configuration: eth-id-00:0c:fc:00:02:c8
> > irq 60, desc: a0000001009a2d00, depth: 1, count: 0, unhandled: 0
> > ->handle_irq():  0000000000000000, 0x0
> > ->chip(): a000000100a0fe40, irq_type_sn+0x0/0x80
> > ->action(): e00000b007471b80
> > ->action->handler(): a0000002059373d0, s2io_msi_handle+0x1510/0x660 [s2io]    eth3
> > IP address: 192.168.1.248/24
> > Unexpected irq vector 0x3c on CPU 3!
> 
> I guess that's where things start to go bad.  genirq changes?

Hmm, The extra noisy printout is from geirq. The unhandled interrupt
should be unrelated. 

The s2io driver enables interrupts in the card in start_nic() before
requesting the interrupt itself with request_irq(). So I suspect thats a
problem which has been there already, just the noisy printout makes it
more visible

	tglx


