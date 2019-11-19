Return-Path: <SRS0=5OhC=ZL=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5D8C432C0
	for <io-uring@archiver.kernel.org>; Tue, 19 Nov 2019 09:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA5220721
	for <io-uring@archiver.kernel.org>; Tue, 19 Nov 2019 09:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rXgKMT3l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfKSJYA (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 19 Nov 2019 04:24:00 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:38016 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfKSJYA (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 19 Nov 2019 04:24:00 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ9IuqF103802;
        Tue, 19 Nov 2019 09:23:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=8b0Ms9L3yY7j2DzCWj5q1LJzhCYKxhoDlv6h5Vnxdlg=;
 b=rXgKMT3lXlCJcSqthnva/PycguSs8dVW7q6hV64S43rxDFBQQqalNB8uNPJUyB/I3bye
 OfP5L3ayM4g7yYN8GV+HH1eT/dmeBH6wrZhg+oeEimgFqhWAiM9Ft7J2ns1CRY+MZ1Rj
 1eXCcsZcuBUUi7yy80HR1/fCabj+xeBT6gysgxf4vpecYv/E1zO3UuSsSL73cxZzHVly
 gNGdZ8V+OLOOYEise6rzPsmeeSOCrDnhXex559oIw0ax3bc+G28aUiGZFq0O6G02hCov
 o4daTfRkBH5SotKXP+aiPELVhpE0ACrapkIwGRowWEnChd4IzWAP2LCOuEGGQDkD7gNS eg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2wa92png4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 09:23:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ9NuxE072151;
        Tue, 19 Nov 2019 09:23:56 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2wc09x2qtp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 09:23:55 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAJ9N5iZ001838;
        Tue, 19 Nov 2019 09:23:05 GMT
Received: from [192.168.1.14] (/114.88.246.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Nov 2019 01:23:05 -0800
Subject: Re: [PATCH v2] io_uring: provide fallback request for OOM situations
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
References: <55798841-7303-525c-fe38-c3fb4fc47a65@kernel.dk>
 <d86e30fb-6c33-a9cf-40bf-28a0350eef52@oracle.com>
 <8fe5df76-d89b-5792-8f2f-8e1ccf74a4ba@kernel.dk>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <04b76a73-8162-7f2d-f9db-a6920dc009b4@oracle.com>
Date:   Tue, 19 Nov 2019 17:22:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <8fe5df76-d89b-5792-8f2f-8e1ccf74a4ba@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911190089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911190088
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/18/19 10:32 PM, Jens Axboe wrote:
> On 11/17/19 11:57 PM, Bob Liu wrote:
>> On 11/9/19 5:25 AM, Jens Axboe wrote:
>>> One thing that really sucks for userspace APIs is if the kernel passes
>>> back -ENOMEM/-EAGAIN for resource shortages. The application really has
>>> no idea of what to do in those cases. Should it try and reap
>>> completions? Probably a good idea. Will it solve the issue? Who knows.
>>>
>>> This patch adds a simple fallback mechanism if we fail to allocate
>>> memory for a request. If we fail allocating memory from the slab for a
>>> request, we punt to a pre-allocated request. There's just one of these
>>> per io_ring_ctx, but the important part is if we ever return -EBUSY to
>>> the application, the applications knows that it can wait for events and
>>> make forward progress when events have completed. This is the important
>>> part.
>>>
>>
>> I'm lost how -EBUSY will be returned if allocating from the pre-allocated request.
>> Could you please explain a bit more?
> 
> The patch actually returns -EAGAIN, not -EBUSY... The last -EBUSY
> mention in that commit message should be -EAGAIN.
> 
> But the point is that if you get a busy return back, then you know that
> things are moving forward as we have a backup request. This is a similar
> concept to the mempools we have in the kernel, have any kind of reserve
> guarantees forward progress.
> 

I see.
But there are two more potential place may fail to allocate memory,
'shadow_req = io_get_req()' and 'sqe_copy = kmalloc()'.

We may need one more pre-allocated request and make sure pre-allocated req can't be deferred?
So as to guarantee things can really moving forward.
