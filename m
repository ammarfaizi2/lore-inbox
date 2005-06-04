Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbVFDPCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbVFDPCt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 11:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVFDPCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 11:02:49 -0400
Received: from webmail.topspin.com ([12.162.17.3]:42220 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S261376AbVFDPCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 11:02:44 -0400
To: Dave Jones <davej@redhat.com>
Cc: Greg KH <gregkh@suse.de>, Grant Grundler <grundler@parisc-linux.org>,
       tom.l.nguyen@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: Re: pci_enable_msi() for everyone?
X-Message-Flag: Warning: May contain useful information
References: <20050603224551.GA10014@kroah.com>
	<20050604013112.GB16999@colo.lackof.org>
	<20050604064821.GC13238@suse.de>
	<20050604070537.GB8230@colo.lackof.org>
	<20050604071803.GA13684@suse.de> <20050604072348.GA28293@redhat.com>
From: Roland Dreier <roland@topspin.com>
Date: Sat, 04 Jun 2005 07:58:38 -0700
In-Reply-To: <20050604072348.GA28293@redhat.com> (Dave Jones's message of
 "Sat, 4 Jun 2005 03:23:48 -0400")
Message-ID: <52psv2rwwx.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 04 Jun 2005 15:02:43.0679 (UTC) FILETIME=[75D186F0:01C56916]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Dave> What if MSI support has been disabled in the bridge due to
    Dave> some quirk (like the recent AMD 8111 quirk) ?  Maybe the
    Dave> above function should check pci_msi_enable as well ?

You can't disable MSI at a bridge -- according to the PCI spec, as
soon as a device has the MSI enable turned on, it must start using MSI
for interrupts and must not ever assert an interrupt pine.  The issue
with AMD 8131 is that it doesn't have any MSI support and just
silently throws away MSI messages, and so the host never gets
interrupts from devices in MSI mode.  Which means any device below
such a host bridge better not have MSI or MSI-X enabled.

 - R.
