Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWCIRVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWCIRVr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 12:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWCIRVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 12:21:47 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:1970 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S1750706AbWCIRVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 12:21:46 -0500
X-IronPort-AV: i="4.02,179,1139212800"; 
   d="scan'208"; a="414002910:sNHT32870600"
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 0 of 20] [RFC] ipath driver, latest changes
X-Message-Flag: Warning: May contain useful information
References: <patchbomb.1141922813@localhost.localdomain>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 09 Mar 2006 09:21:44 -0800
In-Reply-To: <patchbomb.1141922813@localhost.localdomain> (Bryan O'Sullivan's message of "Thu,  9 Mar 2006 08:46:53 -0800")
Message-ID: <adaacbzlejb.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 09 Mar 2006 17:21:45.0207 (UTC) FILETIME=[F0983070:01C6439D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Bryan>   - We've introduced support for our PCI Express chips, so
    Bryan> the driver is no longer HyperTransport-specific.  It's
    Bryan> still a 64-bit driver, because 32-bit platforms don't
    Bryan> implement readq or writeq.  (It does compile cleanly on
    Bryan> i386, but of course fails to link.)

That seems pretty bad.  Do you really need to read 64 bits in one bus
transaction, or could you just use two readl()s to get the same effect?

    Bryan>   - Our hardware only supports MSI interrupts.  I don't
    Bryan> know how to program it to interrupt us if CONFIG_PCI_MSI is
    Bryan> not set.  Right now, we have a timer-based hack in place to
    Bryan> emulate interrupts.

Is this true for PCI Express too?

    Bryan>   - There's clearly something wrong with the way we're
    Bryan> pinning some pages into memory, but I don't actually know
    Bryan> what it is.  I'm pretty sure our use of get_user_pages is
    Bryan> correct, so I suspect it must be the code that's doing
    Bryan> SetPageReserved (see ipath_driver.c and ipath_file_ops.c).

    Bryan>     I've spent some time trying to figure out what the
    Bryan> problem is, but am stumped.  If someone knows what we
    Bryan> should be doing instead, I'd be delighted to hear from
    Bryan> them.

What are the symptoms of the problem?

 - R.
