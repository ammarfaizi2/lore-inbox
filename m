Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263620AbUAOVxZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 16:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbUAOVwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 16:52:50 -0500
Received: from linux.us.dell.com ([143.166.224.162]:62851 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S262730AbUAOVwi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 16:52:38 -0500
Date: Thu, 15 Jan 2004 15:52:21 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Scott Long <scott_long@adaptec.com>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
Subject: Re: Proposed enhancements to MD
Message-ID: <20040115155221.A31378@lists.us.dell.com>
References: <40033D02.8000207@adaptec.com> <16389.52150.148792.875315@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16389.52150.148792.875315@notabene.cse.unsw.edu.au>; from neilb@cse.unsw.edu.au on Thu, Jan 15, 2004 at 10:07:34AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 15, 2004 at 10:07:34AM +1100, Neil Brown wrote:
> On Monday January 12, scott_long@adaptec.com wrote:
> > All,
> > 
> > Adaptec has been looking at the MD driver for a foundation for their
> > Open-Source software RAID stack.  This will help us provide full
> > and open support for current and future Adaptec RAID products (as
> > opposed to the limited support through closed drivers that we have
> > now).
> 
> Sounds like a great idea.
>
> > - Metadata abstraction:  We intend to support multiple on-disk metadata
> >    formats, along with the 'native MD' format.  To do this, specific
> >    knowledge of MD on-disk structures must be abstracted out of the core
> >    and personalities modules.
> 
> In 2.4, this would be a massive amount of work and I don't recommend
> it.

Scott has a decent stab at doing so already in 2.4, and I've encouraged him
to post the code he's got now.  Since it's too intrusive for 2.4,
perhaps it could be added in parallel, an "emd" driver, and one could
choose to use emd to get the DDF functionality, or continue to use md
without DDF.

Here are some of the features I know I'm looking for, and I've
compared solutions suggested. Comments/corrections welcome.

* Solution works in both 2.4 and 2.6 kernels
  - less ideal of two different solutions are needed
* RAID 0,1 DDF format
* Bootable from degraded R1
* Online Rebuild
* Mgmt tools/hooks
  - online create, delete, modify
* Event notification/logging
* Error Handling
* Installation - simple i.e. without modifying distro installers
  significantly or at all; driver disk only is ideal


>From what I see about DM at present:
* RAID 0,1 possible, dm-raid1 module in Sistina CVS needs to get merged
* Boot drive - requires setup method early in boot process, either
  initrd or kernel code
* Boot from degraded RAID1 requires setup method early in boot
  process, either initrd or kernel code.
* Online Rebuild - dm-raid1 has this capability
* mgmt tools/hooks - DM has today way to communicate to kernel the
  changes desired. What remains is userspace tools that read, modify DDF
  metadata and calls into these hooks.
* Event notification / logging - doesn't appear to exist in DM
* Error handling - unclear if/how DM handles this.  For instance, how
  is a disk failure on a dm-raid1 array handled?
* Installation - RHEL3 doesn't include DM yet, significant installer
  work necessary for several distros.


>From what I see about md:
* RAID 0,1 there today, no DDF
* Boot drive - yes
* Boot from degraded RAID1 - possible but may require manual
  intervention depending on BIOS capabilities
* Online Rebuild - there today
* mgmt tools/hooks - mdadm there today
* Event notification / logging - mdadm there today
* Error handling - there today
* Installation - disto installer capable of this today


>From what I see about emd:
* RAID 0,1 - code being developed by Adaptec today, DDF capable
* Boot drive - yes
* Boot from degraded RAID1 - possible without intervention due to
  Adaptec BIOS
* Online Rebuild - there today
* mgmt tools/hooks - mdadm there today, expect Adaptec to enhance mdam to support DDF
* Event notification / logging - mdadm there today
* Error handling - there today
* Installation - could be done with only a driver disk which adds the
  emd module.

Am I way off base here? :-)

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
