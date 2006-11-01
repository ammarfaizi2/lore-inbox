Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992775AbWKATpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992775AbWKATpl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 14:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992776AbWKATpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 14:45:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:44673 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S2992775AbWKATpk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 14:45:40 -0500
Date: Wed, 1 Nov 2006 11:45:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH -mm] swsusp: Freeze filesystems during suspend (rev. 2)
Message-Id: <20061101114519.5a3fe193.akpm@osdl.org>
In-Reply-To: <200611011853.09633.rjw@sisk.pl>
References: <200611011200.18438.rjw@sisk.pl>
	<20061101114707.GA22079@atrey.karlin.mff.cuni.cz>
	<200611011853.09633.rjw@sisk.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2006 18:53:07 +0100
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> +void thaw_processes(void)
> +{
> +	printk("Restarting tasks ... ");
> +	__thaw_tasks(FREEZER_KERNEL_THREADS);
> +	thaw_filesystems();
> +	__thaw_tasks(FREEZER_USER_SPACE);
> +	schedule();
> +	printk("done.\n");
> +}
>  
> -	read_unlock(&tasklist_lock);
> +void thaw_kernel_threads(void)
> +{
> +	printk("Restarting kernel threads ... ");
> +	__thaw_tasks(FREEZER_KERNEL_THREADS);
>  	schedule();
>  	printk("done.\n");
>  }

what do these random-looking schedule()s do??
