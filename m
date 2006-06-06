Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750871AbWFFAcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWFFAcH (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 20:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWFFAcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 20:32:06 -0400
Received: from gate.crashing.org ([63.228.1.57]:28641 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750871AbWFFAcF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 20:32:05 -0400
Subject: Re: [PATCH  6/9] PCI PM: call platform helpers properly
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Adam Belay <abelay@novell.com>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
        linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
        Len Brown <len.brown@intel.com>
In-Reply-To: <1149497171.7831.160.camel@localhost.localdomain>
References: <1149497171.7831.160.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 06 Jun 2006 10:31:14 +1000
Message-Id: <1149553874.559.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> -	pci_write_config_word(dev, pm->pm_offset + PCI_PM_CTRL, pmcsr);
> +	/* call platform helpers (e.g. ACPI) before restoring power */
> +	if (state == PCI_D0 && platform_pci_set_power_state)
> +		platform_pci_set_power_state(dev, state);

I think the platform helper need to be able to either return from the
function directly or at least you should read back the state before
continuing. The platform helper may call into firmware which might
handle the complete state transition. Thus, when you come back from it,
you probably need to check the device-state, or provide return codes for
the platform helper to affect the code flow of the rest of the function.

Ben.


