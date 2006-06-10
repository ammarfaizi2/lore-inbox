Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWFMMsB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWFMMsB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 08:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbWFMMsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 08:48:00 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1809 "EHLO spitz.ucw.cz")
	by vger.kernel.org with ESMTP id S1750748AbWFMMrw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 08:47:52 -0400
Date: Sat, 10 Jun 2006 13:34:12 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Adam Belay <abelay@novell.com>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 4/9] PCI PM: save and restore configuration state correctly
Message-ID: <20060610133412.GA4950@ucw.cz>
References: <1149497166.7831.158.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149497166.7831.158.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch updates pci_save_state() and pci_restore_state() to be more
> in line with the PCI PM specification.  Specifically, read-only
> registers are no longer saved, BIST is never touched, and the command
> register is handled more carefully.  A new data structure "struct
> pci_dev_config" is created to store any context that might need to be
> saved before entering a higher power state.
> 
> The configuration space cache is now obsolete and no longer needed for
> PCI PM.  However, this patch does not remove it as it is still
> referenced by the PCI configuration space access restriction code.  As
> an unexpected bonus, this patch also fixes a possible memory leak;
> drivers/pci/access.c wasn't expecting the MSI code in pci_save_state().

This should solve problems for people that use 'backwards' PCI space
restoring these days. Thanks, nice!

							Pavel
-- 
Thanks for all the (sleeping) penguins.
