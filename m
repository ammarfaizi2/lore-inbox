Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbWCNQIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbWCNQIJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 11:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbWCNQIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 11:08:09 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:63717 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S1750954AbWCNQII (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 11:08:08 -0500
Subject: Re: [PATCH] kexec for ia64
From: Khalid Aziz <khalid_aziz@hp.com>
To: Zou Nan hai <nanhai.zou@intel.com>
Cc: Fastboot mailing list <fastboot@lists.osdl.org>,
       Linux ia64 <linux-ia64@vger.kernel.org>,
       LKML <linux-kernel@vger.kernel.org>, "Luck, Tony" <tony.luck@intel.com>
In-Reply-To: <1142318909.2545.4.camel@linux-znh>
References: <1142271576.10787.15.camel@lyra.fc.hp.com>
	 <1142318909.2545.4.camel@linux-znh>
Content-Type: text/plain
Date: Tue, 14 Mar 2006 09:08:04 -0700
Message-Id: <1142352485.18421.11.camel@lyra.fc.hp.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-14 at 14:48 +0800, Zou Nan hai wrote:
> 3. Is the set ar.k0 code necessary? ar.k0 is already holding the right
> value.

Purely defensive coding to ensure new kernel does not fall on its
face :)

> 
> 4. Is the VHPT disable code necessary? kernel will soon goes into
> Physical mode and the new kernel will reset VHPT walker.

Again, playing it safe. We do not want VHPT walker waking up at this
point. Instead of assuming code will not do anything that could cause
VHPT walker to wake up, it is better to just disable it. This way, if
any code makes erroneous references to a virtual address which causes
VHPT walker to make a TLB entry, it will simply get a page fault and we
can catch that. It is much harder to debug if VHPT walker silently makes
a TLB entry for an unexpected virtual address reference and then things
go wrong further down the line.

> 
> 5. Is the PCI disable code too complex?

I have simplified it as much as I can. Suggestions to simplify further
would be appreciated.
> 
> The overall concern is I am afraid the code is too much than
> necessary. 
> 

After testing this kexec code for over 10,000 iterations of kexec'ing, I
have found not shutting devices down results in many corner cases that
have been fairly hard to debug. Adding all this code to shut down as
much of the hardware as possible has resulted in much more reliable
kexec code.

-- 
Khalid

====================================================================
Khalid Aziz                       Open Source and Linux Organization
(970)898-9214                                        Hewlett-Packard
khalid.aziz@hp.com                                  Fort Collins, CO

"The Linux kernel is subject to relentless development" 
                                - Alessandro Rubini


