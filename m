Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWKBWMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWKBWMu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 17:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751900AbWKBWMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 17:12:50 -0500
Received: from mx4.cs.washington.edu ([128.208.4.190]:6088 "EHLO
	mx4.cs.washington.edu") by vger.kernel.org with ESMTP
	id S1750768AbWKBWMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 17:12:49 -0500
Date: Thu, 2 Nov 2006 14:12:22 -0800 (PST)
From: David Rientjes <rientjes@cs.washington.edu>
To: muli@il.ibm.com
cc: ak@suse.de, linux-kernel@vger.kernel.org, discuss@x86-64.org,
       jdmason@kudzu.us
Subject: Re: [PATCH 1/4] Calgary: phb_shift can be int
In-Reply-To: <11625041802816-git-send-email-muli@il.ibm.com>
Message-ID: <Pine.LNX.4.64N.0611021401180.1797@attu4.cs.washington.edu>
References: <11625041803066-git-send-email-muli@il.ibm.com>
 <11625041802816-git-send-email-muli@il.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2006, muli@il.ibm.com wrote:

> diff --git a/arch/x86_64/kernel/pci-calgary.c b/arch/x86_64/kernel/pci-calgary.c
> index 37a7708..31d5758 100644
> --- a/arch/x86_64/kernel/pci-calgary.c
> +++ b/arch/x86_64/kernel/pci-calgary.c
> @@ -740,7 +740,7 @@ static void __init calgary_increase_spli
>  {
>  	u64 val64;
>  	void __iomem *target;
> -	unsigned long phb_shift = -1;
> +	unsigned int phb_shift = ~0; /* silence gcc */
>  	u64 mask;
>  
>  	switch (busno_to_phbid(busnum)) {
> 

There's been a suggestion to add

	#define SILENCE_GCC(x)	= x

for these silencing cases with the advantage that all the cases are marked 
for an easy grep and the purpose of such an initialization is known by 
the code reader.

		http://lkml.org/lkml/2006/10/31/106
