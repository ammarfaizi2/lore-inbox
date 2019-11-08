Return-Path: <SRS0=cPsQ=ZA=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC9AFA372C
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 09:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB802178F
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 09:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbfKHJYQ convert rfc822-to-8bit (ORCPT
        <rfc822;io-uring@archiver.kernel.org>);
        Fri, 8 Nov 2019 04:24:16 -0500
Received: from smtpbgeu2.qq.com ([18.194.254.142]:45948 "EHLO smtpbgeu2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbfKHJYQ (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Fri, 8 Nov 2019 04:24:16 -0500
X-Greylist: delayed 31254 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Nov 2019 04:24:15 EST
X-QQ-mid: bizesmtp12t1573205050t3r8190l
Received: from [192.168.142.168] (unknown [218.76.23.26])
        by esmtp6.qq.com (ESMTP) with 
        id ; Fri, 08 Nov 2019 17:24:09 +0800 (CST)
X-QQ-SSF: 00400000002000T0ZU90000A0000000
X-QQ-FEAT: it8hfz5z0T3xqSvzpBS9UkMFa4fE1F5RiC1tASKPQzUDNlhPd6iVhrHdKIt3l
        BX0EkqgVhBKVlGi37bDtnQjg7cSv/BXc6LjYXfECAbgLeVMZCjkyKBEM1dZw4ldKEOtxm8T
        YZKeQvH4+Qgp9Z1fxJOfU+HjPVhOl8rw9OSiRQvsNL943q9per2/leulInXLFT13q6PAS74
        4TvsP5YDcbpPwCvvNfgJbya6zjAhZGguOCmiPYyKZbk8s5G0cifL8XiYxlpWeXUyxDubK+i
        F7WnTK5r3XSjXp8mBZ2vbo1klP5PbcJIp9uzVAiEmwm40ZbgNNKTxQUE8v5ZJClpNRaR/bi
        KjGlldqcC/dMkpaLWll4NtAbR1ab47wd/wornUl
X-QQ-GoodBg: 2
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH v2] io_uring: reduced function parameter ctx if possible
From:   Jackie Liu <liuyun01@kylinos.cn>
In-Reply-To: <7B6E98CA-22DE-4AFA-94C3-D65395A1629C@kylinos.cn>
Date:   Fri, 8 Nov 2019 17:24:10 +0800
Cc:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <F31F44A3-5120-4432-863E-4740AA494D28@kylinos.cn>
References: <1573198177-177651-1-git-send-email-liuyun01@kylinos.cn>
 <B1C5DE0A-336C-4A1E-850D-9CA90E5EB08E@kylinos.cn>
 <34c0b6a3-5bc8-8b83-dc96-e513e78bef03@oracle.com>
 <7B6E98CA-22DE-4AFA-94C3-D65395A1629C@kylinos.cn>
To:     Bob Liu <bob.liu@oracle.com>
X-Mailer: Apple Mail (2.3601.0.10)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org


> 
>> 2019年11月8日 17:10，Bob Liu <bob.liu@oracle.com> 写道：
>> 
>> On 11/8/19 5:00 PM, Jackie Liu wrote:
>>> oops, please ignore this, it's crash with commit '2665abfd757fb35a241c6f0b1ebf620e3ffb36fb'
>>> I need test more, and resend later.
>>> 
>> 
>> Hmm.. io_link_cancel_timeout() may free req..
>> 
> 
> Actually, there is no problem with this patch. It is caused by a patch that I
> have not sent yet, I will send it after doing more tests.
> 

Sad. rejected by mailing list? 

@@ -714,9 +714,9 @@ static void __io_free_req(struct io_kiocb *req)
        kmem_cache_free(req_cachep, req);
 }

-static bool io_link_cancel_timeout(struct io_ring_ctx *ctx,
-                                  struct io_kiocb *req)
+static bool io_link_cancel_timeout(struct io_kiocb *req)
 {
+       struct io_ring_ctx *ctx = req->ctx;
        int ret;

        ret = hrtimer_try_to_cancel(&req->timeout.timer);

I use req directly to convert to ctx, there is no crash problem here.

--
BR, Jackie Liu



