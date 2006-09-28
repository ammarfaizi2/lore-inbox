Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbWI1X00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbWI1X00 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 19:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbWI1X0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 19:26:25 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:21774 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1750849AbWI1X0Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 19:26:24 -0400
Date: Thu, 28 Sep 2006 19:22:06 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org, mj@atrey.karlin.mff.cuni.cz,
       davej@redhat.com
Subject: Re: [PATCH] x86: update vmlinux.lds.S to place .data section on a page boundary
Message-ID: <20060928232206.GA11386@hmsreliant.homelinux.net>
References: <20060928201249.GA10037@hmsreliant.homelinux.net> <20060928204220.GA31096@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060928204220.GA31096@uranus.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2006 at 10:42:20PM +0200, Sam Ravnborg wrote:
> On Thu, Sep 28, 2006 at 04:12:49PM -0400, Neil Horman wrote:
> > Patch to update vmlinux linker script so that .data section is on a page
> > boundary.  without this change the kernel's .data section is on a non-4k
> > boundary, and this prevents kexec from loading a new kernel.  Tested
> > successfully by me.
> NAK
> 
> > +  . = ALIGN(4096);
> 
> Do not use magic numbers like this.
> Please replace 4096 with PAGE_SIZE - page.h is already included so it is
> available.
> This servers two purposes:
> 1) This make it more self documenting
> 2) It makes it more portable should we decide to do this in a general
> way for all arch's.
> 
I'm happy to do this if that is the consensus, but if you look at the rest of
the file, I'm simply following the standard that is currently in the file.  Are
you sure you want me to go and revamp that through the entire script?

> And then maybe a comment why it is desireable to waste a lot of RAM
> in some cases. For the embedded people wasting up to 4088 bytes
> of RAM is not desireable.
> 
Again, its the standard of the script.  All other sections are page aligned (or
rather were).  some recent changes have added a section data (a __tracedata
section I think), which is 4 byte aligned, which shifted the subsequent section
to be 4 byte aligned (the following note section as described in the PHDRS
section is prefixed with a simmilar ALIGN macro to bring it back into page
alignment.

Again, I'll repost with the adjustments you request, but first I'd like you please to
look at the file and make sure thats best.  Currently, I'm more comfortable with
the above, as it reflects the current standard of the script.

Regards
Neil

> 
> 	Sam

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *gpg keyid: 1024D / 0x92A74FA1 - http://pgp.mit.edu
 ***************************************************/
