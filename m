Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265922AbUAUFSm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 00:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265931AbUAUFSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 00:18:42 -0500
Received: from dp.samba.org ([66.70.73.150]:60032 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265922AbUAUFSk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 00:18:40 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: More cleanups for swsusp 
In-reply-to: Your message of "Tue, 20 Jan 2004 23:52:19 BST."
             <20040120225219.GA19190@elf.ucw.cz> 
Date: Wed, 21 Jan 2004 16:14:21 +1100
Message-Id: <20040121051855.B0C282C0A7@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040120225219.GA19190@elf.ucw.cz> you write:
> -	if (fill_suspend_header(&cur->sh))
> -		panic("\nOut of memory while writing header");
> +	BUG_ON (fill_suspend_header(&cur->sh));

1) fill_suspend_header never fails, perhaps make it return void.

2) If fill_suspend_header could fail, you should indicate why it won't
   fail here, and

3) BUG_ON(complex condition expression) is much less clear than:

	if (complex condition expression)
		BUG();

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
