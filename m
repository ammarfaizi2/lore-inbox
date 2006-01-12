Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932692AbWALVF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932692AbWALVF4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 16:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932697AbWALVFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 16:05:55 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:51403 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S932692AbWALVFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 16:05:54 -0500
Date: Thu, 12 Jan 2006 16:05:53 -0500
To: Daniel Drake <dsd@gentoo.org>
Cc: Jon Mason <jdmason@us.ibm.com>, mulix@mulix.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: pcnet32 devices with incorrect trident vendor ID
Message-ID: <20060112210553.GA18972@csclub.uwaterloo.ca>
References: <20060112175051.GA17539@us.ibm.com> <43C6C0E6.7030705@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C6C0E6.7030705@gentoo.org>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 08:49:42PM +0000, Daniel Drake wrote:
> On the subject of pcnet32 and the invalid vendor ID, you may find this 
> interesting:
> 
> http://forums.gentoo.org/viewtopic-t-420013-highlight-trident.html
> 
> The user saw the correct vendor ID (AMD) in 2.4, but when upgrading to 
> 2.6, it changed to Trident.
> 
> I guess this is still likely to be a hardware bug, but it demonstrates 
> that the Linux PCI layer has something to do with it (even if it is just 
> triggering it somehow).

Perhaps there is a significant different in the pcnet32.c files between
the two versions.  I also remember that there is some powerpc specific
code in there related to MAC address detection.  There are certainly
differences in 2.4 and 2.6's version of the driver, maybe something is
broken in the newer one when run on powerpc.  I don't run gentoo and
have no idea how to get a hold of the source of pcnet32.c from each of
those two.

It does seem odd that only the pcnet32 has the pci ID change, but at the
same time, somehow the driver is recognizing it and loading at boot
time, so the ID can't be wrong at that time.  Does the ID get mangled as
part of what makes the MAC addresses read incorrectly on your 2.6.14?
The 2.4 system shows all the cards overriding the MAC based on the PROM,
which I believe is what the driver code should do on a powerpc system.
On 2.6 that appears to only happen on one of the cards.  At least on
that device (pci 01:01) appears to agree what the MAC should be in both
cases.

Perhaps the lspci being wrong is just a side effect of the real problem.
Maybe the driver is broken and messing things up.

Len Sorensen
