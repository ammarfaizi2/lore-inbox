Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264540AbTEPSvD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 14:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264544AbTEPSvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 14:51:03 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:32743 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S264540AbTEPSvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 14:51:02 -0400
Subject: Re: 2.5.69-mm5: pccard oops while booting: resolved
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Ben Collins <bcollins@debian.org>
Cc: Andrew Morton <akpm@digeo.com>, rmk@arm.linux.org.uk,
       LKML <linux-kernel@vger.kernel.org>, davej@suse.de
In-Reply-To: <20030516181331.GP433@phunnypharm.org>
References: <1052964213.586.3.camel@teapot.felipe-alfaro.com>
	 <20030514191735.6fe0998c.akpm@digeo.com>
	 <1052998601.726.1.camel@teapot.felipe-alfaro.com>
	 <20030515130019.B30619@flint.arm.linux.org.uk>
	 <1053004615.586.2.camel@teapot.felipe-alfaro.com>
	 <20030515144439.A31491@flint.arm.linux.org.uk>
	 <1053037915.569.2.camel@teapot.felipe-alfaro.com>
	 <20030515160015.5dfea63f.akpm@digeo.com>
	 <1053090184.653.0.camel@teapot.felipe-alfaro.com>
	 <20030516181331.GP433@phunnypharm.org>
Content-Type: text/plain
Message-Id: <1053111794.586.4.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 16 May 2003 21:03:14 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-16 at 20:13, Ben Collins wrote:
> > 1. Simply by changing KOBJ_NAME_LEN from 20 to 16 fixes the problem.
> > This leads me to think there are some parts of the kernel (a driver, to
> > be more exact) that are corrupting memory or doing something really
> > nasty that is affecting PCI ID's tables and pci_bus_match() function.

> Are you sure you have a pristine source and everything is rebuilt
> against the new header? It'd be very easy for one object file to have the
> incorrect name len and cause this problem.

I'm 200% sure:

1. tar jxvf linux-2.5.69.tar.bz2
2. zcat 2.5.69-mm6.gz | patch  -p1
3. make menuconfig

There is something in the Yamaha DS-XG PCI driver (I think the problem
lies in alsa_card_ymfpci_init()) that is somewhat corrupting the PCI
ID's table, or something else, that's causing the pci_bus_match()
function to oops.

I'm no kernel expert, so I've been unable to guess much more than this.

