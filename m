Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265789AbUGEAwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265789AbUGEAwU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 20:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265872AbUGEAwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 20:52:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11229 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265789AbUGEAwR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 20:52:17 -0400
Date: Sun, 4 Jul 2004 21:23:05 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Zack Brown <zbrown@tumblerings.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problems getting SMP to work with vanilla 2.4.26
Message-ID: <20040705002305.GA20847@logos.cnet>
References: <20040704020543.GA1776@tumblerings.org> <20040704141336.GA18851@logos.cnet> <20040704181438.GB3816@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040704181438.GB3816@tumblerings.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 04, 2004 at 11:14:38AM -0700, Zack Brown wrote:
> Hi Marcelo, folks,
> 
> On Sun, Jul 04, 2004 at 11:13:36AM -0300, Marcelo Tosatti wrote:
> > On Sat, Jul 03, 2004 at 07:05:43PM -0700, Zack Brown wrote:
> > > Hi folks,
> > > 
> > > When booting vanilla 2.4.26 with SMP enabled, I get a lockup before the
> > > boot sequence is completed. The same kernel with SMP disabled boots and runs
> > > just fine. Both CPUs are detected by the system at bootup, before lilo takes
> > > over. Here's the error as I wrote it down from the screen, followed by the
> > > .config file:
> > > 
> > > ------------------------------ cut here ------------------------------
> > > Using local APIC timer interrupts.
> > > Calibrating APIC timer...
> > > ..... CPU clock speed is 1004.4785 MHZ
> > > ..... hostbus clock speed is 133.9304 MHz
> > > cpu: 0, clocks: 1339304, slice: 446434
> > > CPU0<T0:1339296,T1:892848,D:14,S:446434,C:1339304>
> > > cpu: 1, clocks: 1339304, slice: 446434
> > > CPU1<T0:1339296,T1:446416,D:12,S:446434,C:1339304>
> > > ------------------------------ cut here ------------------------------
> > > 
> > > At that point the machine just hangs, with no keys recognized, and I have
> > > to power-cycle the machine in order to boot to a UP kernel.
> > > 
> > > I'd appreciate any help I can get with this.
> > 
> > I can't help much really. Tried CONFIG_ACPI_BOOT=n ? 
> > 
> 
> I did after getting your email, and I had some trouble with that. After
> 'make mrproper', and loading in the relevant .config I'd saved, menuconfig
> then said that I had the ACPI option already disabled. If I enabled the master
> ACPI section, all the sub-options were also disabled. So I had to quit out of
> that and edit the .config by hand in order to set CONFIG_ACPI_BOOT=n. That's
> the only change I made to the .config before recompiling.
> 
> I did a 'make dep' and 'make bzImage', and got the following error. It
> looks like the kernel really wants that option enabled.

Hi Zack, 

Silly me, its not possible to compile SMP image without CONFIG_ACPI_BOOT (a lot of
SMP detection code is linked to basic ACPI infrastructure).

Can you please try the nolapic/noapic boot options? They should disable the APIC, and
if APIC is the "root" of your crashes, we will find out that way.

Sorry for the noise.
