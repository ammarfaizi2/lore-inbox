Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264270AbUEMPl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264270AbUEMPl4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 11:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264268AbUEMPlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 11:41:55 -0400
Received: from cantor.suse.de ([195.135.220.2]:21688 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264270AbUEMPlN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 11:41:13 -0400
Date: Thu, 13 May 2004 17:41:10 +0200
From: Andi Kleen <ak@suse.de>
To: Sean Neakums <sneakums@zork.net>
Cc: davej@redhat.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: i810 AGP fails to initialise (was Re: 2.6.6-mm2)
Message-Id: <20040513174110.5b397d84.ak@suse.de>
In-Reply-To: <6ulljwtoge.fsf@zork.zork.net>
References: <20040513032736.40651f8e.akpm@osdl.org>
	<6usme4v66s.fsf@zork.zork.net>
	<20040513135308.GA2622@redhat.com>
	<20040513155841.6022e7b0.ak@suse.de>
	<6ulljwtoge.fsf@zork.zork.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 May 2004 15:02:25 +0100
Sean Neakums <sneakums@zork.net> wrote:
> 
> 0000:00:00.0 Host bridge: Intel Corp. 82810E DC-133 GMCH [Graphics Memory Controller Hub] (rev 03)

I don't see what could be wrong. The PCI table has this PCI ID:

#define PCI_DEVICE_ID_INTEL_82810E_MC	0x7124

	...

	#define ID(x)						\
	{ 						\
	.class		= (PCI_CLASS_BRIDGE_HOST << 8),	\
	.class_mask	= ~0,				\
	.vendor		= PCI_VENDOR_ID_INTEL,		\
	.device		= x,				\
	.subvendor	= PCI_ANY_ID,			\
	.subdevice	= PCI_ANY_ID,			\
	}
	...
	ID(PCI_DEVICE_ID_INTEL_82810E_MC),

We also tested it on some other machines and it worked.

Does anyone else see a problem in the patches? 

Sean, can you double check that when you compile the AGP driver as module
that the 7124 PCI ID appears in modinfo intel-agp ? 
And does the module also refuse to load ? 


-Andi

