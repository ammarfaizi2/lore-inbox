Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262624AbVCVLCB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262624AbVCVLCB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 06:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262625AbVCVLCB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 06:02:01 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:47813 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262624AbVCVLBo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 06:01:44 -0500
Date: Tue, 22 Mar 2005 12:01:26 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Len Brown <len.brown@intel.com>
Cc: Shaohua Li <shaohua.li@intel.com>, Andrew Morton <akpm@osdl.org>,
       rjw@sisk.pl, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-rc1-mm1: Kernel BUG at pci:389
Message-ID: <20050322110126.GB1780@elf.ucw.cz>
References: <20050322013535.GA1421@elf.ucw.cz> <1111461253.18927.15.camel@sli10-desk.sh.intel.com> <1111464268.17329.27.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111464268.17329.27.camel@d845pe>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Will this do it for the moment?

Its certainly better.

What about

> > > +static int acpi_pci_set_power_state(struct pci_dev *dev,
> > pci_power_t state)
> > > +{
> > > +     acpi_handle handle = DEVICE_ACPI_HANDLE(&dev->dev);
> > > +     static int state_conv[] = {
> > > +             [0] = 0,
> > > +             [1] = 1,
> > > +             [2] = 2,
> > > +             [3] = 3,
> > > +             [4] = 3
> > > +     };
> > > +     int acpi_state = state_conv[(int __force) state];

...this force? Then platform_pci_choose_state should not be NULL by
default and acpi_pci_choose_state should really have some more
reasonable calling convention.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
