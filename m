Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264446AbTIIVFH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 17:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264464AbTIIVFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 17:05:06 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:38161 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264446AbTIIVEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 17:04:55 -0400
Date: Tue, 9 Sep 2003 22:04:52 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Buggy PCI drivers - do not mark pci_device_id as discardable data
Message-ID: <20030909220452.S4216@flint.arm.linux.org.uk>
Mail-Followup-To: Zwane Mwaikambo <zwane@linuxpower.ca>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20030909204803.N4216@flint.arm.linux.org.uk> <Pine.LNX.4.53.0309091559110.14426@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.53.0309091559110.14426@montezuma.fsmlabs.com>; from zwane@linuxpower.ca on Tue, Sep 09, 2003 at 04:02:58PM -0400
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09, 2003 at 04:02:58PM -0400, Zwane Mwaikambo wrote:
> On Tue, 9 Sep 2003, Russell King wrote:
> 
> > --- orig/drivers/char/watchdog/amd7xx_tco.c	Sat Jun 14 22:33:48 2003
> > +++ linux/drivers/char/watchdog/amd7xx_tco.c	Tue Sep  9 20:45:16 2003
> > @@ -294,7 +294,7 @@
> >  	.fops	= &amdtco_fops
> >  };
> >  
> > -static struct pci_device_id amdtco_pci_tbl[] __initdata = {
> > +static struct pci_device_id amdtco_pci_tbl[] = {
> >  	/* AMD 766 PCI_IDs here */
> >  	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_OPUS_7443, PCI_ANY_ID, PCI_ANY_ID, },
> >  	{ 0, }
> 
> That's not a bug.
>
> > --- orig/drivers/char/watchdog/i810-tco.c	Sun Aug  3 11:21:11 2003
> > +++ linux/drivers/char/watchdog/i810-tco.c	Tue Sep  9 20:45:16 2003
> > @@ -301,7 +301,7 @@
> >   * register a pci_driver, because someone else might one day
> >   * want to register another driver on the same PCI id.
> >   */
> > -static struct pci_device_id i810tco_pci_tbl[] __initdata = {
> > +static struct pci_device_id i810tco_pci_tbl[] = {
> >  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_0,	PCI_ANY_ID, PCI_ANY_ID, },
> >  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_0,	PCI_ANY_ID, PCI_ANY_ID, },
> >  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0,	PCI_ANY_ID, PCI_ANY_ID, },
> 
> Neither is that.
> 
> > --- orig/drivers/char/hw_random.c	Sat Jun 14 22:33:46 2003
> > +++ linux/drivers/char/hw_random.c	Tue Sep  9 20:45:16 2003
> > @@ -149,7 +149,7 @@
> >   * register a pci_driver, because someone else might one day
> >   * want to register another driver on the same PCI id.
> >   */
> > -static struct pci_device_id rng_pci_tbl[] __initdata = {
> > +static struct pci_device_id rng_pci_tbl[] = {
> >  	{ 0x1022, 0x7443, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_amd },
> >  	{ 0x1022, 0x746b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_amd },
> 
> This too

Ok, I'm happy that this aren't (after reading someone elses explaination).

Having these different makes it hard to ensure that no further bad cases
exist in the tree though.

I want this to be foolproof, because its me people bug when their cardbus
cards oops when they insert the damned things.  If people are happy to
ignore this issue, I'm happy to ignore the bug reports.

It basically isn't something I want to deal with, and we need to find a
way to stop these stupidities appearing in the first place.

Any ideas?

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
