Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbVFDBdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVFDBdQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 21:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVFDBdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 21:33:15 -0400
Received: from umbar.esa.informatik.tu-darmstadt.de ([130.83.163.30]:51328
	"EHLO umbar.esa.informatik.tu-darmstadt.de") by vger.kernel.org
	with ESMTP id S261216AbVFDBdM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 21:33:12 -0400
Date: Sat, 4 Jun 2005 03:33:11 +0200
From: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: PROBLEM: Devices behind PCI Express-to-PCI bridge not mapped
Message-ID: <20050604013311.GA30151@erebor.esa.informatik.tu-darmstadt.de>
References: <20050603232828.GA29860@erebor.esa.informatik.tu-darmstadt.de> <Pine.LNX.4.58.0506031706450.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506031706450.1876@ppc970.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2005 at 05:22:57PM -0700, Linus Torvalds wrote:
> Hmm.. Just a wild guess (and this may not work at _all_, so who knows..): 
> how about adding a
> 
> 	pci_assign_unassigned_resources();
> 
> call to the end of "pcibios_init()" in arch/i386/pci/common.c ?

As you suspected, it wasn't a panacea: The kernel now panics, with a
call chain of

	...
	pcibios_init()
	pci_assign_unassigned_resources()
	pci_bus_assign_resources()
	pci_setup_bridge()

I can collect more specific info if necessary.

Thanks for looking into this,
  Andreas Koch
