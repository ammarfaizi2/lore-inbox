Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752055AbWCBTvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbWCBTvJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 14:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752059AbWCBTvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 14:51:09 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:18529 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S1752055AbWCBTvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 14:51:08 -0500
X-IronPort-AV: i="4.02,160,1139212800"; 
   d="scan'208"; a="1781391318:sNHT104165404"
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 0/4] PCI legacy I/O port free driver (take4)
X-Message-Flag: Warning: May contain useful information
References: <44070B62.3070608@jp.fujitsu.com>
	<20060302155056.GB28895@flint.arm.linux.org.uk>
	<20060302172436.GC22711@colo.lackof.org>
	<20060302193441.GG28895@flint.arm.linux.org.uk>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 02 Mar 2006 11:50:59 -0800
In-Reply-To: <20060302193441.GG28895@flint.arm.linux.org.uk> (Russell King's message of "Thu, 2 Mar 2006 19:34:41 +0000")
Message-ID: <adalkvswrq4.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 02 Mar 2006 19:51:00.0637 (UTC) FILETIME=[A18E1CD0:01C63E32]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Russell> Why isn't pci_enable_device_bars() sufficient - why do we
    Russell> have to have another interface to say "we don't want BARs
    Russell> XXX" ?

That's an excellent point.  It does look like fixing
pci_enable_device_bars() would be a reasonable interface as well.
Currently, pci_enable_device() calls pci_enable_device_bars() on all
resources, and then does two more things:

    - It calls pci_fixup_device() on the device
    - It sets dev->is_enabled

Both of these things look like they could just be moved into
pci_enable_device_bars(), leaving pci_enable_device() as a
compatibility wrapper.

Along with a fix for pci_request_regions(), the legacy-free patch
would just modify drivers for devices that know they don't need a
particular BAR, without adding an extra flag to the pci device struct.

 - R.
