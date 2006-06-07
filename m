Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWFGCkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWFGCkU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 22:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWFGCkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 22:40:20 -0400
Received: from peabody.ximian.com ([130.57.169.10]:60307 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S1750716AbWFGCkU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 22:40:20 -0400
Subject: Re: [PATCH  6/9] PCI PM: call platform helpers properly
From: Adam Belay <abelay@novell.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       Len Brown <len.brown@intel.com>
In-Reply-To: <1149553874.559.2.camel@localhost.localdomain>
References: <1149497171.7831.160.camel@localhost.localdomain>
	 <1149553874.559.2.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 06 Jun 2006 22:52:54 -0400
Message-Id: <1149648774.7831.217.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-06 at 10:31 +1000, Benjamin Herrenschmidt wrote:
> > -	pci_write_config_word(dev, pm->pm_offset + PCI_PM_CTRL, pmcsr);
> > +	/* call platform helpers (e.g. ACPI) before restoring power */
> > +	if (state == PCI_D0 && platform_pci_set_power_state)
> > +		platform_pci_set_power_state(dev, state);
> 
> I think the platform helper need to be able to either return from the
> function directly or at least you should read back the state before
> continuing. The platform helper may call into firmware which might
> handle the complete state transition. Thus, when you come back from it,
> you probably need to check the device-state, or provide return codes for
> the platform helper to affect the code flow of the rest of the function.

Hmm, do you know of any example firmware scenarios that make the entire
state transition?  We might need a separate callback.  I think the
changes in this patch are at least an improvement over the current
behavior, especially for ACPI PM functions.  

Thanks,
Adam


