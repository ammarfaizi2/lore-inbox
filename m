Return-Path: <SRS0=PUae=Y6=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77355C5DF64
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 08:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 462C12084D
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 08:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DxhRORQy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730332AbfKFIgw (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 6 Nov 2019 03:36:52 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:46656 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730309AbfKFIgv (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 6 Nov 2019 03:36:51 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA68YAfB076615;
        Wed, 6 Nov 2019 08:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=D85iPCOccaXXpYQjcfVQIEppy4zRU7ibsWJzGjixdSU=;
 b=DxhRORQyNQN0N4kz9aa9K/rUrMA5OwbKkyqZGxs6lIiCoqkStRtqtv54Rv5KPoDGuYyX
 tI0X9vjdAezUtRE0ubWjCwqK6w8rLwDXXiYQ0h++XrwfrfqGtY4Ptvt5BKmr3Sj4YbG7
 9juZqooukC9Qei/xuWGrG8AMHWikAQNhKODlQGg+HOMi/2E9+ferm03x18vf93YKpHXz
 xjnnG4WZDV8L4E7aGa7ATdK1c+fN1K4kVDzPJNnDKWZL9x+6KtuK2ONSAa3JjCZC+dsu
 mTmv2VStNa02KoWf1P2ll1v40+AHvpDLniuvR3nOvyeL8hIQThCLJfYpdsfhi2nXpE4G ng== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2w11rq49aj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Nov 2019 08:36:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA68T2JU107069;
        Wed, 6 Nov 2019 08:36:47 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2w3162yt4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Nov 2019 08:36:47 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA68ahcQ018973;
        Wed, 6 Nov 2019 08:36:44 GMT
Received: from [192.168.1.14] (/114.88.246.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 Nov 2019 00:36:43 -0800
Subject: Re: [PATCH v2 2/2] io_uring: io_queue_link*() right after submit
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1572988512.git.asml.silence@gmail.com>
 <85a316b577e1b5204d27a96a7ce452ed6be3c2ae.1572988512.git.asml.silence@gmail.com>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <8700c9a3-01aa-2af6-c275-1f17734c2cc5@oracle.com>
Date:   Wed, 6 Nov 2019 16:36:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <85a316b577e1b5204d27a96a7ce452ed6be3c2ae.1572988512.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9432 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911060089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9432 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911060090
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/6/19 5:22 AM, Pavel Begunkov wrote:
> After a call to io_submit_sqe(), it's already known whether it needs
> to queue a link or not. Do it there, as it's simplier and doesn't keep
> an extra variable across the loop.
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  fs/io_uring.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index ebe2a4edd644..82c2da99cb5c 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -2687,7 +2687,6 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
>  	struct io_submit_state state, *statep = NULL;
>  	struct io_kiocb *link = NULL;
>  	struct io_kiocb *shadow_req = NULL;
> -	bool prev_was_link = false;
>  	int i, submitted = 0;
>  	bool mm_fault = false;
>  
> @@ -2710,17 +2709,6 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
>  			}
>  		}
>  
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
>  		if (link && (s.sqe->flags & IOSQE_IO_DRAIN)) {
>  			if (!shadow_req) {
>  				shadow_req = io_get_req(ctx, NULL);
> @@ -2741,6 +2729,16 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
>  		trace_io_uring_submit_sqe(ctx, s.sqe->user_data, true, async);
>  		io_submit_sqe(ctx, &s, statep, &link);
>  		submitted++;
> +
> +		/*
> +		 * If previous wasn't linked and we have a linked command,
> +		 * that's the end of the chain. Submit the previous link.
> +		 */
> +		if (!(s.sqe->flags & IOSQE_IO_LINK) && link) 
The behavior changed to 'current seq' instead of previous after dropping prev_was_link?

> +			io_queue_link_head(ctx, link, &link->submit, shadow_req);
> +			link = NULL;
> +			shadow_req = NULL;
> +		}
>  	}
>  
>  	if (link)
> 

