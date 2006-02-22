Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161257AbWBVALs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161257AbWBVALs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 19:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161259AbWBVALs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 19:11:48 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:31167
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1161257AbWBVALr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 19:11:47 -0500
Date: Tue, 21 Feb 2006 16:11:43 -0800
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andi Kleen <ak@suse.de>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       akpm@osdl.org, rmk+lkml@arm.linux.org.uk
Subject: Re: [PATCH 3/6] PCI legacy I/O port free driver (take2) - Add device_flags into pci_device_id
Message-ID: <20060222001142.GA31605@kroah.com>
References: <43FAB283.8090206@jp.fujitsu.com> <200602212231.55879.ak@suse.de> <43FB8C4F.6070802@pobox.com> <200602212306.24342.ak@suse.de> <43FBABA4.7020906@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FBABA4.7020906@pobox.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 07:09:08PM -0500, Jeff Garzik wrote:
> Andi Kleen wrote:
> >On Tuesday 21 February 2006 22:55, Jeff Garzik wrote:
> >
> >
> >>It doesn't matter how easily its added, it is the wrong place to add 
> >>such things.
> >>
> >>This is what the various functions called during pci_driver::probe() do...
> >
> >
> >The problem is that at least on the e1000 it only applies to some of the 
> >many PCI-IDs it supports. So the original patch had an long ugly switch
> >with PCI IDs to check it. I suggested to use driver_data for it then,
> >but Kenji-San ended up with this new field.  I actually like the idea
> >of the new field because it would allow to add such things very easily
> >without adding lots of code.
> >
> >it's not an uncommon situation. e.g. consider driver A which supports
> >a lot of PCI-IDs but MSI only works on a few of them. How do you
> >handle this? Add an ugly switch that will bitrot? Or put all the 
> >information into a single place which is the pci_device_id array.
> 
> You do what tons of other drivers do, and indicate this via driver_data. 
>  An enumerated type in driver_data can be used to uniquely identify any 
> device or set of devices.
> 
> No need to add anything.

Yes, I agree, use driver_data, it's simpler, and keeps the PCI core
clean.

thanks,

greg k-h
