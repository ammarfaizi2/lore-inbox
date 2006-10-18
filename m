Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422664AbWJRRGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422664AbWJRRGK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 13:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422696AbWJRRGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 13:06:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47565 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422664AbWJRRGI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 13:06:08 -0400
Date: Wed, 18 Oct 2006 10:02:19 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Prakash Punnoor <prakash@punnoor.de>, Adrian Bunk <bunk@stusta.de>,
       alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
       mingo@redhat.com, hnguyen@de.ibm.com, perex@suse.cz
Subject: Re: [Alsa-devel] [RFC: 2.6.19 patch] snd-hda-intel: default MSI to
 off
Message-ID: <20061018100219.5cd08ffd@freekitty>
In-Reply-To: <s5hmz7tapl5.wl%tiwai@suse.de>
References: <200610050938.10997.prakash@punnoor.de>
	<5aa69f860610051030l7323ec2el545873570052f077@mail.gmail.com>
	<200610052309.01155.prakash@punnoor.de>
	<20061017211301.GE3502@stusta.de>
	<20061017144053.29b6b29c@freekitty>
	<s5hmz7tapl5.wl%tiwai@suse.de>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2006 12:24:54 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> At Tue, 17 Oct 2006 14:40:53 -0700,
> Stephen Hemminger wrote:
> > 
> > On Tue, 17 Oct 2006 23:13:01 +0200
> > Adrian Bunk <bunk@stusta.de> wrote:
> > 
> > > On Thu, Oct 05, 2006 at 11:08:57PM +0200, Prakash Punnoor wrote:
> > > > Am Donnerstag 05 Oktober 2006 19:30 schrieb Fatih A????c??:
> > > > > 2006/10/5, Prakash Punnoor <prakash@punnoor.de>:
> > > > > > Hi,
> > > > > >
> > > > > > subjects say it all. Without irqpoll my nic doesn't work anymore. I added
> > > > > > Ingo
> > > > > > to cc, as my IRQs look different, so it may be a prob of APIC routing or
> > > > > > the
> > > > > > like.
> > > > 
> > > > > > Can you try booting with pci=nomsi ? I have a similar problem with my
> > > > 
> > > > I used snd-hda-intel.disable_msi=1 and this actually helped! Now the nforce 
> > > > nic works w/o problems. So it was the audio driver causing havoc on the nic. 
> > > >...
> > > 
> > > Unless someone finds and fixes what causes such problems, I'd therefore 
> > > suggest the patch below to let MSI support to be turned off by default.
> > > 
> > > cu
> > > Adrian
> > > 
> > 
> > It shouldn't be that hard to write a small bit of code to force an interrupt
> > and catch it, that's what other drivers do to workaround the BIOS braindamage
> > that seems to be rampant (until M$ Vista comes out and supports MSI).
> 
> OK, what about a patch like below?
> 
> It's against the latest ALSA tree, so please pull alsa.git from
> 	git://kernel.org/pub/scm/linux/kernel/git/perex/alsa.git
> before applying it (this tree includes only patches to be pushed to
> 2.6.19).
> 
> 
> Takashi
> 

Don't you need to check return value from pci_enable_msi()?

-- 
Stephen Hemminger <shemminger@osdl.org>
