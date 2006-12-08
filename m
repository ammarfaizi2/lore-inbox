Return-Path: <linux-kernel-owner+w=401wt.eu-S1947326AbWLHVpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947326AbWLHVpR (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 16:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947315AbWLHVpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 16:45:17 -0500
Received: from sj-iport-6.cisco.com ([171.71.176.117]:36221 "EHLO
	sj-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1947326AbWLHVpP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 16:45:15 -0500
X-IronPort-AV: i="4.09,515,1157353200"; 
   d="scan'208"; a="90020007:sNHT44315919"
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] e1000: use pcix_set_mmrbc
X-Message-Flag: Warning: May contain useful information
References: <20061208182241.786324000@osdl.org>
	<20061208182500.478856000@osdl.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 08 Dec 2006 13:45:05 -0800
In-Reply-To: <20061208182500.478856000@osdl.org> (Stephen Hemminger's message of "Fri, 08 Dec 2006 10:22:43 -0800")
Message-ID: <adalkli6p0e.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 08 Dec 2006 21:45:06.0975 (UTC) FILETIME=[205E22F0:01C71B12]
Authentication-Results: sj-dkim-8; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim8002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > -        if (hw->bus_type == e1000_bus_type_pcix) {
 > -            e1000_read_pci_cfg(hw, PCIX_COMMAND_REGISTER, &pcix_cmd_word);
 > -            e1000_read_pci_cfg(hw, PCIX_STATUS_REGISTER_HI,
 > -                &pcix_stat_hi_word);
 > -            cmd_mmrbc = (pcix_cmd_word & PCIX_COMMAND_MMRBC_MASK) >>
 > -                PCIX_COMMAND_MMRBC_SHIFT;
 > -            stat_mmrbc = (pcix_stat_hi_word & PCIX_STATUS_HI_MMRBC_MASK) >>
 > -                PCIX_STATUS_HI_MMRBC_SHIFT;
 > -            if (stat_mmrbc == PCIX_STATUS_HI_MMRBC_4K)
 > -                stat_mmrbc = PCIX_STATUS_HI_MMRBC_2K;
 > -            if (cmd_mmrbc > stat_mmrbc) {
 > -                pcix_cmd_word &= ~PCIX_COMMAND_MMRBC_MASK;
 > -                pcix_cmd_word |= stat_mmrbc << PCIX_COMMAND_MMRBC_SHIFT;
 > -                e1000_write_pci_cfg(hw, PCIX_COMMAND_REGISTER,
 > -                    &pcix_cmd_word);
 > -            }
 > -        }
 > +        if (hw->bus_type == e1000_bus_type_pcix)
 > +		e1000_pcix_set_mmrbc(hw, 2048);

This changes the behavior of the driver.  The existing driver only
sets MMRBC if it's bigger than min(2048, value in the status register).
You're setting MMRBC to 2048 even if it starts out at a smaller value.

 - R.
