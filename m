Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264430AbTEPMuX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 08:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264432AbTEPMuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 08:50:23 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:27548 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S264430AbTEPMuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 08:50:22 -0400
Subject: Re: 2.5.69-mm5: pccard oops while booting: resolved
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Andrew Morton <akpm@digeo.com>
Cc: rmk@arm.linux.org.uk, LKML <linux-kernel@vger.kernel.org>, davej@suse.de
In-Reply-To: <20030515160015.5dfea63f.akpm@digeo.com>
References: <1052964213.586.3.camel@teapot.felipe-alfaro.com>
	 <20030514191735.6fe0998c.akpm@digeo.com>
	 <1052998601.726.1.camel@teapot.felipe-alfaro.com>
	 <20030515130019.B30619@flint.arm.linux.org.uk>
	 <1053004615.586.2.camel@teapot.felipe-alfaro.com>
	 <20030515144439.A31491@flint.arm.linux.org.uk>
	 <1053037915.569.2.camel@teapot.felipe-alfaro.com>
	 <20030515160015.5dfea63f.akpm@digeo.com>
Content-Type: text/plain
Message-Id: <1053090184.653.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 16 May 2003 15:03:04 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-16 at 01:00, Andrew Morton wrote: 
> Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> wrote:
> >
> > The test kernel is
> > a 2.5.69-mm5 with the "i8259-shutdown.patch" reverted, plus the above
> > patch and your previous "verbose" patch. Attached to this message is the
> > new "dmesg" from this patched kernel.
> > 
> > As I told Andrew, reverting "make-KOBJ_NAME-match-BUS_ID_SIZE.patch"
> > solves the oops.
> 
> The weird thing is that this patch really doesn't do anything apart from
> increasing KOBJ_NAME_LEN from 16 to 20.

OK, this is what I guessed by playing with 2.5.69-mm6:

1. Simply by changing KOBJ_NAME_LEN from 20 to 16 fixes the problem.
This leads me to think there are some parts of the kernel (a driver, to
be more exact) that are corrupting memory or doing something really
nasty that is affecting PCI ID's tables and pci_bus_match() function.

2. Disabling or enabling preemptible kernel does not help.

3. Now, changing KOBJ_NAME_LEN back to 20, and then disabling support
for the ALSA Yamaha PCI driver (YMFPCI) fixes the problem. I have tried
disabling other drivers, like USB-UHCI, AGPGART, but it doesn't help.
However, disabling YMFPCI solves the problem. So I guess, we've got a
problem at alsa_card_ymfpci_init() function. Note that the YMFPCI was
built-in into the kernel, and not as a module. However, building YMFPCI
as a module still produces an oops. I'll post more information when I
investigate a little more about this.

Any ideas on what's could be going on here? It's driving me nutts!

Thanks!

