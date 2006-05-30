Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbWE3UlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbWE3UlV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 16:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbWE3UlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 16:41:21 -0400
Received: from andromeda.dapyr.net ([69.45.6.104]:12417 "EHLO
	andromeda.dapyr.net") by vger.kernel.org with ESMTP id S932409AbWE3UlV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 16:41:21 -0400
Date: Tue, 30 May 2006 16:41:12 -0400
From: konradr@us.ibm.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       arjan@linux.intel.com
Subject: Re: ThinkPad X60: PCI: BIOS Bug: MCFG area is not E820-reserved (MCFG is in ACPI NVS)
Message-ID: <20060530204112.GA22031@andromeda.dapyr.net>
References: <447C9F19.5000105@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447C9F19.5000105@goop.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2006 at 12:38:01PM -0700, Jeremy Fitzhardinge wrote:
> [snip]
>
> So the MCFG entry is in the ACPI NVS region of the E820 table.  Is this 
> bad? 

Not at all. The ACPI v3.0 specs mentions that:

"ACPI NVS Memory. This range of addresses is in use or reserve by
the system and must not be used by the operating system. This
range is required to be saved and restored across an NVS sleep."

In other words, it is similar to what Reserved is set to - except the
Non-Volatile Sleep area can be used when S4 save/restore occurs.

> The code in arch/i386/pci/mmconfig.c only checks for MCFG being in 
> an E820_RESERVED area.  Should it also check for E820_NVS?

IMHO, based on the PCI 3.0 spec, the whole check should be removed - 
as the MCFG memory region does not have to be reserved in E820 table.

