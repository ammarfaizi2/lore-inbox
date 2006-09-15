Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751366AbWIONCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbWIONCd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 09:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbWIONCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 09:02:33 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:49179 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S1751366AbWIONCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 09:02:32 -0400
DomainKey-Signature: s=smtpout; d=dell.com; c=nofws; q=dns; b=AaiTIuiynPJ/AZOnTFtlN9ClPJUIV25WTXclErOTL0FmDoUuV+nrnhYhX77z/xZvg0uDY44P4ojcVxbK/+4Sh2TBXyriiIt8+r+/zmXIpzWz1Ar1Yjsdwm79e6fwllPf;
X-IronPort-AV: i="4.09,170,1157346000"; 
   d="scan'208"; a="80778282:sNHT17257806"
Date: Fri, 15 Sep 2006 08:02:26 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Dan Carpenter <error27.lkml@gmail.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, error27@gmail.com,
       ppokorny@penguincomputing.com
Subject: Re: [PATCH 2.6.18-rc5] PCI: sort device lists breadth-first
Message-ID: <20060915130226.GA2291@lists.us.dell.com>
References: <20060908031422.GA4549@lists.us.dell.com> <b263e5900609142053r12fbb71ep6ea3e1d63a722d4e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b263e5900609142053r12fbb71ep6ea3e1d63a722d4e@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2006 at 08:53:16PM -0700, Dan Carpenter wrote:
> On 9/7/06, Matt Domsch <Matt_Domsch@dell.com> wrote:
> >Problem:
> >Many people have come to expect this naming.  Linux 2.6
> >kernels name these eth1 and eth0 respectively (backwards from
> >expectations).  I also have reports that various Sun and HP servers
> >have similar behavior.
> >
> 
> On RHEL3 the 32bit and 64bit versions order the NICs differently.
> 64bit RHEL3 orders it the same as 2.6.
>
> I've got a lot of systems where the NIC LEDs are labelled.  The labels
> are correct for 2.6 but not for 2.4 32 bit.  I'm suspect the labels
> were designed for Windows originally.

2.4 i386 by default resorts the list by what BIOS reports the order
should be.  No other arches do this.  So I'd expect it to be opposite
of what you say.

Care to send the output of 'lspci -tv' and the first 80 or so lines of
dmidecode?  This is curious.

 
> My boss pointed out that this patch.  It was supposed to make PCI bus
> ordering match 2.4.
> http://kernel.org/git/?p=linux/kernel/git/torvalds/old-2.6-bkcvs.git;a=commitdiff;h=ffdd6e8f870ca6dd0d9b9169b8c2e0fdbae99549
> It's still there, why did it stop working?
> 
> Couldn't we just use the labelling from the DMI data to order the NICs?

Unfortunately, DMI data doesn't include enough information.  It says
"there's a port called NIC1", but doesn't say where to find it in PCI
space. :-(  I'm looking at ACPI 3.0 extensions, but am not finding
what I'm needing here either yet.

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
