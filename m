Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261904AbUEFTRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbUEFTRT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 15:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262347AbUEFTRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 15:17:03 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:35993 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262020AbUEFTOp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 15:14:45 -0400
Subject: RE: [2.6.6 PATCH] Exposing EFI memory map
From: Dave Hansen <haveblue@us.ibm.com>
To: Matthew E Tolentino <matthew.e.tolentino@intel.com>
Cc: Sourav Sen <souravs@india.hp.com>,
       "HELGAAS,BJORN (HP-Ft. Collins)" <bjorn_helgaas@am.exch.hp.com>,
       Matt Domsch <Matt_Domsch@dell.com>, linux-ia64@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Luck, Tony" <tony.luck@intel.com>,
       lhms <lhms-devel@lists.sourceforge.net>
In-Reply-To: <D36CE1FCEFD3524B81CA12C6FE5BCAB002FFEB1B@fmsmsx406.fm.intel.com>
References: <D36CE1FCEFD3524B81CA12C6FE5BCAB002FFEB1B@fmsmsx406.fm.intel.com>
Content-Type: text/plain
Message-Id: <1083869850.2811.549.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 06 May 2004 11:57:30 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cc'ing lhms list as well, as this has diverged a bit...

On Thu, 2004-05-06 at 11:47, Tolentino, Matthew E wrote:
> > On Thu, 2004-05-06 at 09:25, Sourav Sen wrote:
> > > From: Bjorn Helgaas [mailto:bjorn.helgaas@hp.com]
> > > 	Why not also update the efi memory table on a hotplug :-)
> > 
> > That's actually what ppc64 does.  But, they do it via /proc (not even
> > from inside the kernel).  I'm not very fond of that solution :)
> 
> Interesting. What does ppc64 do with the memmap after that?  

This doesn't even concern mem_map yet.  The userspace ppc64 hotplug
tools actually write into the "OpenFirmware" tree from userspace, after
a hotplug happens.  This is partly because all of the ppc64 hotplug
operations happen in userspace as it stands now.  

> So, allocate the page structs which constitute the new memmap, set up
> the nonlinear sections, and then wait for hotplug events in order to 
> clear the appropriate bits in the pages for a given range?  Is that 
> what you're thinking?

Actually, I was thinking that we'd just allocate the kobjects, and note
the presence of the memory in the nonlinear phys_section table.  Then,
when we online it, we can decide where it's mapped, what zone to put it
in, and where to get the mem_map space from.  I think that approach
gives the best flexibility. 

-- Dave

