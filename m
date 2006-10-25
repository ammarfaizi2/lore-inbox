Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030458AbWJYOFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030458AbWJYOFM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 10:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030455AbWJYOFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 10:05:11 -0400
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:54164 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1030458AbWJYOFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 10:05:02 -0400
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-ia64@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [openib-general] Ordering between PCI config space writes and MMIO reads?
X-Message-Flag: Warning: May contain useful information
References: <adafyddcysw.fsf@cisco.com> <20061024192210.GE2043@havoc.gtf.org>
	<20061024214724.GS25210@parisc-linux.org> <adar6wxbcwt.fsf@cisco.com>
	<20061024223631.GT25210@parisc-linux.org>
	<20061024225935.GK4054@obsidianresearch.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 25 Oct 2006 07:04:56 -0700
In-Reply-To: <20061024225935.GK4054@obsidianresearch.com> (Jason Gunthorpe's message of "Tue, 24 Oct 2006 16:59:35 -0600")
Message-ID: <adairi8biev.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 25 Oct 2006 14:04:56.0916 (UTC) FILETIME=[8D507940:01C6F83E]
Authentication-Results: sj-dkim-3.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > I'm not sure that can work either. The PCI-X spec is very clear, you
 > must wait for a non-posted completion if you care about order. Doing a
 > config read in the driver as a surrogate flush is not good enough in
 > the general case. Like you say, a pci bridge is free to reorder all
 > in flight non-posted operations.

No, hang on.  Nothing can reorder a dependent read to start after a
write that it depends on, can it?  So a config read of PCI_COMMAND
can't start until the completion of a config write of the same
register, right?

 - R.
