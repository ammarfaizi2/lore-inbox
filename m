Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264142AbTEXHZL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 03:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264185AbTEXHZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 03:25:11 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51980 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264142AbTEXHZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 03:25:10 -0400
Date: Sat, 24 May 2003 08:38:07 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       linux-ia64@linuxia64.org, davidm@napali.hpl.hp.com, akpm@digeo.com
Subject: Re: /proc/kcore - how to fix it
Message-ID: <20030524083807.A1192@flint.arm.linux.org.uk>
Mail-Followup-To: "Luck, Tony" <tony.luck@intel.com>,
	Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
	linux-ia64@linuxia64.org, davidm@napali.hpl.hp.com, akpm@digeo.com
References: <DD755978BA8283409FB0087C39132BD101B00E0A@fmsmsx404.fm.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <DD755978BA8283409FB0087C39132BD101B00E0A@fmsmsx404.fm.intel.com>; from tony.luck@intel.com on Fri, May 23, 2003 at 04:51:43PM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 23, 2003 at 04:51:43PM -0700, Luck, Tony wrote:
> > One alternative I considered was to use just do a page table lookup.
> > But I fear that some architectures use direct mapping registers etc.
> > with mappings not in the page tables for the direct mapping, so it 
> > probably won't work for everybody.
> 
> You are right.  IA64 maps the kernel with some locked registers, so
> there are no pagetables to show that the mapping exists.

ARM maps the kernel direct-mapped RAM using 1MB section mappings, which
the normal pgd/pmd/pte macros don't recognise as being valid.

> I don't know ... you'll have to dust off those fixes for /proc to let
> the negative file offsets get as far as the kcore.c code so we can
> see what utilities work.  In practice we probably don't care about
> anything other than gdb.

gdb definitely breaks - that's why I had to do the changes in the first
place.  gdb tries to lseek to negative 64-bit file offsets, which the
kernel rejects with EINVAL iirc.  (Tried it earlier this week.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

