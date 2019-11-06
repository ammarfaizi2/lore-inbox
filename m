Return-Path: <SRS0=PUae=Y6=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254C4C5DF62
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 08:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBEB9217F4
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 08:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zk3iomBm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfKFI5X (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 6 Nov 2019 03:57:23 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:32884 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfKFI5X (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 6 Nov 2019 03:57:23 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA68sGtL078363;
        Wed, 6 Nov 2019 08:57:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=gmnid+hdT1s07JCeYdtAkYWiqv3dMar9XcNgp1zmJQE=;
 b=Zk3iomBm/KYLIP4JiNvBSEw4WRPDyyc7o568HPTLtPtTlgr3Ij+6JPQVoqNjtem25rW1
 TK+Cgqnw6H5ShxNWPmF+LiI5DF7Y0odpCwrKsbEcFYRLqzfhcw98qslAigyeD9L9JG+K
 siJmzM7ELzgdCT8UF/kmd3pl4xCihKUAjP3E3PzfuMfCreAI2nTWJ+Lqlr5fpjnvQT6s
 L5013jzx9wvfUe/lOGfcZ0LMcfaKOxhnBPHCMDeZjqmfq8g3JJQziPRvl2GihrYbYYSq
 oN6LMimId63U4snG/yVzKOytoP826Q2JX62Kfayc0jbE7ToHKA+auu1K4w4+T8wNPwlk xw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2w12erc7t2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Nov 2019 08:57:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA68rPB0137234;
        Wed, 6 Nov 2019 08:57:19 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2w333wwv87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Nov 2019 08:57:19 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA68vHJ3005299;
        Wed, 6 Nov 2019 08:57:17 GMT
Received: from [192.168.1.14] (/114.88.246.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 Nov 2019 00:57:17 -0800
Subject: Re: [PATCH v2 1/2] io_uring: Merge io_submit_sqes and io_ring_submit
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1572988512.git.asml.silence@gmail.com>
 <09fcce1a50f4d1a399b903e3669ba98ede408d9c.1572988512.git.asml.silence@gmail.com>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <4654948b-caac-3dc8-904c-ceb0c245d7c3@oracle.com>
Date:   Wed, 6 Nov 2019 16:57:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <09fcce1a50f4d1a399b903e3669ba98ede408d9c.1572988512.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9432 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911060093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9432 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911060093
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/6/19 5:22 AM, Pavel Begunkov wrote:
> io_submit_sqes() and io_ring_submit() are doing the same stuff with
> a little difference. Deduplicate them.
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  fs/io_uring.c | 88 +++++++++++----------------------------------------
>  1 file changed, 18 insertions(+), 70 deletions(-)
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 7813bc7d5b61..ebe2a4edd644 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -2681,7 +2681,8 @@ static bool io_get_sqring(struct io_ring_ctx *ctx, struct sqe_submit *s)
>  }
>  
>  static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
> -			  struct mm_struct **mm)
> +			  struct file *ring_file, int ring_fd,
> +			  struct mm_struct **mm, bool async)
>  {
>  	struct io_submit_state state, *statep = NULL;
>  	struct io_kiocb *link = NULL;
> @@ -2732,10 +2733,12 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
>  		}
>  
>  out:
> +		s.ring_file = ring_file;
> +		s.ring_fd = ring_fd;
>  		s.has_user = *mm != NULL;
> -		s.in_async = true;
> -		s.needs_fixed_file = true;
> -		trace_io_uring_submit_sqe(ctx, s.sqe->user_data, true, true);
> +		s.in_async = async;
> +		s.needs_fixed_file = async;
> +		trace_io_uring_submit_sqe(ctx, s.sqe->user_data, true, async);
>  		io_submit_sqe(ctx, &s, statep, &link);
>  		submitted++;
>  	}
> @@ -2745,6 +2748,9 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
>  	if (statep)
>  		io_submit_state_end(&state);
>  
> +	 /* Commit SQ ring head once we've consumed and submitted all SQEs */
> +	io_commit_sqring(ctx);
> +

Then don't need io_commit_sqring() in io_sq_thread any more?

Anyway, looks good to me.
Reviewed-by: Bob Liu <bob.liu@oracle.com>

>  	return submitted;
>  }
>  
> @@ -2849,7 +2855,8 @@ static int io_sq_thread(void *data)
>  		}
>  
>  		to_submit = min(to_submit, ctx->sq_entries);
> -		inflight += io_submit_sqes(ctx, to_submit, &cur_mm);
> +		inflight += io_submit_sqes(ctx, to_submit, NULL, -1, &cur_mm,
> +					   true);
>  
>  		/* Commit SQ ring head once we've consumed all SQEs */
>  		io_commit_sqring(ctx);
> @@ -2866,69 +2873,6 @@ static int io_sq_thread(void *data)
>  	return 0;
>  }
>  
> -static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit,
> -			  struct file *ring_file, int ring_fd)
> -{
> -	struct io_submit_state state, *statep = NULL;
> -	struct io_kiocb *link = NULL;
> -	struct io_kiocb *shadow_req = NULL;
> -	bool prev_was_link = false;
> -	int i, submit = 0;
> -
> -	if (to_submit > IO_PLUG_THRESHOLD) {
> -		io_submit_state_start(&state, ctx, to_submit);
> -		statep = &state;
> -	}
> -
> -	for (i = 0; i < to_submit; i++) {
> -		struct sqe_submit s;
> -
> -		if (!io_get_sqring(ctx, &s))
> -			break;
> -
> -		/*
> -		 * If previous wasn't linked and we have a linked command,
> -		 * that's the end of the chain. Submit the previous link.
> -		 */
> -		if (!prev_was_link && link) {
> -			io_queue_link_head(ctx, link, &link->submit, shadow_req);
> -			link = NULL;
> -			shadow_req = NULL;
> -		}
> -		prev_was_link = (s.sqe->flags & IOSQE_IO_LINK) != 0;
> -
> -		if (link && (s.sqe->flags & IOSQE_IO_DRAIN)) {
> -			if (!shadow_req) {
> -				shadow_req = io_get_req(ctx, NULL);
> -				if (unlikely(!shadow_req))
> -					goto out;
> -				shadow_req->flags |= (REQ_F_IO_DRAIN | REQ_F_SHADOW_DRAIN);
> -				refcount_dec(&shadow_req->refs);
> -			}
> -			shadow_req->sequence = s.sequence;
> -		}
> -
> -out:
> -		s.ring_file = ring_file;
> -		s.has_user = true;
> -		s.in_async = false;
> -		s.needs_fixed_file = false;
> -		s.ring_fd = ring_fd;
> -		submit++;
> -		trace_io_uring_submit_sqe(ctx, s.sqe->user_data, true, false);
> -		io_submit_sqe(ctx, &s, statep, &link);
> -	}
> -
> -	if (link)
> -		io_queue_link_head(ctx, link, &link->submit, shadow_req);
> -	if (statep)
> -		io_submit_state_end(statep);
> -
> -	io_commit_sqring(ctx);
> -
> -	return submit;
> -}
> -
>  struct io_wait_queue {
>  	struct wait_queue_entry wq;
>  	struct io_ring_ctx *ctx;
> @@ -4049,10 +3993,14 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
>  			wake_up(&ctx->sqo_wait);
>  		submitted = to_submit;
>  	} else if (to_submit) {
> -		to_submit = min(to_submit, ctx->sq_entries);
> +		struct mm_struct *cur_mm;
>  
> +		to_submit = min(to_submit, ctx->sq_entries);
>  		mutex_lock(&ctx->uring_lock);
> -		submitted = io_ring_submit(ctx, to_submit, f.file, fd);
> +		/* already have mm, so io_submit_sqes() won't try to grab it */
> +		cur_mm = ctx->sqo_mm;
> +		submitted = io_submit_sqes(ctx, to_submit, f.file, fd,
> +					   &cur_mm, false);
>  		mutex_unlock(&ctx->uring_lock);
>  	}
>  	if (flags & IORING_ENTER_GETEVENTS) {
> 

