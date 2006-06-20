Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbWFTUXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbWFTUXQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 16:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbWFTUXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 16:23:16 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:14161 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1750872AbWFTUXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 16:23:15 -0400
X-IronPort-AV: i="4.06,158,1149490800"; 
   d="scan'208"; a="297992906:sNHT38634288"
To: Andi Kleen <ak@suse.de>
Cc: Dave Olson <olson@unixfolk.com>, discuss@x86-64.org,
       Brice Goglin <brice@myri.com>, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: [discuss] Re: [RFC] Whitelist chipsets supporting MSI and check Hyper-transport capabilities
X-Message-Flag: Warning: May contain useful information
References: <fa.5FgZbVFZIyOdjQ3utdNvbqTrUq0@ifi.uio.no>
	<fa.URgTUhhO9H/aLp98XyIN2gzSppk@ifi.uio.no>
	<Pine.LNX.4.61.0606192237560.25433@osa.unixfolk.com>
	<200606200925.30926.ak@suse.de>
	<20060620200352.GJ1414@greglaptop.internal.keyresearch.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 20 Jun 2006 13:23:09 -0700
In-Reply-To: <20060620200352.GJ1414@greglaptop.internal.keyresearch.com> (Greg Lindahl's message of "Tue, 20 Jun 2006 13:03:52 -0700")
Message-ID: <adaejxjo9ua.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 20 Jun 2006 20:23:13.0783 (UTC) FILETIME=[5B3D4870:01C694A7]
Authentication-Results: sj-dkim-6.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Greg> What is the list of things which are known to have problems?
    Greg> All PCI-X?  We can ask some more people with PCI-X MSI cards
    Greg> what works for them, i.e.  Mellanox.

Actually most PCI-X works as well.  AMD 8131 PCI-X bridges don't work,
and it seems (based on the quirk in the kernel) that there are broken
Serverworks chipsets, but I've never actually seen motherboards with
that on there.

But for example I have an old Xeon motherboard which lspci says has

    PCI bridge: Intel Corporation 82870P2 P64H2 Hub PCI Bridge (rev 03)

and MSI works fine there.

There seem to be two issues here though.  First, MSI interrupts don't
always work, because of chipset bugs, BIOS bugs, etc.  This is fairly
manageable because the worst case is usually a single device not
generating interrupts.

However, the other issue is that CONFIG_PCI_MSI forces some other
changes to x86 interrupt handling, even if no devices will ever use
MSI.  And the changes are such that some systems can't even boot with
CONFIG_PCI_MSI enabled.  This is the more severe problem, which needs
to be handled if you want distros to turn on MSI.

 - R.
