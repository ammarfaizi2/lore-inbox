Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264650AbUGBQEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264650AbUGBQEP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 12:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264655AbUGBQEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 12:04:15 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:28217 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S264650AbUGBQEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 12:04:13 -0400
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Tom L Nguyen <tom.l.nguyen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: MSI to memory?
X-Message-Flag: Warning: May contain useful information
References: <200407011215.59723.bjorn.helgaas@hp.com>
From: Roland Dreier <roland@topspin.com>
Date: Fri, 02 Jul 2004 09:04:12 -0700
In-Reply-To: <200407011215.59723.bjorn.helgaas@hp.com> (Bjorn Helgaas's
 message of "Thu, 1 Jul 2004 12:15:59 -0600")
Message-ID: <52isd68kg3.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 02 Jul 2004 16:04:12.0476 (UTC) FILETIME=[374D87C0:01C4604E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Bjorn> The conventional use of MSI is for a PCI adapter to
    Bjorn> generate processor interrupts by writing to a local APIC.
    Bjorn> But I've seen some things that lead me to believe it would
    Bjorn> also allow an adapter to write to things other than a local
    Bjorn> APIC, i.e., to memory.

    Bjorn> If so, is that a useful capability that should be exposed
    Bjorn> through the Linux MSI interface?

MSI does allow an adapter to write messages to any arbitrary PCI
address (under the control of the host software).  It's not clear to
me that write to anywhere other than a special interrupt generation
address is that useful.

It is true that the current Linux MSI code is quite Intel-specific,
hard-coding Intel addresses and message contents.  At some point, if
I'm able to get documentation on interesting hardware, I would like to
try and move the generation of addresses/messages to arch-specific
code so that Linux can support more general PCI hosts.

Unfortunately, it seems that at least the current HyperTransport PCI-X
tunnels used on Opteron systems do not support MSI (based on my quick
reading of the documentation).  The only hardware I have access to
that supports MSI is the PowerPC 440GP, and I'm not sure how
interesting that is.

I assume that future PCI Express chipsets for Opteron will support
MSI, and hopefully documentation will be available (or manufacturers
will write Linux support).

Does anyone know if there are any ppc64 systems that support MSI?

Thanks,
  Roland
