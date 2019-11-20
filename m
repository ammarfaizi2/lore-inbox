Return-Path: <SRS0=jdTg=ZM=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3FAC432C0
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 10:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48DC52243E
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 10:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ignxTvr+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfKTKWM (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 20 Nov 2019 05:22:12 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:42446 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727645AbfKTKWL (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 20 Nov 2019 05:22:11 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAKADruI160817;
        Wed, 20 Nov 2019 10:22:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=Kvu7wddrgDPpHro8Mic4U6c2AEHoCYYpWxnO1hPG1ms=;
 b=ignxTvr+acp0aR38i6CJ8pgIC7oLCuW9s79dtRy+6nT7aBPNbrt0+MF82ko0uyv3ujRY
 /LLBGHk8JW2WBg0sVqSSM2xxP3lUZiR7puKChb8jRkshswTcMPbQIMhHPzJIoA3vQQG+
 bbtbgeZGFfTETOmqlDLb17adDrOO/GbMsvf0g5fxHdcah0bZ/Ce9R+0IHUOv/7yUEz38
 I0bKURp4yTgH9v0AOa01tZX1i6r8r3cdlPlfpEuPNkL2hoIJHR7Rf+qB3T+8reTNTanf
 iXgm2VUKw7PY2/uHIfk0+WEttuXr0mJ8YGHBH7A9Gcs6QBx5bxLbE0c5GFlrrM96a3yo Cw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2wa8htvmjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Nov 2019 10:22:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAKAJ8ba172246;
        Wed, 20 Nov 2019 10:22:06 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2wc0a01tcm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Nov 2019 10:22:06 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAKAM5H0027001;
        Wed, 20 Nov 2019 10:22:05 GMT
Received: from [192.168.1.14] (/114.88.246.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Nov 2019 02:22:05 -0800
Subject: Re: io_uring: io_fail_links() should only consider first linked
 timeout
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
References: <efca87b0-3b8a-9614-c4c7-a341a2882b58@kernel.dk>
 <b8b1c8cf-5120-c4b2-e74b-4d0545b7a1f8@gmail.com>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <9f43d496-5864-19ab-2084-75a097c96a61@oracle.com>
Date:   Wed, 20 Nov 2019 18:22:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <b8b1c8cf-5120-c4b2-e74b-4d0545b7a1f8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9446 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911200094
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9446 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911200094
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/20/19 4:44 PM, Pavel Begunkov wrote:
> On 11/20/2019 1:33 AM, Jens Axboe wrote:
>> We currently clear the linked timeout field if we cancel such a timeout,
>> but we should only attempt to cancel if it's the first one we see.
>> Others should simply be freed like other requests, as they haven't
>> been started yet.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> ---
>>
>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>> index a79ef43367b1..d1085e4e8ae9 100644
>> --- a/fs/io_uring.c
>> +++ b/fs/io_uring.c
>> @@ -937,12 +937,12 @@ static void io_fail_links(struct io_kiocb *req)
>>  		if ((req->flags & REQ_F_LINK_TIMEOUT) &&
>>  		    link->submit.sqe->opcode == IORING_OP_LINK_TIMEOUT) {
>>  			io_link_cancel_timeout(link);
>> -			req->flags &= ~REQ_F_LINK_TIMEOUT;
>>  		} else {
>>  			io_cqring_fill_event(link, -ECANCELED);
>>  			__io_double_put_req(link);
>>  		}
>>  		kfree(sqe_to_free);
>> +		req->flags &= ~REQ_F_LINK_TIMEOUT;
> 
> That's not necessary, but maybe would safer to keep. If
> REQ_F_LINK_TIMEOUT is set, than there was a link timeout request,
> and for it and only for it io_link_cancel_timeout() will be called.
> 
> However, this is only true if linked timeout isn't fired. Otherwise,
> there is another bug, which isn't fixed by either of the patches. We
> need to clear REQ_F_LINK_TIMEOUT in io_link_timeout_fn() as well.
> 
> Let: REQ -> L_TIMEOUT1 -> L_TIMEOUT2
> 1. L_TIMEOUT1 fired before REQ is completed
> 
> 2. io_link_timeout_fn() removes L_TIMEOUT1 from the list:
> REQ|REQ_F_LINK_TIMEOUT -> L_TIMEOUT2
> 
> 3. free_req(REQ) then call io_link_cancel_timeout(L_TIMEOUT2)
> leaking it (as described in my patch).
> 
> P.S. haven't tried to test nor reproduce it yet.
> 

Off topic... I'm reading the code regarding IORING_OP_LINK_TIMEOUT.
But confused by what's going to happen if userspace submit a request with IORING_OP_LINK_TIMEOUT but not IOSQE_IO_LINK.
