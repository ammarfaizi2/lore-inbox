Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267012AbUBMNhT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 08:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267014AbUBMNhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 08:37:18 -0500
Received: from lists.us.dell.com ([143.166.224.162]:32926 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S267012AbUBMNhQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 08:37:16 -0500
Date: Fri, 13 Feb 2004 07:36:47 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Nagy Tibor <nagyt@otpbank.hu>
Cc: xela@slit.de, mochel@osdl.org, bmoyle@mvista.com, orc@pell.chi.il.us,
       linux-kernel@vger.kernel.org
Subject: Re: HIGHMEM
Message-ID: <20040213073647.B24512@lists.us.dell.com>
References: <402CC114.8080100@dell633.otpefo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <402CC114.8080100@dell633.otpefo.com>; from nagyt@otpbank.hu on Fri, Feb 13, 2004 at 01:20:36PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 13, 2004 at 01:20:36PM +0100, Nagy Tibor wrote:
> We have two Dell Poweredge servers, an older one (PowerEdge 6300) and a
> newer one (PowerEdge 6400). Both servers have 4GB RAM, but the Linux
> kernel uses about 500MB less memory in the newer machine.

This is a FAQ on the Linux-PowerEdge mailing list, and is captured here.
http://lists.us.dell.com/fom-serve/cache/68.html

I have 4GB (or more) RAM in my system. How come Linux sees less than
that?

BIOS must reserve some address space below 4GB for PCI devices such as
RAID controllers, SCSI controllers, NICs, etc. RAID controllers in
particular may request and be given 256MB each. This is address space
that would normally be occupied by RAM, but instead is used by PCI
devices.

RAM addresses start at 0 and grow up. PCI device addresses start at
~4GB and grow down. As long as there is no overlap, the OS will see
all available RAM and make use of it. If there is overlap, the PCI
devices win, and that RAM is not made available to the OS.

This is working as designed per PCI, BIOS, and system chipset
specifications. 


You may wish to subscribe to the Linux-PowerEdge@dell.com mailing list
at http://lists.us.dell.com/.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
