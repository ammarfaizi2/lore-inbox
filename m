Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270448AbTG1T0C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 15:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270452AbTG1T0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 15:26:01 -0400
Received: from fw.osdl.org ([65.172.181.6]:3501 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270448AbTG1T0A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 15:26:00 -0400
Date: Mon, 28 Jul 2003 12:14:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: <ffrederick@prov-liege.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]2.6 test1 mm2 user.c race (?)
Message-Id: <20030728121420.255ce643.akpm@osdl.org>
In-Reply-To: <200307281204.h6SC4soV001044@fire-1.osdl.org>
References: <200307281204.h6SC4soV001044@fire-1.osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<ffrederick@prov-liege.be> wrote:
>
> +	spin_lock(&uidhash_lock);
>  	uid_hash_insert(&root_user, uidhashentry(0));
> +	spin_unlock(&uidhash_lock);	

This code runs within an initcall, so it is very unlikely that anything
will race with us here.

But SMP is up, and this code gets dropped out of memory later (the
out-of-line spinlock code doesn't get dropped though).

So yes, I'd prefer that the locking be there, if only for documentary
purposes.  A /* comment */ which explains why the locking was omitted would
also be suitabe.

