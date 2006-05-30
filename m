Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932507AbWE3VrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbWE3VrD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 17:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbWE3VrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 17:47:03 -0400
Received: from 207.47.60.150.static.nextweb.net ([207.47.60.150]:40054 "EHLO
	exch2.ad.xensource.com") by vger.kernel.org with ESMTP
	id S932504AbWE3VrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 17:47:01 -0400
Subject: Re: ThinkPad X60: PCI: BIOS Bug: MCFG area is not E820-reserved
	(MCFG is in ACPI NVS)
From: Jeremy Fitzhardinge <jeremy@xensource.com>
To: konradr@us.ibm.com
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       arjan@linux.intel.com, linux-acpi@vger.kernel.org
In-Reply-To: <20060530204112.GA22031@andromeda.dapyr.net>
References: <447C9F19.5000105@goop.org>
	 <20060530204112.GA22031@andromeda.dapyr.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 30 May 2006 14:47:01 -0700
Message-Id: <1149025621.25497.9.camel@jeremy.eng.hq.xensource.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-30 at 16:41 -0400, konradr@us.ibm.com wrote:
> On Tue, May 30, 2006 at 12:38:01PM -0700, Jeremy Fitzhardinge wrote:
> > [snip]
> >
> > So the MCFG entry is in the ACPI NVS region of the E820 table.  Is this 
> > bad? 
> 
> Not at all. The ACPI v3.0 specs mentions that:
> 
> "ACPI NVS Memory. This range of addresses is in use or reserve by
> the system and must not be used by the operating system. This
> range is required to be saved and restored across an NVS sleep."

I actually misread the tables.  It appears that MCFG (at 0x7f6e2e36) is
in ACPI Data (7f6d0000 - 7f6e3000).  include/asm-i386/e820.h says that
memory marked as "E820_ACPI" can be reused as normal memory once the
ACPI tables have been read.

Doesn't this mean that the MCFG memory could end up being used as
general system memory?  That seems bad if MCFG memory is some kind of
MMIO space.  Or is the comment simply wrong?

(I don't really know what this stuff is, so maybe I'm just pointlessly
worrying.)

	J
