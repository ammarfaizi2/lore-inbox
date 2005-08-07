Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752632AbVHGThQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752632AbVHGThQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 15:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752635AbVHGThQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 15:37:16 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:61078 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1752632AbVHGThQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 15:37:16 -0400
Date: Sun, 7 Aug 2005 21:37:08 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Zachary Amsden <zach@vmware.com>
Cc: linux-kernel@vger.kernel.org, pratap@vmware.com
Subject: Re: [PATCH 1/1] i386 Encapsulate copying of pgd entries
Message-ID: <20050807193708.GA3100@elf.ucw.cz>
References: <200508060026.j760Q6FT025108@zach-dev.vmware.com> <20050807190017.GE1024@openzaurus.ucw.cz> <42F65EE0.4070205@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42F65EE0.4070205@vmware.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Since most hypervisors will likely provide a suspend/resume mechanism 
> that is external to the guest, most of this is a moot point anyways.  

Ok.

> But I wondered if you thought the pgd_clone() accessor would make this 
> cleaner or if it is just most confusing:
> 
> #ifdef CONFIG_SOFTWARE_SUSPEND
> /*
> * Swap suspend & friends need this for resume because things like the 
> intel-agp
> * driver might have split up a kernel 4MB mapping.
> */
> char __nosavedata swsusp_pg_dir[PAGE_SIZE]
>        __attribute__ ((aligned (PAGE_SIZE)));
> 
> static inline void save_pg_dir(void)
> {
>        memcpy(swsusp_pg_dir, swapper_pg_dir, PAGE_SIZE);  <--- could be 
> clone_pgd_range()
> }

Yep, clone_pgd_range would make sense here... 
								Pavel

-- 
if you have sharp zaurus hardware you don't need... you know my address
