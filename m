Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264279AbTCXQ6e>; Mon, 24 Mar 2003 11:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264321AbTCXQ6Y>; Mon, 24 Mar 2003 11:58:24 -0500
Received: from air-2.osdl.org ([65.172.181.6]:1170 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S264279AbTCXQ5s>;
	Mon, 24 Mar 2003 11:57:48 -0500
Message-ID: <33047.4.64.238.61.1048525736.squirrel@www.osdl.org>
Date: Mon, 24 Mar 2003 09:08:56 -0800 (PST)
Subject: Re: current BK boot failure, d_alloc()
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <axboe@suse.de>
In-Reply-To: <20030324120217.GB2371@suse.de>
References: <20030324115048.GA2371@suse.de>
        <20030324120217.GB2371@suse.de>
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Mar 24 2003, Jens Axboe wrote:
>> Hi,
>>
>>
[snip]
>> craps out in memcpy() due to name->name == NULL
>
> smells like a compiler problem, with the following patch:
>
> ===== fs/dcache.c 1.43 vs edited =====
> --- 1.43/fs/dcache.c	Sat Mar 22 05:05:21 2003
> +++ edited/fs/dcache.c	Mon Mar 24 12:58:19 2003
> @@ -784,7 +784,8 @@
>  	struct dentry *res = NULL;
>
>  	if (root_inode) {
> -		res = d_alloc(NULL, &(const struct qstr) { "/", 1, 0 });
> +		struct qstr name = { .name = "/", .len = 1, .hash = 0 };
> +		res = d_alloc(NULL, &name);
>  		if (res) {
>  			res->d_sb = root_inode->i_sb;
>  			res->d_parent = res;
>
> --

what compiler, please?

~Randy



