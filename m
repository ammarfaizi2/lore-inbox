Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750978AbWAKGDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbWAKGDi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 01:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWAKGDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 01:03:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21184 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750978AbWAKGDh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 01:03:37 -0500
Date: Tue, 10 Jan 2006 22:03:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: cpw@sgi.com, linux-kernel@vger.kernel.org, clameter@sgi.com,
       lhms-devel@lists.sourceforge.net, taka@valinux.co.jp,
       kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: [PATCH 5/5] Direct Migration V9: Avoid writeback /
 page_migrate() method
Message-Id: <20060110220314.70e5793b.akpm@osdl.org>
In-Reply-To: <20060110224140.19138.84122.sendpatchset@schroedinger.engr.sgi.com>
References: <20060110224114.19138.10463.sendpatchset@schroedinger.engr.sgi.com>
	<20060110224140.19138.84122.sendpatchset@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> +	spin_lock(&mapping->private_lock);
>  +
>  +	bh = head;
>  +	do {
>  +		get_bh(bh);
>  +		lock_buffer(bh);
>  +		bh = bh->b_this_page;
>  +
>  +	} while (bh != head);
>  +

Guys, lock_buffer() sleeps and cannot be called inside spinlock.

Please, always enable kernel preemption and all debug options when testing
your code.
