Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750907AbWCIXBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbWCIXBz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbWCIXBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:01:55 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:8570 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S1750821AbWCIXBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:01:55 -0500
X-IronPort-AV: i="4.02,180,1139212800"; 
   d="scan'208"; a="313125834:sNHT31930036"
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 4 of 20] ipath - support for HyperTransport devices
X-Message-Flag: Warning: May contain useful information
References: <0b1b4f4c093e2db6153e.1141922817@localhost.localdomain>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 09 Mar 2006 15:01:49 -0800
In-Reply-To: <0b1b4f4c093e2db6153e.1141922817@localhost.localdomain> (Bryan O'Sullivan's message of "Thu,  9 Mar 2006 08:46:57 -0800")
Message-ID: <ada3bhrgr36.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 09 Mar 2006 23:01:54.0087 (UTC) FILETIME=[753C2370:01C643CD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > +		/* the HT capability type byte is 3 bytes after the
 > +		 * capability byte.
 > +		 */
 > +		if (pci_read_config_byte(pdev, pos + 3, &cap_type)) {
 > +			dev_info(&pdev->dev, "Couldn't read config "
 > +				 "command @ %d\n", pos);
 > +			continue;
 > +		}
 > +		if (!(cap_type & 0xE0)) {

It seems like all these hypertransport magic constants should be in a
general .h somewhere.  I'm not sure if it makes sense to put them in
<linux/pci.h>, or start a <linux/hypertransport.h>.

 > +				else if (linkctrl & (0xf << 8)) {
 > +					ipath_cdbg(
 > +						VERBOSE,
 > +						"Clear linkctrl%d CRC "
 > +						"Error bits %x\n", i,
 > +						linkctrl & (0xf << 8));
 > +					/*
 > +					 * now write them back to clear
 > +					 * the error.
 > +					 */
 > +					pci_write_config_byte(
 > +						pdev, link_off,
 > +						linkctrl & (0xf << 8));

The logic here is pretty hard to follow, and you're getting squeezed
pretty hard by indenting 5 tabs stops.  Can ipath_setup_ht_config() be
split up into subfunctions?
