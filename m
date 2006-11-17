Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162432AbWKQUeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162432AbWKQUeA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 15:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162431AbWKQUeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 15:34:00 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:61444 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S933633AbWKQUd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 15:33:59 -0500
Date: Fri, 17 Nov 2006 21:33:57 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@redhat.com>
Subject: Re: [-mm patch] remove drivers/pci/search.c:pci_find_device_reverse()
Message-ID: <20061117203357.GJ31879@stusta.de>
References: <20061114014125.dd315fff.akpm@osdl.org> <20061117142145.GX31879@stusta.de> <20061117115404.4bc87cf9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061117115404.4bc87cf9.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2006 at 11:54:04AM -0800, Andrew Morton wrote:
> On Fri, 17 Nov 2006 15:21:45 +0100
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > This patch removes the no longer used pci_find_device_reverse().
> 
> But it is exported to modules.
> 
> This is what we created EXPORT_UNUSED_SYMBOL() for.

The fact that noone uses it (except for the 8 symbols I marked in June) 
might be a good indication that it doesn't fit into the current kernel 
development model:
- there is no stable kernel API and
- we lack a strict process for reviewing _every single_ newly added
  export - especially the many that get added without any in-kernel user

And if you'd take your EXPORT_UNUSED_SYMBOL() serious, any changes to 
the signatures of exported functions had to be strictly forbidden.

Please do either make strong promises about the API for external modules 
with all consequences or allow all API changes immediately.

But you currently allowing API changes at any time while putting high 
obstacles for my cleanup patches to remove code with zero in-kernel 
users is very close to a personal offense.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

