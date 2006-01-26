Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbWAZOfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbWAZOfM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 09:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWAZOfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 09:35:11 -0500
Received: from cantor.suse.de ([195.135.220.2]:22408 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932340AbWAZOfK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 09:35:10 -0500
From: Andi Kleen <ak@suse.de>
To: Ashok Raj <ashok.raj@intel.com>
Subject: Re: Dont record local apic ids when they are disabled in MADT
Date: Thu, 26 Jan 2006 15:34:54 +0100
User-Agent: KMail/1.8.2
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, ak@muc.de,
       ronald@hummelink.net, DiegoCG@teleline.es,
       venkatesh.pallipadi@intel.com, anil.s.keshavamurthy@intel.com
References: <20060126054842.A11917@unix-os.sc.intel.com> <200601261455.11981.ak@suse.de> <20060126061034.A12261@unix-os.sc.intel.com>
In-Reply-To: <20060126061034.A12261@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200601261534.55620.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 January 2006 15:10, Ashok Raj wrote:
> On Thu, Jan 26, 2006 at 02:55:11PM +0100, Andi Kleen wrote:
> > On Thursday 26 January 2006 14:48, Ashok Raj wrote:
> > > Hi Andrew,
> > > 
> > > We had added additional_cpus=xx for x86_64, but apparently there were some
> > > BIOSs that had duplicate apic ids when they were reported disabled.
> > > 
> > > It seems fair not to record them, this was causing some bad behaviour due to
> > > the duplicate apic id. More details in the bugzilla recorded in the log.
> > 
> > This means CPU hotplug will require additional non existing code again - or who
> > will set up the APIC IDs etc. for the new CPUs then?
> 
> 
> The ACPI hotplug code already would refresh this apic id when the notify
> for CPU hotplug is processed. 

How? All the code who could do this is __init.

> (although i would say we tested this only on ia64 so far, the code is 
> generic to x86_64 as well, but i havent gone around testing physical hotplug
> via emulation patches we have internally)

I doubt it will work on x86-64.

And you're breaking the CPU hotplug spec in Documentation/x86-64/cpu-hotplug-spec.
I think the BIOS bugs need to be workarounded without breaking that.


-Andi
