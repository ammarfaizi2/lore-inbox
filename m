Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966579AbWKOEXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966579AbWKOEXm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 23:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966576AbWKOEXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 23:23:42 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:36443 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S966579AbWKOEXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 23:23:41 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Miller <davem@davemloft.net>, torvalds@osdl.org, jeff@garzik.org,
       linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
X-Message-Flag: Warning: May contain useful information
References: <Pine.LNX.4.64.0611141747490.3349@woody.osdl.org>
	<455A7E21.7020701@garzik.org>
	<Pine.LNX.4.64.0611141846190.3349@woody.osdl.org>
	<20061114.190036.30187059.davem@davemloft.net>
	<1163563260.5940.205.camel@localhost.localdomain>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 14 Nov 2006 20:23:39 -0800
In-Reply-To: <1163563260.5940.205.camel@localhost.localdomain> (Benjamin Herrenschmidt's message of "Wed, 15 Nov 2006 15:01:00 +1100")
Message-ID: <adahcx1z6b8.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 15 Nov 2006 04:23:40.0265 (UTC) FILETIME=[D3E29D90:01C7086D]
Authentication-Results: sj-dkim-4; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim4002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Out of curiosity. Are you sure there is no case of stupid bridge
 > converting the MSI into some APIC/whatever interrupt for the CPU
 > potentially before all previous DMA have been fully pushed to the
 > coherent domain (still in some internal store queue for example) ?

That's forbidden by the PCI spec:

    "An MSI or MSI-X message, by virtue of being a posted memory write
    (PMW) transaction, is prohibited by PCI ordering rules from
    passing PMW transactions sent earlier by the function. The system
    must guarantee that an interrupt service routine invoked as a
    result of a given message will observe any updates performed by
    PMW transactions arriving prior to that message."

which is not to say that there are no chipsets with errata in this
area.  But I've never heard of such a thing...

 - R.
