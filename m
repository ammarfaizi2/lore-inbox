Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262168AbULQXlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbULQXlA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 18:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262229AbULQXk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 18:40:59 -0500
Received: from gprs215-176.eurotel.cz ([160.218.215.176]:36493 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262168AbULQXj0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 18:39:26 -0500
Date: Sat, 18 Dec 2004 00:39:15 +0100
From: Pavel Machek <pavel@suse.cz>
To: Greg KH <greg@kroah.com>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: Cleanup PCI power states
Message-ID: <20041217233915.GB29084@elf.ucw.cz>
References: <20041116130445.GA10085@elf.ucw.cz> <20041116155613.GA1309@kroah.com> <20041117120857.GA6952@openzaurus.ucw.cz> <20041124234057.GF4649@kroah.com> <20041125113631.GB1027@elf.ucw.cz> <20041217220208.GA22752@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041217220208.GA22752@kroah.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Okay, here it is, slightly expanded version. It actually makes use of
> > newly defined type for type-checking purposes; still no code changes.
> 
> Alright, I've applied this, and it will show up in the next -mm release.
> I also fixed up pci.h for when CONFIG_PCI=N due to your changed
> functions.

Thanks... Hopefully I guessed the change right, otherwise this will
need to be applied by hand.

This adds missing prototype for pci_choose_state.								

Signed-off-by: Pavel Machek <pavel@suse.cz>

--- linux.middle//include/linux/pci.h	2004-11-14 23:36:46.000000000 +0100
+++ linux/include/linux/pci.h	2004-12-18 00:35:33.000000000 +0100
@@ -790,6 +790,7 @@
 int pci_save_state(struct pci_dev *dev, u32 *buffer);
 int pci_restore_state(struct pci_dev *dev, u32 *buffer);
 int pci_set_power_state(struct pci_dev *dev, pci_power_t state);
+pci_power_t pci_choose_state(struct pci_dev *dev, u32 state);
 int pci_enable_wake(struct pci_dev *dev, pci_power_t state, int enable);
 
 /* Helper functions for low-level code (drivers/pci/setup-[bus,res].c) */
@@ -924,6 +925,7 @@
 static inline int pci_save_state(struct pci_dev *dev, u32 *buffer) { return 0; }
 static inline int pci_restore_state(struct pci_dev *dev, u32 *buffer) { return 0; }
 static inline int pci_set_power_state(struct pci_dev *dev, pci_power_t state) { return 0; }
+static inline pci_power_t pci_choose_state(struct pci_dev *dev, u32 state) { return PCI_D0; }
 static inline int pci_enable_wake(struct pci_dev *dev, pci_power_t state, int enable) { return 0; }
 
 #define	isa_bridge	((struct pci_dev *)NULL)


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
