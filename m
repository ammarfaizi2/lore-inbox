Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbVCAKs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbVCAKs1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 05:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbVCAKs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 05:48:27 -0500
Received: from gprs215-195.eurotel.cz ([160.218.215.195]:19167 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261857AbVCAKsV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 05:48:21 -0500
Date: Tue, 1 Mar 2005 11:48:10 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: Re: 2.6.11-rc4-mm1: something is wrong with swsusp powerdown
Message-ID: <20050301104810.GF1345@elf.ucw.cz>
References: <20050228231721.GA1326@elf.ucw.cz> <20050301020722.6faffb69.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050301020722.6faffb69.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> btw, suspend is a bit messy.  The disk spins down.  Then up.  Then down
> again.  And:

Yes, that's known, pm_message_t needs to become struct to solve disk
pingpong properly.

> Debug: sleeping function called from invalid context at mm/slab.c:2082
> in_atomic():0, irqs_disabled():1                                      
>  [<c010318d>] dump_stack+0x19/0x20
>  [<c0111731>] __might_sleep+0x91/0x9c
>  [<c01365df>] kmem_cache_alloc+0x23/0x84
>  [<c0232d50>] acpi_evaluate_integer+0x3c/0xac
>  [<c024b3d9>] acpi_bus_get_status+0x39/0x94  
>  [<c024ca99>] acpi_pci_link_set+0x16d/0x1e8
>  [<c024ce65>] acpi_pci_link_resume+0x1d/0x28
>  [<c024ce8a>] irqrouter_resume+0x1a/0x38    
>  [<c0281e3c>] sysdev_resume+0x2c/0xae   
>  [<c0285ea8>] device_power_up+0x8/0x11
>  [<c012a873>] swsusp_suspend+0x4b/0x58
>  [<c012ac35>] pm_suspend_disk+0x35/0x74
>  [<c01292ea>] enter_state+0x2e/0x70    
>  [<c0129336>] software_suspend+0xa/0x10
>  [<c024a8a7>] acpi_system_write_sleep+0x73/0x98
>  [<c0149f1b>] vfs_write+0xaf/0x118             
>  [<c014a028>] sys_write+0x3c/0x68 
>  [<c0102c05>] sysenter_past_esp+0x52/0x75

ACPI problem, patches are available (s/GFP_KERNEL/GFP_ATOMIC), but Len
claims better solution is ready... OTOH he claims that for half a year
already so we may push him a bit (added to cc). 

> Powering off system
> Debug: sleeping function called from invalid context at include/linux/rwsem.h:66
> in_atomic():0, irqs_disabled():1                                                
>  [<c010318d>] dump_stack+0x19/0x20
>  [<c0111731>] __might_sleep+0x91/0x9c
>  [<c0285872>] device_shutdown+0x16/0x82
>  [<c012aa97>] power_down+0x47/0x74     
>  [<c012ac5a>] pm_suspend_disk+0x5a/0x74
>  [<c01292ea>] enter_state+0x2e/0x70    
>  [<c0129336>] software_suspend+0xa/0x10
>  [<c024a8a7>] acpi_system_write_sleep+0x73/0x98
>  [<c0149f1b>] vfs_write+0xaf/0x118             
>  [<c014a028>] sys_write+0x3c/0x68 
>  [<c0102c05>] sysenter_past_esp+0x52/0x75

I'll look at this one.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
