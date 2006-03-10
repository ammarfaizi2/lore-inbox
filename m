Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbWCJEM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbWCJEM5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 23:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWCJEM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 23:12:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38020 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932298AbWCJEM5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 23:12:57 -0500
Date: Thu, 9 Mar 2006 20:10:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Sam Vilain <sam@vilain.net>
Cc: hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Write the inode itself in block_fsync()
Message-Id: <20060309201053.682868db.akpm@osdl.org>
In-Reply-To: <4410D0F1.3030307@vilain.net>
References: <87bqwfzixu.fsf@duaron.myhome.or.jp>
	<4410D0F1.3030307@vilain.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Vilain <sam@vilain.net> wrote:
>
> OGAWA Hirofumi wrote:
> 
>  >Hi,
>  >
>  >For block device's inode, we don't write a inode's meta data
>  >itself. But, I think we should write inode's meta data for fsync().
>  >  
>  >
> 
>  Ouch... won't that halve performance of database transaction logs?

Yes, it could well cause a lot more seeking to do atime and/or mtime
writes.   Which aren't terribly important, really.

Unless I'm missing something, I suspect we'd be better off without this,
even though it's a correctness fix :(
