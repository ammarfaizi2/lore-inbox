Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbWCTH0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWCTH0h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 02:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbWCTH0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 02:26:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24499 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932187AbWCTH0g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 02:26:36 -0500
Date: Sun, 19 Mar 2006 23:23:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, jack@suse.cz, jesper.juhl@gmail.com
Subject: Re: [PATCH] fix potential null pointer deref in quota
Message-Id: <20060319232327.005c91e4.akpm@osdl.org>
In-Reply-To: <200603182308.05050.jesper.juhl@gmail.com>
References: <200603182308.05050.jesper.juhl@gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <jesper.juhl@gmail.com> wrote:
>
> The coverity checker noticed that we may pass a NULL super_block to
>  do_quotactl() that dereferences it.
>  Dereferencing NULL pointers is bad medicine, better check and fail 
>  gracefully.
> 
>  Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
>  ---
> 
>   fs/quota.c |    3 +++
>   1 files changed, 3 insertions(+)
> 
>  --- linux-2.6.16-rc6-orig/fs/quota.c	2006-03-12 14:19:02.000000000 +0100
>  +++ linux-2.6.16-rc6/fs/quota.c	2006-03-18 23:03:32.000000000 +0100
>  @@ -231,6 +231,9 @@ static int do_quotactl(struct super_bloc
>   {
>   	int ret;
>   
>  +	if (!sb)
>  +		return -ENODEV;
>  +
>   	switch (cmd) {
>   		case Q_QUOTAON: {
>   			char *pathname;

I'd have thought that check_quotactl_valid() would be the appropriate place
for this check.  Jan, can you please sort out what we need to do here?
