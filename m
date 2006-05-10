Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964900AbWEJKaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbWEJKaV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 06:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWEJKaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 06:30:21 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34721 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964900AbWEJKaT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 06:30:19 -0400
Subject: Re: [PATCH -mm] idetape gcc 4.1 warning fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <200605100255.k4A2twOE031688@dwalker1.mvista.com>
References: <200605100255.k4A2twOE031688@dwalker1.mvista.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Wed, 10 May 2006 11:42:18 +0100
Message-Id: <1147257738.17886.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-05-09 at 19:55 -0700, Daniel Walker wrote:
> Fixes the following warning,
> 
> drivers/ide/ide-tape.c: In function ‘idetape_copy_stage_from_user’:
> drivers/ide/ide-tape.c:2662: warning: ignoring return value of ‘copy_from_user’, declared with attribute warn_unused_result
> drivers/ide/ide-tape.c: In function ‘idetape_copy_stage_to_user’:

>  		count = min((unsigned int)(bh->b_size - atomic_read(&bh->b_count)), (unsigned int)n);
> -		copy_from_user(bh->b_data + atomic_read(&bh->b_count), buf, count);
> +		WARN_ON(copy_from_user(bh->b_data + atomic_read(&bh->b_count), buf, count));

So you want to let users spew all over the kernel log when a copy from
user fails. Either fix it properly or leave it alone. In this case its
actually quite hard to fix properly which is why it hasn't been done.

(POSIX doesn't require invalid addresses reliably report -EFAULT)

