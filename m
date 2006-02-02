Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423349AbWBBH2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423349AbWBBH2e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 02:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423346AbWBBH2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 02:28:34 -0500
Received: from mail.dvmed.net ([216.237.124.58]:45978 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1423349AbWBBH2e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 02:28:34 -0500
Message-ID: <43E1B490.7080200@pobox.com>
Date: Thu, 02 Feb 2006 02:28:16 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: Lee Revell <rlrevell@joe-job.com>, Mark Rustad <mrustad@mac.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] PCI: restore 2 missing pci ids
References: <200602010609.k1169QDX017012@hera.kernel.org> <43E0F73B.6040507@pobox.com> <A9543B03-333E-470F-AD18-0313192ADB23@mac.com> <1138857560.15691.0.camel@mindpipe> <D1A90FC1-95F7-4C2B-BC6D-1F60000FC989@mac.com>
In-Reply-To: <D1A90FC1-95F7-4C2B-BC6D-1F60000FC989@mac.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Kyle Moffett wrote: > On Feb 02, 2006, at 00:19, Lee
	Revell wrote: > >> On Wed, 2006-02-01 at 23:11 -0600, Mark Rustad
	wrote: >> >>> Why were the ids removed in the first place? >> >> >>
	Because they weren't used by anything in the tree. > > > Also, the new
	PCI-ID policy is to put the defines in the driver itself, > near where
	it is used, instead of collecting them in a single file. > The goal is
	to minimize the number of unused PCI IDs in the tree by > keeping the
	definition near the usage. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:
> On Feb 02, 2006, at 00:19, Lee Revell wrote:
> 
>> On Wed, 2006-02-01 at 23:11 -0600, Mark Rustad wrote:
>>
>>> Why were the ids removed in the first place?
>>
>>
>> Because they weren't used by anything in the tree.
> 
> 
> Also, the new PCI-ID policy is to put the defines in the driver  itself, 
> near where it is used, instead of collecting them in a single  file.  
> The goal is to minimize the number of unused PCI IDs in the  tree by 
> keeping the definition near the usage.

No, if you do create a constant for a PCI ID, it still should go into 
include/linux/pci_ids.h.

Putting them in the driver will result in highly variable naming 
policies, which in turn means the constants are less grep-able than today.

Device IDs simply do not need an associated constant, if they are used 
only in a PCI ID table.  Device IDs are arbitrary numbers that are 
normally only used once in a source file.

Vendor IDs are used repeatedly, and definitely belong in pci_ids.h. 
Device IDs make sense in pci_ids.h if they are used more than once.

	Jeff



