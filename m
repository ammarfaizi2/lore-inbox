Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262022AbVFGWpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262022AbVFGWpP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 18:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbVFGWoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 18:44:22 -0400
Received: from webmail.topspin.com ([12.162.17.3]:26743 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S262022AbVFGWnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 18:43:53 -0400
To: Greg KH <gregkh@suse.de>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>, tom.l.nguyen@intel.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       ak@suse.de
Subject: Re: [RFC PATCH] PCI: remove access to pci_[enable|disable]_msi()
 for drivers
X-Message-Flag: Warning: May contain useful information
References: <20050607002045.GA12849@suse.de>
	<20050607010911.GA9869@plap.qlogic.org>
	<20050607051551.GA17734@suse.de>
	<1118129500.5497.16.camel@laptopd505.fenrus.org>
	<20050607161029.GB15345@suse.de>
	<1118176872.5497.38.camel@laptopd505.fenrus.org>
	<20050607220832.GA19173@suse.de>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 07 Jun 2005 15:43:53 -0700
In-Reply-To: <20050607220832.GA19173@suse.de> (Greg KH's message of "Tue, 7
 Jun 2005 15:08:32 -0700")
Message-ID: <52ekbdg53q.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 07 Jun 2005 22:43:53.0418 (UTC) FILETIME=[6181E2A0:01C56BB2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Greg> Hm, or does it really help for the driver to specify
    Greg> different numbers of msi-x vectors?

    Greg> Roland, any ideas here?  You seem to be the only one who has
    Greg> actually used the msix code so far.

Yes, I think that the driver definitely needs to be in control of how
many MSI-X interrupts it gets.  The current mthca driver knows that it
has three different event queues -- one for firmware command events,
one for async events such as link up/down, and one for actual tx/rx
completions -- and uses a separate MSI-X message for each one.

Pretty soon I'm going to want to split the tx/rx event queue into one
event queue per CPU, so that applications can have their completions
events delivered to the same CPU where they're running, so I'll want
to bump up the number of MSI-X entries I request.

I'm sure other MSI-X capable devices can slice and dice things differently.

 - R.
