Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265964AbUGOEPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265964AbUGOEPn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 00:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265971AbUGOEPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 00:15:43 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:45538 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265964AbUGOEPl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 00:15:41 -0400
Subject: Re: kexec on ppc64
From: Dave Hansen <haveblue@us.ibm.com>
To: "R. Sharada [imap]" <sharada@in.ibm.com>
Cc: fastboot@lists.osdl.org,
       PPC64 External List <linuxppc64-dev@lists.linuxppc.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040714144514.GA2041@in.ibm.com>
References: <20040714144514.GA2041@in.ibm.com>
Content-Type: text/plain
Message-Id: <1089864891.10000.257.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 14 Jul 2004 21:14:51 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

taking silly IBM list off the cc...

On Wed, 2004-07-14 at 07:45, R Sharada 
>         - also identify relevant data (that might be required for the
> kexec kernel) that could be pushed into the device_tree so that it can
> be passed to the new kexec kernel

We actually had a similar problem on x86.  The e820 table is presented
by the BIOS, and must be saved or reconstructed when you boot into the
new kernel.  

It would be really cool to have a way of passing the memory layout
information to the new kernel that is relatively cross-platform.  That
way, we don't get stuck rewriting it for each new arch.  

For instance, instead of passing the BIOS/firmware structures like LMBs 
in the device tree or e820 tables to the kexec kernel, you'd pass the
Linux concepts like zone_start_pfn and so forth.

> I would like to solicit inputs, feedback, opinions, changes on this
> preliminary idea and planned list of 'things to do'. I would also like
> to know the interest to participate in this effort or anything else
> related to 'kexec on ppc64'.

While you're ripping apart prom.c, have you thought about getting rid of
all of the RELOC() stuff?  I think Ben H. had an evil plan for that,
too.

BTW, have you seen any opportunities to replace the arch-specific things
like lmb_alloc() with normal bootmem calls?

-- Dave

