Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268048AbUJGUik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268048AbUJGUik (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 16:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267958AbUJGUhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 16:37:48 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:18125 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S268048AbUJGUbs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 16:31:48 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: 2.6.9rc2-mm4 oops
Date: Thu, 7 Oct 2004 14:31:20 -0600
User-Agent: KMail/1.7
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, mingo@elte.hu,
       Len Brown <len.brown@intel.com>, acpi-devel@lists.sourceforge.net,
       Bernhard Rosenkraenzer <bero@arklinux.org>
References: <1096571653.11298.163.camel@cmn37.stanford.edu> <1096653158.7485.17.camel@cmn37.stanford.edu> <200410011633.10171.bjorn.helgaas@hp.com>
In-Reply-To: <200410011633.10171.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410071431.20400.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 October 2004 4:33 pm, Bjorn Helgaas wrote:
> On Friday 01 October 2004 11:52 am, Fernando Pablo Lopez-Lezcano wrote:
> > On Fri, 2004-10-01 at 08:04, Bjorn Helgaas wrote:
> > >  Also, can you look up the bad address
> > > (e.g., f8881920) in /proc/kallsyms? 
> > 
> > This is what I find:
> > f8880f80 ? __mod_vermagic5      [xor]
> > f8880fcd ? __module_depends     [xor]
> > f8881000 t acpi_button_init     [button]
> > f8881000 t init_module  [button]
> > f8884000 t xor_pII_mmx_2        [xor]
> > f8884130 t xor_pII_mmx_3        [xor]
> 
> You are remembering that /proc/kallsyms isn't sorted, right?
> 
> If you still can't match the address to anything interesting,
> can you see whether it's related to any of the other modules
> (i.e., see whether it happens even if you don't load any of
> the other ACPI drivers, or try leaving out any other drivers
> you can get along without)?  Maybe try loading an ACPI driver
> other than floppy, at the same point in the module load sequence,
> to see if the problem is specific to floppy, or if floppy is
> just an innocent bystander?
> 
> I looked at all the callers of acpi_bus_register_driver(), and
> they all look fine (except the hpet one I found yesterday).  But
> maybe there's something I missed, or maybe the acpi_bus_drivers
> list got corrupted somehow.
> 
> If you don't load the floppy driver, is the system stable?

Any update on all this?  I've tried to reproduce the problem on
my Athlon box, but so far I've been unsuccessful.
