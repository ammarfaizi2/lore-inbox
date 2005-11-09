Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161143AbVKITvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161143AbVKITvT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 14:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161141AbVKITvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 14:51:19 -0500
Received: from fmr23.intel.com ([143.183.121.15]:22439 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1161143AbVKITvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 14:51:18 -0500
Date: Wed, 9 Nov 2005 11:50:34 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Andi Kleen <ak@muc.de>
Cc: Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, gregkh@suse.de
Subject: Re: Changing MSI to use physical delivery mode always.
Message-ID: <20051109115033.A1461@unix-os.sc.intel.com>
References: <20051108070038.A15318@unix-os.sc.intel.com> <20051109135650.GA78272@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20051109135650.GA78272@muc.de>; from ak@muc.de on Wed, Nov 09, 2005 at 02:56:50PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2005 at 02:56:50PM +0100, Andi Kleen wrote:
> On Tue, Nov 08, 2005 at 07:00:38AM -0800, Ashok Raj wrote:
> > Hi,
> > 
> > MSI was hard coded to use logical delivery mode for i386/x86_64 and 
> > physical mode for ia64.
> > 
> > With recent x86_64 we moved to physical flat mode that broke MSI.
> > 
> > Made MSI to work with physical mode, this will be consistent on all
> > archs. 
> 
> Nasty bug. Thanks for tracking that down.
> 
> It is outright scary though that such deeply architecture specific
> code is in drivers/pci. It should be in arch. I think that was
> because I missed it. Would you be willing to move the APIC specific parts 
> to arch/i386/pci ? 

I remember when it got started it was in each arch, but there was so much
code duplication, and it ended with the header file pulling in 
some from asm/msi.h for arch pieces.

but moving to arch will help choose the same delivery mode consistently
and we could use physical or logical whatever ends up being used for 
IOAPIC rte's as well.

I will send a cleanup once things settle down.
