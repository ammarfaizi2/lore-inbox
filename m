Return-Path: <SRS0=cPsQ=ZA=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A01C43331
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 02:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72DD32084C
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 02:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xquxuHOW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfKHCMk (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 7 Nov 2019 21:12:40 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39417 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfKHCMk (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 7 Nov 2019 21:12:40 -0500
Received: by mail-pl1-f194.google.com with SMTP id o9so2964560plk.6
        for <io-uring@vger.kernel.org>; Thu, 07 Nov 2019 18:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3uN53Doe3jOnu0uX3awWlpMxfbd2hmw5TJnhaW7Ip2A=;
        b=xquxuHOWyXWrN8SZPD8zlvIMZt/5UL0xvhB1CVq/3PJzTWcMvQLQv412y+j0Pt9RD7
         VQGKXA4OhXM5Nus3QUVj7ElgRwVanq2Zg+FdutKvUDkKT5JovJIhgD2BX7FMWEw2a42k
         Xnw63ku0M1F5QdY+ikQruElvpN7U0bq995n8fixcsfnMbst7a1LpQu79FThU8upGyvw+
         Ig8j7B6Lqb//Ud7KUzE9Gv1fq4K4uG5GFqfk2X8/VGD9sa2TiBG6Vz5CBi4B74vbGxTZ
         gplxfBKppqPt6v3P38UHOd7O+9AOp4kzFiQUbSLiaPTjVJ9kIjmRHRf0HwkDTENmCNE6
         2hJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3uN53Doe3jOnu0uX3awWlpMxfbd2hmw5TJnhaW7Ip2A=;
        b=UsfT75KKhp5AhcUBqkRTCoHCn8/ZvjupV/8EhhnZ9XIolDov9XwxmK8TV/33rX6Og2
         7iUDdxIsL9RL46wjXo2jYa8mshxyJ4yfeLQ1mXToaKO4x3oIKg7YYkmwA1Nadrf/hI+N
         U2tHki4C5XF8/3BT5K/1iwA9hGimhzO0zM2Wz+y/8cYSzUJTmE/863WmPCp1X7DFR/vl
         zzghcdNAvOjr7aDTeWCqI0JNznaOtiS7BvqWXyvmpCpnk39iXj5GxBQgR4/PzbQWI4Xd
         HIFZQbZwaUliWByyqKYPsMVKxSCbJw3Zx7XwqWiD1HSaj6/B1TyHhZsEFJ5SCbREUllr
         tMNQ==
X-Gm-Message-State: APjAAAVnLxhmwLYpnt/YsSkrKva67NyZU1Nbl6ERZeReNeYlMbnzjdMg
        mKn60rZAZYS5DpLrvXrMaidY+1Xiue0=
X-Google-Smtp-Source: APXvYqy12vquYPenW403dAr2+LPZxCLKkng/eyv4o1kesAOvsVQMf2278uk8EhIC2cyGKcgEsZ4/8w==
X-Received: by 2002:a17:90a:bd10:: with SMTP id y16mr9367956pjr.111.1573179156813;
        Thu, 07 Nov 2019 18:12:36 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id o125sm3626429pfg.118.2019.11.07.18.12.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 18:12:35 -0800 (PST)
Subject: Re: [PATCH v2] io_uring: add support for linked SQE timeouts
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     io-uring@vger.kernel.org
References: <a7a32933-10fb-9c90-04ce-3f64ecad2421@kernel.dk>
 <C0C26DA7-DD02-46EE-A398-51A50962A724@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f5930ec1-d3b3-4cd9-0648-fa835b347318@kernel.dk>
Date:   Thu, 7 Nov 2019 19:12:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <C0C26DA7-DD02-46EE-A398-51A50962A724@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/7/19 6:24 PM, Jackie Liu wrote:
>> @@ -734,11 +755,23 @@ static void io_req_link_next(struct io_kiocb *req, struct io_kiocb **nxtptr)
>> 		 * If we're in async work, we can continue processing the chain
>> 		 * in this context instead of having to queue up new async work.
>> 		 */
>> -		if (nxtptr && current_work())
>> +		if (req->flags & REQ_F_LINK_TIMEOUT) {
>> +			wake_ev = io_link_cancel_timeout(ctx, nxt);
>> +
>> +			/* we dropped this link, get next */
>> +			nxt = list_first_entry_or_null(&req->link_list,
>> +							struct io_kiocb, list);
>> +		} else if (nxtptr && current_work()) {
>> 			*nxtptr = nxt;
>> -		else
>> +			nxt = NULL;
> 
> Use 'break' is more better? no need to set variables and compare.

Fine with me, I'll make that change. Happy with it otherwise?

-- 
Jens Axboe

