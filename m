Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbVLAGlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbVLAGlr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 01:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbVLAGlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 01:41:47 -0500
Received: from mail.dvmed.net ([216.237.124.58]:51136 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932096AbVLAGlq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 01:41:46 -0500
Message-ID: <438E9B24.9020806@pobox.com>
Date: Thu, 01 Dec 2005 01:41:40 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Darrick J. Wong" <djwong@us.ibm.com>
CC: Chris McDermott <lcm@us.ibm.com>, Luvella McFadden <luvella@us.ibm.com>,
       AJ Johnson <blujuice@us.ibm.com>, Kevin Stansell <kstansel@us.ibm.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] aic79xx should be able to ignore HostRAID enabled adapters
References: <438E90DD.3010007@us.ibm.com>
In-Reply-To: <438E90DD.3010007@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Darrick J. Wong wrote: > Hi there, > > I have an IBM
	x346 with some Adaptec 7902 SCSI controllers; one has HostRAID >
	enabled in a RAID array, and the other does not. Upon bootup, the
	aic79xx > driver will grab both controllers even though I'd prefer that
	Adaptec's a320raid > driver grab the HostRAID controller. (When
	attached to the RAID array, the > aic79xx driver presents each drive in
	the array as a separate SCSI device.) If > HostRAID is turned on, the
	PCI class code is 0x0104 (RAID) and if it's turned > off, the class
	code is 0x0100 (SCSI). > > Unfortunately, there currently is no
	provision in the aic79xx driver to ignore > RAID controllers--if the
	PCI device/vendor IDs match, the driver takes the > controller. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Darrick J. Wong wrote:
> Hi there,
> 
> I have an IBM x346 with some Adaptec 7902 SCSI controllers; one has HostRAID
> enabled in a RAID array, and the other does not.  Upon bootup, the aic79xx
> driver will grab both controllers even though I'd prefer that Adaptec's a320raid
> driver grab the HostRAID controller.  (When attached to the RAID array, the
> aic79xx driver presents each drive in the array as a separate SCSI device.)  If
> HostRAID is turned on, the PCI class code is 0x0104 (RAID) and if it's turned
> off, the class code is 0x0100 (SCSI).
> 
> Unfortunately, there currently is no provision in the aic79xx driver to ignore
> RAID controllers--if the PCI device/vendor IDs match, the driver takes the
> controller.

This is the correct behavior.  Under Linux, the driver should export 
only the underlying hardware, and nothing more.  This is how all the 
SATA controller drivers function, and this is how aic79xx functions.

Use a tool such as 'dmraid' for vendor-proprietary RAID solutions.

Your patch is therefore strongly NAK'd.

	Jeff



