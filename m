Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261750AbUL3X0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbUL3X0X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 18:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbUL3X0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 18:26:22 -0500
Received: from colin2.muc.de ([193.149.48.15]:43781 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261750AbUL3X0T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 18:26:19 -0500
Date: 31 Dec 2004 00:26:17 +0100
Date: Fri, 31 Dec 2004 00:26:17 +0100
From: Andi Kleen <ak@muc.de>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: YhLu <YhLu@tyan.com>, linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: 256 apic id for amd64
Message-ID: <20041230232617.GA20210@muc.de>
References: <3174569B9743D511922F00A0C943142307290EEE@TYANWEB> <m1d5wrlj5p.fsf@muc.de> <20041230225602.GA27670@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041230225602.GA27670@lists.us.dell.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2004 at 04:56:02PM -0600, Matt Domsch wrote:
> On Thu, Dec 30, 2004 at 07:45:22PM +0100, Andi Kleen wrote:
> > i386 also has a different (but Intel specific fix) - uses either
> > 0xf or 0xff based on the APIC version. Just dropping it seems
> > better to me though. I suppose Matt (cc'ed) who apparently
> > wrote this code originally used it to work around some BIOS
> > bug, and at least we can hope for now that there are no 
> > EM64T boxes with that particular BIOS bug.
> 
> The MPC spec (I don't have a copy handy anymore) said it's the OS's
> job to program the APIC ID into the processor based on what BIOS put
> in the MP Table for it.  At the time I wrote the patch, the kernel
> didn't do this, so now it does, else all CPUs could wind up with the
> same APIC ID, which messed up interrupt routing IIRC.

Sorry, you lost me. The code my patch removes just checks if the
APIC ID in the mptable looks legal (is within the expected range)
while doing the ID renaming. I didnt remove the full ID renaming
code, just the sanity check.

I suppose this was added because there was some BIOS that put
junk into its mptable and this check caught it, right?
Do you still remember why it was added?

The problem is that the expected range is too small.

-Andi
