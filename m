Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265069AbTHBTpx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 15:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265531AbTHBTpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 15:45:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:59833 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265069AbTHBTpv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 15:45:51 -0400
Date: Sat, 2 Aug 2003 12:46:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [1/2] random: SMP locking
Message-Id: <20030802124647.62ad775f.akpm@osdl.org>
In-Reply-To: <20030802193306.GK22824@waste.org>
References: <20030802042445.GD22824@waste.org>
	<20030802040015.0fcafda2.akpm@osdl.org>
	<20030802143222.GG22824@waste.org>
	<20030802120023.7390f68f.akpm@osdl.org>
	<20030802193306.GK22824@waste.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:
>
> +		spin_lock(&random_state->lock);
>  +		ent_count = random_state->entropy_count;
>  +		memcpy(tmp, random_state->pool, size * sizeof(__u32));
>  +		spin_unlock(&random_state->lock);
>  +

This needs to be spin_lock_irqsave().

>  +		if (!copy_to_user(p, tmp, size * sizeof(__u32))) {
>  +			kfree(tmp);
>  +			goto fail;
>  +		}
>  +
>  +		kfree(tmp);
>  +
>  +		if(put_user(ent_count, p++))
>  +			goto fail;
>  +
>   		return 0;
>  +	fail:
>  +		spin_unlock(&random_state->lock);

Double unlock ;)
