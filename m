Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266158AbUANDKt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 22:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266207AbUANDKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 22:10:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:38570 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265965AbUANDKp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 22:10:45 -0500
Date: Tue, 13 Jan 2004 19:10:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matt Tolentino <metolent@snoqualmie.dp.intel.com>
Cc: davidm@napali.hpl.hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, matthew.e.tolentino@intel.com
Subject: Re: [patch] efivars update for 2.6.1
Message-Id: <20040113191015.20415de3.akpm@osdl.org>
In-Reply-To: <200401131824.i0DIOMcA031105@snoqualmie.dp.intel.com>
References: <200401131824.i0DIOMcA031105@snoqualmie.dp.intel.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Tolentino <metolent@snoqualmie.dp.intel.com> wrote:
>
> Andrew, David:
> 
> Here's a patch that has been posted here before, but not yet
> merged.

Big, isn't it?

> Essentially, it converts efivars (i.e. Matt Domsch's 
> driver that provides access to the EFI variable runtime 
> services) to export variable information and systab info via 
> sysfs.

I'd need confirmation from David M-T and if poss a quick review from Greg K-H.

>From a super-quick scan:

- Someone seems to have mangled the files with an editor which doesn't
  understand hard tabs.

- This function:

	> +static void __exit
	> +efivars_exit(void)
	> +{
	> +	struct list_head *pos, *n;
	> +
	> +        spin_lock(&efivars_lock);
	> +
	> +	list_for_each_safe(pos, n, &efivar_list)
	> +		efivar_unregister(get_efivar_entry(pos));
	> +
	> +	spin_unlock(&efivars_lock);
	> +
	> +	subsystem_unregister(&vars_subsys);
	> +	firmware_unregister(&efi_subsys);
	> +}

  cannot call efivar_unregister() under spinlock - it does all sorts of
  illegal-under-spinlock things.


