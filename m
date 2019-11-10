Return-Path: <SRS0=ex/T=ZC=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA05BC43331
	for <io-uring@archiver.kernel.org>; Sun, 10 Nov 2019 23:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FDDF206C3
	for <io-uring@archiver.kernel.org>; Sun, 10 Nov 2019 23:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r5cwsYNG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfKJXop (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sun, 10 Nov 2019 18:44:45 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:59532 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbfKJXop (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sun, 10 Nov 2019 18:44:45 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAANhrva029108;
        Sun, 10 Nov 2019 23:44:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=xOhZfz8M1WBdEAziaeJhEk1IzBG3T0fLV6ROkm5V6gU=;
 b=r5cwsYNGyps080o4VGBiIVgHqUVboU9/YEv3dJmqJdAH8dMbJVgq6OKzAzopJ9tkt2kM
 24chPyAsVnb8NqrA/+SB2rrnqfCVQLpV7EIbZ468m6LgXZUWA+PoEcL7CYXD8u7CuqSE
 nl0oLeNWittJqMm5p4G6c6oFK7n7iPM9tDIxKOcOTZSL0eQc6clJGrj0MUU9sDbSlVjn
 BSYzD4GgDxGJ4aSvkzUJ+Fwj4HwEDTuQV0lQ97At6EubYJ3uWbO2HI8joSf67PlEKcQO
 2X5e/124fCBM+1YFCl0r034YGwT3hOlxWBAizZveY6aJX0rB7jQJ5DPhEJkEtwEej2s3 CQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2w5p3qbvuq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Nov 2019 23:44:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAANhlIX078359;
        Sun, 10 Nov 2019 23:44:41 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2w66wj8s48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Nov 2019 23:44:41 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAANibxJ001795;
        Sun, 10 Nov 2019 23:44:37 GMT
Received: from [192.168.1.14] (/114.88.246.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 10 Nov 2019 15:44:37 -0800
Subject: Re: [PATCH] io_uring: fix error clear of ->file_table in
 io_sqe_files_register()
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
References: <9851837d-47f3-abfe-8c19-f518e0935b22@kernel.dk>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <e2309d10-73bf-0af3-5687-b701d6d6cb3a@oracle.com>
Date:   Mon, 11 Nov 2019 07:44:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <9851837d-47f3-abfe-8c19-f518e0935b22@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9437 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911100236
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9437 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911100236
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/10/19 11:46 PM, Jens Axboe wrote:
> syzbot reports that when using failslab and friends, we can get a double
> free in io_sqe_files_unregister():
> 
> BUG: KASAN: double-free or invalid-free in
> io_sqe_files_unregister+0x20b/0x300 fs/io_uring.c:3185
> 
> CPU: 1 PID: 8819 Comm: syz-executor452 Not tainted 5.4.0-rc6-next-20191108
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x197/0x210 lib/dump_stack.c:118
>   print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
>   kasan_report_invalid_free+0x65/0xa0 mm/kasan/report.c:468
>   __kasan_slab_free+0x13a/0x150 mm/kasan/common.c:450
>   kasan_slab_free+0xe/0x10 mm/kasan/common.c:480
>   __cache_free mm/slab.c:3426 [inline]
>   kfree+0x10a/0x2c0 mm/slab.c:3757
>   io_sqe_files_unregister+0x20b/0x300 fs/io_uring.c:3185
>   io_ring_ctx_free fs/io_uring.c:3998 [inline]
>   io_ring_ctx_wait_and_kill+0x348/0x700 fs/io_uring.c:4060
>   io_uring_release+0x42/0x50 fs/io_uring.c:4068
>   __fput+0x2ff/0x890 fs/file_table.c:280
>   ____fput+0x16/0x20 fs/file_table.c:313
>   task_work_run+0x145/0x1c0 kernel/task_work.c:113
>   exit_task_work include/linux/task_work.h:22 [inline]
>   do_exit+0x904/0x2e60 kernel/exit.c:817
>   do_group_exit+0x135/0x360 kernel/exit.c:921
>   __do_sys_exit_group kernel/exit.c:932 [inline]
>   __se_sys_exit_group kernel/exit.c:930 [inline]
>   __x64_sys_exit_group+0x44/0x50 kernel/exit.c:930
>   do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x43f2c8
> Code: 31 b8 c5 f7 ff ff 48 8b 5c 24 28 48 8b 6c 24 30 4c 8b 64 24 38 4c 8b
> 6c 24 40 4c 8b 74 24 48 4c 8b 7c 24 50 48 83 c4 58 c3 66 <0f> 1f 84 00 00
> 00 00 00 48 8d 35 59 ca 00 00 0f b6 d2 48 89 fb 48
> RSP: 002b:00007ffd5b976008 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000043f2c8
> RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
> RBP: 00000000004bf0a8 R08: 00000000000000e7 R09: ffffffffffffffd0
> R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000001
> R13: 00000000006d1180 R14: 0000000000000000 R15: 0000000000000000
> 
> This happens if we fail allocating the file tables. For that case we do
> free the file table correctly, but we forget to set it to NULL. This
> means that ring teardown will see it as being non-NULL, and attempt to
> free it again.
> 
> Fix this by clearing the file_table pointer if we free the table.
> 
> Reported-by: syzbot+3254bc44113ae1e331ee@syzkaller.appspotmail.com
> Fixes: 65e19f54d29c ("io_uring: support for larger fixed file sets")
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 

Reviewed-by: Bob Liu <bob.liu@oracle.com>

By the way, there are many place(besides io_uring.c) which need to set pointer to NULL after free.
I saw similar fix from time to time.

Do you think a safe_free() is worth? e.g
#define SAFE_FREE(p) { if (p) { free(p); (p)=NULL; } }

> ---
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 7fc3a72e1e1e..5c10b34ceb24 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -3488,6 +3488,7 @@ static int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
>  
>  	if (io_sqe_alloc_file_tables(ctx, nr_tables, nr_args)) {
>  		kfree(ctx->file_table);
> +		ctx->file_table = NULL;
>  		return -ENOMEM;
>  	}
>  
> 

