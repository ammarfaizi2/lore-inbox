Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030311AbVIISFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030311AbVIISFg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 14:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030309AbVIISFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 14:05:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61927 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030307AbVIISFf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 14:05:35 -0400
Date: Fri, 9 Sep 2005 11:05:50 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Josip Loncaric <josip@lanl.gov>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: PROBLEM: sk98lin misbehaves with D-Link DGE-530T which doesn't
 have readable VPD
Message-ID: <20050909110550.3fb82d36@localhost.localdomain>
In-Reply-To: <4321CB39.3080206@lanl.gov>
References: <42EE9721.5000501@lanl.gov>
	<4321CB39.3080206@lanl.gov>
X-Mailer: Sylpheed-Claws 1.9.13 (GTK+ 2.6.7; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Sep 2005 11:49:45 -0600
Josip Loncaric <josip@lanl.gov> wrote:

> Driver sk98lin makes repeated attempts to read VPD even after the first 
> VpdInit() fails.  This is wrong.
> 
> Lots of people seem to be getting repeated "Vpd: Cannot read VPD keys" 
> errors.  When nifd is active, this can happen every second, causing 
> kernel stalls that disrupt time-critical operations (e.g. DVD use).

The sk98lin driver is wrapped around VPD for it's silly proprietary
network management interface.  


> Inexpensive cards like D-Link DGE-530T may lack a readable VPD, so there 
> is no point in trying to access this missing feature and causing brief 
> system stalls (see 
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=136158).
> 
> Can sk98lin be enhanced to give up on VPD after the first VpdInit() 
> fails?  The NIC appears to operate stably even without a readable VPD.
> 
> I haven't tested the experimental driver skge, but the same comment may 
> apply.  Obviously it makes no sense to repeatedly look for VPD keys when 
> the VPD is missing or incorrect.

Skge doesn't use VPD for anything, it works fine on my D-Link card.
The same data is available for applications that have a need
(like linux-diag lsvpd) via the standard pci interface in sysfs.

Now that skge is in 2.6.13, perhaps the proper thing to do is to take
DGE-530T out of the PCI table for sk98lin?
