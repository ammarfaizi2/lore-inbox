Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262313AbVAJQ3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262313AbVAJQ3w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 11:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262317AbVAJQ3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 11:29:52 -0500
Received: from colin2.muc.de ([193.149.48.15]:23057 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262313AbVAJQ3v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 11:29:51 -0500
Date: 10 Jan 2005 17:29:50 +0100
Date: Mon, 10 Jan 2005 17:29:50 +0100
From: Andi Kleen <ak@muc.de>
To: Brian King <brking@us.ibm.com>
Cc: paulus@samba.org, benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] pci: Block config access during BIST (resend)
Message-ID: <20050110162950.GB14039@muc.de>
References: <200501101449.j0AEnWYF020850@d03av01.boulder.ibm.com> <m14qhpxo2j.fsf@muc.de> <41E2AC74.9090904@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E2AC74.9090904@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The problem I am trying to solve is the userspace PCI access methods 
> accessing my config space when the adapter is not able to handle such an 
> access. Today these accesses bypass the device driver altogether and 
> there is no way to stop them. An alternative to this patch would be to 

For this I would add a semaphore or a lock bit to pci_dev.
Probably a simple flag is good enough that is checked by sysfs/proc
and return EBUSY when set. 

This assumes that the driver controls the device during BIST time.

-Andi
