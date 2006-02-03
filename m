Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbWBCCBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbWBCCBo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 21:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbWBCCBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 21:01:44 -0500
Received: from mail.dvmed.net ([216.237.124.58]:58298 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964845AbWBCCBn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 21:01:43 -0500
Message-ID: <43E2B97F.305@pobox.com>
Date: Thu, 02 Feb 2006 21:01:35 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dan Williams <dan.j.williams@intel.com>
CC: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Chris Leech <christopher.leech@intel.com>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       Deepak Saxena <dsaxena@plexity.net>
Subject: Re: [RFC][PATCH 000 of 3] MD Acceleration and the ADMA interface:
 Introduction
References: <1138931168.6620.8.camel@dwillia2-linux.ch.intel.com>
In-Reply-To: <1138931168.6620.8.camel@dwillia2-linux.ch.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Dan Williams wrote: > This patch set was originally
	posted to linux-raid, Neil suggested that > I send to linux-kernel as
	well: > > Per the discussion in this thread
	(http://marc.theaimsgroup.com/? > t=112603120100004&r=1&w=2) these
	patches implement the first phase of MD > acceleration, pre-emptible
	xor. To date these patches only cover raid5 > calls to compute_parity
	for read/modify and reconstruct writes. The > plan is to expand this to
	cover raid5 check parity, raid5 compute block, > as well as the raid6
	equivalents. > > The ADMA (Asynchronous / Application Specific DMA)
	interface is proposed > as a cross platform mechanism for supporting
	system CPU offload engines. > The goal is to provide a unified
	asynchronous interface to support > memory copies, block xor, block
	pattern setting, block compare, CRC > calculation, cryptography etc.
	The ADMA interface should support a PIO > fallback mode allowing a
	given ADMA engine implementation to use the > system CPU for operations
	without a hardware accelerated backend. In > other words a client coded
	to the ADMA interface transparently receives > hardware acceleration
	for its operations depending on the features of > the underlying
	platform. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams wrote:
> This patch set was originally posted to linux-raid, Neil suggested that
> I send to linux-kernel as well:
> 
> Per the discussion in this thread (http://marc.theaimsgroup.com/?
> t=112603120100004&r=1&w=2) these patches implement the first phase of MD
> acceleration, pre-emptible xor.  To date these patches only cover raid5
> calls to compute_parity for read/modify and reconstruct writes.  The
> plan is to expand this to cover raid5 check parity, raid5 compute block,
> as well as the raid6 equivalents.
> 
> The ADMA (Asynchronous / Application Specific DMA) interface is proposed
> as a cross platform mechanism for supporting system CPU offload engines.
> The goal is to provide a unified asynchronous interface to support
> memory copies, block xor, block pattern setting, block compare, CRC
> calculation, cryptography etc.  The ADMA interface should support a PIO
> fallback mode allowing a given ADMA engine implementation to use the
> system CPU for operations without a hardware accelerated backend.  In
> other words a client coded to the ADMA interface transparently receives
> hardware acceleration for its operations depending on the features of
> the underlying platform.

Here are some other things out there worth considering:

* SCSI XOR commands

* Figuring out how to support Promise SX4 (e.g. device offload), which 
is a chip with integrated XOR engine and attached DIMM.  RAID1 and RAID5 
are best implemented on-card, but the Linux driver is responsible for 
implementing all on-card actions, not a firmware.

	Jeff


