Return-Path: <linux-kernel-owner+w=401wt.eu-S932689AbWL1IzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932689AbWL1IzZ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 03:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932642AbWL1IzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 03:55:25 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:33261 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932689AbWL1IzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 03:55:25 -0500
Date: Thu, 28 Dec 2006 09:54:28 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Pavel Machek <pavel@ucw.cz>
cc: Amit Choudhary <amit2030@yahoo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [DISCUSS] Make the variable NULL after freeing it.
In-Reply-To: <20061227171010.GA4088@ucw.cz>
Message-ID: <Pine.LNX.4.61.0612280952450.15825@yvahk01.tjqt.qr>
References: <20061221234127.29189.qmail@web55606.mail.re4.yahoo.com>
 <20061227171010.GA4088@ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 27 2006 17:10, Pavel Machek wrote:

>> Was just wondering if the _var_ in kfree(_var_) could be set to
>> NULL after its freed. It may solve the problem of accessing some
>> freed memory as the kernel will crash since _var_ was set to NULL.
>> 
>> Does this make sense? If yes, then how about renaming kfree to
>> something else and providing a kfree macro that would do the
>> following:
>> 
>> #define kfree(x) do { \
>>                       new_kfree(x); \
>>                       x = NULL; \
>>                     } while(0)
>> 
>> There might be other better ways too.
>
>No, that would be very confusing. Otoh having
>KFREE() do kfree() and assignment might be acceptable.

What about setting x to some poison value from <linux/poison.h>?


	-`J'
-- 
