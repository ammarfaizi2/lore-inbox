Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbVLARts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbVLARts (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 12:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbVLARts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 12:49:48 -0500
Received: from mail.dvmed.net ([216.237.124.58]:6086 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932350AbVLARtq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 12:49:46 -0500
Message-ID: <438F37AB.5030800@pobox.com>
Date: Thu, 01 Dec 2005 12:49:31 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
CC: Christoph Hellwig <hch@infradead.org>,
       "Darrick J. Wong" <djwong@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Luvella McFadden <luvella@us.ibm.com>, AJ Johnson <blujuice@us.ibm.com>,
       Kevin Stansell <kstansel@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, Mauelshagen@redhat.com
Subject: Re: [PATCH] aic79xx should be able to ignore HostRAID enabled adapters
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01E3E318@otce2k03.adaptec.com>
In-Reply-To: <547AF3BD0F3F0B4CBDC379BAC7E4189F01E3E318@otce2k03.adaptec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Salyzyn, Mark wrote: > Justin Gibbs had provided the
	community the emd driver, soundly rejected > and never ported to dm
	because there were features that Justin held dear > in md that do not
	translate to dm. An unfortunate waste of considerable > resources.
	[...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Salyzyn, Mark wrote:
> Justin Gibbs had provided the community the emd driver, soundly rejected
> and never ported to dm because there were features that Justin held dear
> in md that do not translate to dm. An unfortunate waste of considerable
> resources.

All throughout development, before Justin had written a single line of 
code, he was told to do things via Device Mapper.  All he had to do was 
open his ears, and no resource waste would have occurred.


> Without the timely agenda and cooled temperaments to close the gap, the
> solution should be temporarily to support the proprietary HostRAID
> driver when the Adapter is in HostRAID mode and we continue to work to
> close that gap on dmraid.
[...]
> They are plain SCSI HBAs, but are designated as a RAID card rather than
> a Host Bus Adapter in the PCI config space when in 'HostRAID' mode. The
> fact that is designated in the PCI space should be enough reason *not*
> to attach a simplified LLD.

Strongly disagree.

Linux should export the [non-RAID] hardware capabilities, nothing more.

We don't shim for not-in-tree binary-only drivers.  A user continues to 
be free to simply -not use- aic79xx, regardless of this design decision. 
  SATA controllers come with all sorts of class codes:  RAID (host/fake 
raid), SCSI (fake RAID/fake scsi), IDE, Serial ATA.

We ignore that, and just export the hardware.  The class code is only a 
hint that dmraid should be loaded on top of the low-level driver.


> Linux is not about performance first, it is about doing it the Linux
> way. I believe we can understand that. And in turn, do not consider it
> harmful if a group of individuals trying to make a living see a chance
> to acquire a competitive edge.

We don't do it "the Linux way" just for NIH's sake.  There are strong 
reasons why we want cross-vendor solutions.  There are strong reasons 
why we don't want every driver to embed a software RAID engine inside 
it.  And there are strong reasons (some legal, not technical) why its 
best to ignore binary-only, out-of-tree drivers.

	Jeff


