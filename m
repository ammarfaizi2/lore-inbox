Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262045AbVCDKO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbVCDKO0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 05:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262594AbVCDKOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 05:14:25 -0500
Received: from fire.osdl.org ([65.172.181.4]:16337 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262045AbVCDKOV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 05:14:21 -0500
Date: Fri, 4 Mar 2005 02:13:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org, hugang@soulinfo.com
Subject: Re: swsusp: use non-contiguous memory on resume
Message-Id: <20050304021347.1b3e0122.akpm@osdl.org>
In-Reply-To: <20050304095934.GA1731@elf.ucw.cz>
References: <20050304095934.GA1731@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> Subject: non-contiguous pagedir for resume
> 
>  This fixes problem where we could have enough memory but not in
>  continuous chunk, and resume would fail.

It seems to do more that that?  What's all the assembly stuff?

General point: this changlog entry doesn't describe the problem and it
doesn't describe how the patch fixes that problem.  It's a model how-not-to ;)


>  --- linux-mm/kernel/power/swsusp.c	2005-02-28 01:14:08.000000000 +0100
>  +++ linux.middle/kernel/power/swsusp.c	2005-02-28 21:29:06.000000000 +0100
>  @@ -241,7 +241,7 @@
>   	swp_entry_t entry;
>   	int error = 0;
>   
>  -	entry = get_swap_page(NULL, swp_offset(*loc));
>  +	entry = get_swap_page();

Something's gone wrong here.  In -mm, get_swap_page() takes two args and in
-linus it takes zero args.

