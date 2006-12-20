Return-Path: <linux-kernel-owner+w=401wt.eu-S964976AbWLTLa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbWLTLa4 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 06:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964998AbWLTLa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 06:30:56 -0500
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:53891 "EHLO
	mtagate2.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964976AbWLTLaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 06:30:55 -0500
Date: Wed, 20 Dec 2006 13:30:52 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] x86_64: fix boot hang caused by CALGARY_IOMMU_ENABLED_BY_DEFAULT
Message-ID: <20061220113052.GA30145@rhun.ibm.com>
References: <20061220102846.GA17139@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061220102846.GA17139@elte.hu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2006 at 11:28:46AM +0100, Ingo Molnar wrote:

>  config CALGARY_IOMMU_ENABLED_BY_DEFAULT
>         bool "Should Calgary be enabled by default?"
>         default y
>         depends on CALGARY_IOMMU
>         help
>           Should Calgary be enabled by default? if you choose 'y', Calgary
>           will be used (if it exists). If you choose 'n', Calgary will not be
>           used even if it exists. If you choose 'n' and would like to use
>           Calgary anyway, pass 'iommu=calgary' on the kernel command line.
>           If unsure, say Y.
> 
> it's both 'default y', and says "If unsure, say Y". Clearly not a
> typo.

I think that it makes sense to have it default y for the mainline
kernel and default n for the distro kernels, which is why I added the
option to make it possible to compile Calgary in but only enable it if
you want to use it. Previously if you compiled it in it would be used,
period. You may disagree, but fundamentally I think the mainline
kernel should be fairly experimental, which means enabling new code by
default.

As to what actually happened, I'm betting your machine has both
Calgary and CalIOC2, the PCI-e version of Calgary, which is not yet
supported by pci-calgary.c. I have a patch for CalIOC2 which is work
in progress and not ready for inclusion yet. Can you please send lspci
-v to confirm?

Cheers,
Muli
