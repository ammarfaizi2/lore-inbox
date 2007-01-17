Return-Path: <linux-kernel-owner+w=401wt.eu-S1750823AbXAQWfI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbXAQWfI (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 17:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbXAQWfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 17:35:08 -0500
Received: from ccerelbas04.cce.hp.com ([161.114.21.107]:46661 "EHLO
	ccerelbas04.cce.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbXAQWfH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 17:35:07 -0500
X-MIMEOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: PME_Turn_Off in Linux
Date: Wed, 17 Jan 2007 16:35:02 -0600
Message-ID: <E717642AF17E744CA95C070CA815AE550116BB82@cceexc23.americas.cpqcorp.net>
In-Reply-To: <20070117213318.GA2525@kroah.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PME_Turn_Off in Linux
Thread-Index: Acc6f0BDEOCaODtvSD2T5t+B+RUW/QABcn6Q
From: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
To: "Greg KH" <greg@kroah.com>
Cc: "LKML" <linux-kernel@vger.kernel.org>,
       "Nguyen, Tom L" <tom.l.nguyen@intel.com>,
       "Brainard, Jim" <jim.brainard@hp.com>,
       "Patterson, Andrew D (Linux R&D)" <andrew.patterson@hp.com>,
       <linux-pci@atrey.karlin.mff.cuni.cz>
X-OriginalArrivalTime: 17 Jan 2007 22:35:03.0493 (UTC) FILETIME=[BAF47F50:01C73A87]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

greg k-h wrote: 

> On Wed, Jan 17, 2007 at 10:43:14AM -0600, Miller, Mike (OS Dev) wrote:
> > Hello,
> > We've been seeing some nasty data corruption issues on some 
> platforms.
> > We've been capturing PCI-E traces looking for something 
> nasty but we 
> > haven't found anything yet. One of the hardware guys if asking if 
> > there is a call in Linux to issue a PME_Turn_Off broadcast message.
> >  
> > PME_Turn_Off Broadcast Message
> > Before main component power and reference clocks are turned 
> off, the 
> > Root Complex or Switch Downstream Port must issue a 
> broadcast Message 
> > that instructs all agents downstream of that point within the 
> > hierarchy to cease initiation of any subsequent PM_PME Messages, 
> > effective immediately upon receipt of the PME_Turn_Off Message.
> > 
> > This must be initiated from the root complex. Is there such 
> a call in 
> > linux?
> 
> This firmware that implements the PCI-E connection should do 
> this, I don't think there is anything that the Operating 
> system can do to control this, as PCI-E should be transparant 
> to the OS.

Hmmm, the hw folks tell me that "other" os'es implement that. But I
would tend to agree that system firmware should probably be doing this.

> 
> Unless this is on a PCI-E Hotplug system?  What is the 

No hotplug.

> sequence of events that cause the data corruption?

Install rhel4 u4 on ia64, at the reboot prompt let the system sit idle
for several hours or overnight. Then after rebooting the filesystems are
totally trashed. I usually get a message that the kernel is not a valid
compressed file format. If I try to rescue the system I cannot mount any
filesystems. I don't have the message handy but it complains about an
invalid Verneed record, whatever that is.

I've also tried the same procedure using a dumb SAS hba. It complained
that it couldn't read the initrd image but on a second attempt it acted
like it read the initrd but the system goes out in the weeds while
booting. Not the same symptoms but I suspect there's some relationship.

I have not tried any other distros yet.

Thanks,
mikem
