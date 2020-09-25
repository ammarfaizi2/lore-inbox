Return-Path: <SRS0=3fu8=DC=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9A6C4363D
	for <io-uring@archiver.kernel.org>; Fri, 25 Sep 2020 09:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D90262072E
	for <io-uring@archiver.kernel.org>; Fri, 25 Sep 2020 09:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgIYJTE (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 25 Sep 2020 05:19:04 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:36209 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726255AbgIYJTE (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 25 Sep 2020 05:19:04 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0UA0mBEs_1601025532;
Received: from B-25KNML85-0107.local(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0UA0mBEs_1601025532)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 25 Sep 2020 17:18:52 +0800
To:     axboe@kernel.dk
Cc:     io-uring@vger.kernel.org
From:   Hao_Xu <haoxu@linux.alibaba.com>
Subject: [Question] about async buffered reads feature
Message-ID: <a1bd6dfd-c911-dfe8-ec7f-4fac5ac8c73e@linux.alibaba.com>
Date:   Fri, 25 Sep 2020 17:18:52 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Hi Jens,
I'm doing tests about this feature: [PATCHSET RFC 0/11] Add support for 
async buffered reads
But currently with fio testing, I found the code doesn't go to the 
essential places in the function generic_file_buffered_read:

           if (iocb->ki_flags & IOCB_WAITQ) {
                   if (written) {
                           put_page(page);
                           goto out;
                   }
                   error = wait_on_page_locked_async(page,
                                                   iocb->ki_waitq);
           } else {

and

   page_not_up_to_date:
          /* Get exclusive access to the page ... */
          if (iocb->ki_flags & IOCB_WAITQ)
                  error = lock_page_async(page, iocb->ki_waitq);
          else


could you give me a copy of your test program which you mentioned in the 
RFC?
My testing environment:
fio version: 3.10
kernel version: the mainline kernel, latest commit is 
805c6d3c19210c90c109107d189744e960eae025


Thanks,
Hao

