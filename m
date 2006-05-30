Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbWE3Xv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWE3Xv0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 19:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWE3Xv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 19:51:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:47248 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932230AbWE3XvZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 19:51:25 -0400
Date: Tue, 30 May 2006 16:48:38 -0700
From: Greg KH <greg@kroah.com>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Jeremy Fitzhardinge <jeremy@xensource.com>, konradr@us.ibm.com,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       arjan@linux.intel.com, linux-acpi@vger.kernel.org
Subject: Re: ThinkPad X60: PCI: BIOS Bug: MCFG area is not E820-reserved	(MCFG is in ACPI NVS)
Message-ID: <20060530234838.GA26478@kroah.com>
References: <447C9F19.5000105@goop.org> <20060530204112.GA22031@andromeda.dapyr.net> <1149025621.25497.9.camel@jeremy.eng.hq.xensource.com> <447CCFF2.30207@vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447CCFF2.30207@vc.cvut.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2006 at 01:06:26AM +0200, Petr Vandrovec wrote:
> Jeremy Fitzhardinge wrote:
> >On Tue, 2006-05-30 at 16:41 -0400, konradr@us.ibm.com wrote:
> >
> >>On Tue, May 30, 2006 at 12:38:01PM -0700, Jeremy Fitzhardinge wrote:
> >>
> >>>[snip]
> >>>
> >>>So the MCFG entry is in the ACPI NVS region of the E820 table.  Is this 
> >>>bad? 
> >>
> >>Not at all. The ACPI v3.0 specs mentions that:
> >>
> >>"ACPI NVS Memory. This range of addresses is in use or reserve by
> >>the system and must not be used by the operating system. This
> >>range is required to be saved and restored across an NVS sleep."
> >
> >
> >I actually misread the tables.  It appears that MCFG (at 0x7f6e2e36) is
> >in ACPI Data (7f6d0000 - 7f6e3000).  include/asm-i386/e820.h says that
> >memory marked as "E820_ACPI" can be reused as normal memory once the
> >ACPI tables have been read.
> >
> >Doesn't this mean that the MCFG memory could end up being used as
> >general system memory?  That seems bad if MCFG memory is some kind of
> >MMIO space.  Or is the comment simply wrong?
> 
> Address where MCFG table lives is not important.  What is important (and 
> checked) is address of MMCONFIG reported by MCFG table...  Unfortunately 
> code does not bother with printing that address :-(
> 
> Another problem is that code has hardcoded that MMCONFIG area is 256MB 
> large. Unfortunately for the code PCI specification allows any power of two 
> between 2MB and 256MB if vendor knows that such amount of busses (from 2 to 
> 128) will be sufficient for system.  With notebook it is quite possible 
> that not full 8 bits are implemented for MMCONFIG bus number.

Patches to address this are always welcome :)

thanks,

greg k-h
