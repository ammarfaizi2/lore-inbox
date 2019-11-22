Return-Path: <SRS0=nrYQ=ZO=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE9EC432C3
	for <io-uring@archiver.kernel.org>; Fri, 22 Nov 2019 06:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D606C2068F
	for <io-uring@archiver.kernel.org>; Fri, 22 Nov 2019 06:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HeOz17fG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfKVGLT (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:11:19 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:42048 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfKVGLS (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 22 Nov 2019 01:11:18 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAM6955Q098207;
        Fri, 22 Nov 2019 06:11:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=ZygRY/vGhsEEc6XD19TUQSlzY96sGPpLa3odngpElnY=;
 b=HeOz17fGPc+0sXoV9Ph2GXv1W+uCrraPQIBlHbM4rJRULybj/QQcdzTwvAEAeGHNio4G
 SWrd261hIoCMQ4AVSxjI7JQvRyrw8CLXvUkey+cQGiZbAtfGt65uU4COjp3XjdF8pf5F
 EDWcjPPZJSf5R4FvNFyLW2HASyXYxouY7edaD21OihuPDFfMEBIXvSNn2JRS3HjwFxPa
 rqrZG/CNqcBwPMkX+0IbCQ59TpkBVa01H9r/1uSkaO0erCmesJD54Ct0eFEdffJy3I8h
 sXQu4DS5prIC52BzRA/hyrC0s24dh1Nyz7HtmWLIBsug8WCitIKUdQWNoZFH/D6U1AwZ qA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2wa92q8jkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Nov 2019 06:11:11 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAM698LL167035;
        Fri, 22 Nov 2019 06:11:11 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2wda07bqpb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Nov 2019 06:11:10 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAM6B8FJ007098;
        Fri, 22 Nov 2019 06:11:08 GMT
Received: from [192.168.1.14] (/114.88.246.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Nov 2019 22:11:07 -0800
Subject: Re: [PATCH] io_uring: rename __io_submit_sqe()
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
References: <228a5ae5d63c61dd4f7349594012bfc7691028a7.1574360634.git.asml.silence@gmail.com>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <4af9f749-218e-b0a7-07cb-1aee65fdd999@oracle.com>
Date:   Fri, 22 Nov 2019 14:11:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <228a5ae5d63c61dd4f7349594012bfc7691028a7.1574360634.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9448 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911220053
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9448 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911220053
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/22/19 2:24 AM, Pavel Begunkov wrote:
> __io_submit_sqe() is issuing requests, so call it as
> such. Moreover, it ends by calling io_iopoll_req_issued().
> 
> Rename it and make terminology clearer.
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---

The new name is more straightforward.
Reviewed-by: Bob Liu <bob.liu@oralce.com>

>  fs/io_uring.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index dd220f415c39..fa1cf7263959 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -2579,8 +2579,8 @@ static int io_req_defer(struct io_kiocb *req)
>  	return -EIOCBQUEUED;
>  }
>  
> -static int __io_submit_sqe(struct io_kiocb *req, struct io_kiocb **nxt,
> -			   bool force_nonblock)
> +static int io_issue_sqe(struct io_kiocb *req, struct io_kiocb **nxt,
> +			bool force_nonblock)
>  {
>  	int ret, opcode;
>  	struct sqe_submit *s = &req->submit;
> @@ -2685,7 +2685,7 @@ static void io_wq_submit_work(struct io_wq_work **workptr)
>  		s->has_user = (work->flags & IO_WQ_WORK_HAS_MM) != 0;
>  		s->in_async = true;
>  		do {
> -			ret = __io_submit_sqe(req, &nxt, false);
> +			ret = io_issue_sqe(req, &nxt, false);
>  			/*
>  			 * We can get EAGAIN for polled IO even though we're
>  			 * forcing a sync submission from here, since we can't
> @@ -2896,7 +2896,7 @@ static void __io_queue_sqe(struct io_kiocb *req)
>  	struct io_kiocb *nxt = io_prep_linked_timeout(req);
>  	int ret;
>  
> -	ret = __io_submit_sqe(req, NULL, true);
> +	ret = io_issue_sqe(req, NULL, true);
>  
>  	/*
>  	 * We async punt it if the file wasn't marked NOWAIT, or if the file
> 

