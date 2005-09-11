Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbVIKIBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbVIKIBh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 04:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbVIKIBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 04:01:37 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:41117 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S964821AbVIKIBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 04:01:36 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Greg KH <greg@kroah.com>
Cc: Grant Coady <lkml@dodo.com.au>, Jeff Garzik <jgarzik@pobox.com>,
       "Gaston, Jason D" <jason.d.gaston@intel.com>, mj@ucw.cz, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 2.6.13-rc4 1/1] pci_ids: patch for Intel ICH7R
Date: Sun, 11 Sep 2005 18:00:59 +1000
Organization: http://bugsplatter.mine.nu/
Message-ID: <pfn7i1ll7g5bs8sm8kq0md33f8khsujrbf@4ax.com>
References: <26CEE2C804D7BE47BC4686CDE863D0F5046EA44B@orsmsx410> <42EAABD1.8050903@pobox.com> <n4ple1haga8eano2vt2ipl17mrrmmi36jr@4ax.com> <42EAF987.7020607@pobox.com> <6f0me1p2q3g9ralg4a2k2mcra21lhpg6ij@4ax.com> <20050911031150.GA20536@kroah.com>
In-Reply-To: <20050911031150.GA20536@kroah.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Sep 2005 20:11:50 -0700, Greg KH <greg@kroah.com> wrote:

>On Sat, Jul 30, 2005 at 02:54:17PM +1000, Grant Coady wrote:
>> On Fri, 29 Jul 2005 23:52:39 -0400, Jeff Garzik <jgarzik@pobox.com> wrote:
>> >
>> >However you did your search, you did it wrong.  The very first two 
>> >entries I tried had zero uses:
>> >
>> >[jgarzik@pretzel linux-2.6]$ grepsrc ICH7_22
>> >./include/linux/pci_ids.h:#define PCI_DEVICE_ID_INTEL_ICH7_22   0x27e0
>> >[jgarzik@pretzel linux-2.6]$ grepsrc ICH7_23
>> >./include/linux/pci_ids.h:#define PCI_DEVICE_ID_INTEL_ICH7_23   0x27e2
>> >[jgarzik@pretzel linux-2.6]$
>> 
>> Sorry Jeff, excluding "include/linux/pci_ids.h" makes a huge difference :o)
>> 
>> Does roughly 1/3 unused:
>> 
>> 63065 2005-07-30 14:51 pci_ids-list
>> 19243 2005-07-30 14:52 pci_ids-not_used
>> 
>> Seem in ballpark?
>
>Great, care to send me a patch that trims this file down?

Just ran the discovery script on 2.6.13.mm2, there's roughly 1609 
symbols unused in pci_ids.h, another 1030 are defined throughout the 
source tree, leaving 729 in pci_ids.h.  Total unique symbols is 1030.
Not counted are macro defined symbols: 

PCI_DEVICE_ID_##id
PCI_DEVICE_ID_##v##_##d
PCI_DEVICE_ID_BROOKTREE_##chip
PCI_VENDOR_ID_##v

from:

linux-2.6.13-mm2/drivers/video/cirrusfb.c
linux-2.6.13-mm2/sound/oss/ymfpci.c
linux-2.6.13-mm2/sound/pci/bt87x.c


What is the goal here?  Is a comment stripped, non-duplicate pci_ids.h 
with a reference to source site okay? 
 
Should the various distributed defines be collected to the one header 
file and that header be include'd to those files?  It seems pci_ids.h 
is redundant.

Thanks,
Grant.

