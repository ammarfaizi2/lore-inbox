Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272540AbRH3XCO>; Thu, 30 Aug 2001 19:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272541AbRH3XCE>; Thu, 30 Aug 2001 19:02:04 -0400
Received: from smtp.mailbox.co.uk ([195.82.125.32]:13781 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S272540AbRH3XB6>; Thu, 30 Aug 2001 19:01:58 -0400
Date: Thu, 30 Aug 2001 23:25:51 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Paul Larson <plars@austin.ibm.com>
Cc: Frank Davis <fdavis@si.rr.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.9-ac4: undefined reference pgtable_cache_init
Message-ID: <20010830232551.J1149@flint.arm.linux.org.uk>
In-Reply-To: <3B8E6467.1030204@si.rr.com> <20010830172612.F1149@flint.arm.linux.org.uk> <999184657.9362.32.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <999184657.9362.32.camel@plars.austin.ibm.com>; from plars@austin.ibm.com on Thu, Aug 30, 2001 at 03:17:36PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2001 at 03:17:36PM +0000, Paul Larson wrote:
> I've seen this as well on i386.  It crops up when you are using HIGHMEM.
> In include/asm-i386/pgtable.h you declare pgtable_cache_init if HIGHMEM
> is on, or define it to the empty while loop if not.  It really needs to
> be calling init_pae_pgd_cache instead though.  Try this patch against
> 2.4.9-ac4.  I don't know if changing the name of init_pae_pgd_cache was
> the Right Thing (tm) to do, but it worked for me.  It's not getting
> called anywhere else anyways.

It got changed because we don't want to add multiple architecture
specific functions to init/main.c, but rather have one generic call
which any architecture can use for this type of thing.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

