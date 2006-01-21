Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbWAUGOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWAUGOU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 01:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbWAUGOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 01:14:19 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:41663 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750744AbWAUGOT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 01:14:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=q1M9EIZrDZVfP6JRB+vM8q55EFPLehgybz8MH2wQa7RkEwa6TGXCjbBOomYHVGtX6y25qlQBN6xe+kS4vh+dr7Zc+MFyXPZjIN7grZDqRLedw5PmCLUK5Fqt5ENKSnf8C49mE8Duss4Wk4YAazc487DnSt+8Hhqv5H3f2cz3S94=
Message-ID: <43D1D134.5070401@gmail.com>
Date: Sat, 21 Jan 2006 15:14:12 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Chuck Ebbert <76306.1226@compuserve.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mingming Cao <cmm@us.ibm.com>
Subject: Re: Fall back io scheduler for 2.6.15?
References: <200601141113_MC3-1-B5DA-F6EC@compuserve.com> <20060116084336.GO3945@suse.de>
In-Reply-To: <20060116084336.GO3945@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Sat, Jan 14 2006, Chuck Ebbert wrote:
> 
>>In-Reply-To: <20060113174914.7907bf2c.akpm@osdl.org>
>>
>>On Fri, 13 Jan 2006, Andrew Morton wrote:
>>
>>
>>>OK.  And I assume that AS wasn't compiled, so that's why it fell back?
>>
>>As of 2.6.15 you need to use "anticipatory" instead of "as".
>>
>>Maybe this patch would help?
>>
>>Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
>>
>>--- 2.6.15a.orig/block/elevator.c
>>+++ 2.6.15a/block/elevator.c
>>@@ -150,6 +150,13 @@ static void elevator_setup_default(void)
>> 	if (!chosen_elevator[0])
>> 		strcpy(chosen_elevator, CONFIG_DEFAULT_IOSCHED);
>> 
>>+	/*
>>+	 * Be backwards-compatible with previous kernels, so users
>>+	 * won't get the wrong elevator.
>>+	 */
>>+	if (!strcmp(chosen_elevator, "as"))
>>+		strcpy(chosen_elevator, "anticipatory");
>>+
>>  	/*
>>  	 * If the given scheduler is not available, fall back to no-op.
>>  	 */
> 
> 
> We probably should apply this, since it used to be 'as'.
> 

Just out of curiousity, why did 'as' get renamed to 'anticipatory'?

-- 
tejun
