Return-Path: <SRS0=cPsQ=ZA=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149B0C5DF60
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 09:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB8AB214DA
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 09:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gw+N37dd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbfKHJf3 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 8 Nov 2019 04:35:29 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:47134 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbfKHJf3 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 8 Nov 2019 04:35:29 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA89YI0G167544;
        Fri, 8 Nov 2019 09:35:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=Z1fGA8QSIYWW2NaFjBcHHqoOmN7BvHm2Rl4sSM+ZuRs=;
 b=Gw+N37ddQhnUaGKjo1djBzX0i14j+sjvEzUCf+CKmkJ0Qz9v9voKTe6VRreQR8nTC3oe
 W1HfQkPzqtz1qFE/GphxS0Y8lR0I0R1VEtlbCZOIwz+e38r/XdsrB7VjhjSx45wctHcI
 i0Tgi3donfROaKtkPuxAU4HTsU8SdG6ojbgLgHXd87ccfEJEjJQYAAEAGzzExKoTzhd5
 gjO0zjPj68unUXm4dU0iH6jZ9SECY+sPc2ytFvVZ4sSPvakwCINf944277hrWm2JM1j9
 yPXH23jPB1YCmxsOXMwe4ZKlMuinlxWK4khR02NnVjJ8EtGkT1cnX2a2FgxsWN2dVZZ8 lA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2w41w144u5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Nov 2019 09:35:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA89XU7n049841;
        Fri, 8 Nov 2019 09:35:22 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2w50m4pcpg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Nov 2019 09:35:22 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA89ZIqR004041;
        Fri, 8 Nov 2019 09:35:18 GMT
Received: from [192.168.1.14] (/114.88.246.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 Nov 2019 09:35:17 +0000
Subject: Re: [PATCH v2] io_uring: reduced function parameter ctx if possible
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
References: <1573198177-177651-1-git-send-email-liuyun01@kylinos.cn>
 <B1C5DE0A-336C-4A1E-850D-9CA90E5EB08E@kylinos.cn>
 <34c0b6a3-5bc8-8b83-dc96-e513e78bef03@oracle.com>
 <7B6E98CA-22DE-4AFA-94C3-D65395A1629C@kylinos.cn>
 <F31F44A3-5120-4432-863E-4740AA494D28@kylinos.cn>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <d7e625ae-4c9a-30a1-6f8d-2efd059d1e5f@oracle.com>
Date:   Fri, 8 Nov 2019 17:35:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <F31F44A3-5120-4432-863E-4740AA494D28@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9434 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=48 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=963
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911080093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9434 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=48 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911080093
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/8/19 5:24 PM, Jackie Liu wrote:
> 
>>
>>> 2019年11月8日 17:10，Bob Liu <bob.liu@oracle.com> 写道：
>>>
>>> On 11/8/19 5:00 PM, Jackie Liu wrote:
>>>> oops, please ignore this, it's crash with commit '2665abfd757fb35a241c6f0b1ebf620e3ffb36fb'
>>>> I need test more, and resend later.
>>>>
>>>
>>> Hmm.. io_link_cancel_timeout() may free req..
>>>
>>
>> Actually, there is no problem with this patch. It is caused by a patch that I
>> have not sent yet, I will send it after doing more tests.
>>
> 
> Sad. rejected by mailing list? 
> 
> @@ -714,9 +714,9 @@ static void __io_free_req(struct io_kiocb *req)
>         kmem_cache_free(req_cachep, req);
>  }
> 
> -static bool io_link_cancel_timeout(struct io_ring_ctx *ctx,
> -                                  struct io_kiocb *req)
> +static bool io_link_cancel_timeout(struct io_kiocb *req)
>  {
> +       struct io_ring_ctx *ctx = req->ctx;
>         int ret;
> 
>         ret = hrtimer_try_to_cancel(&req->timeout.timer);
> 
> I use req directly to convert to ctx, there is no crash problem here.
> 

Oh, I see.. Sorry for miss that..

> --
> BR, Jackie Liu
> 
> 
> 

