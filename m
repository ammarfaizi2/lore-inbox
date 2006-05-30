Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbWE3LWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWE3LWs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 07:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWE3LWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 07:22:48 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:91 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S932264AbWE3LWr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 07:22:47 -0400
Message-ID: <447C2AF3.6060200@de.ibm.com>
Date: Tue, 30 May 2006 13:22:27 +0200
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: Heiko Carstens <heiko.carstens@de.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] statistics infrastructure - update 1
References: <1148474038.2934.18.camel@dyn-9-152-230-71.boeblingen.de.ibm.com> <20060524155735.04ed777a.akpm@osdl.org> <1148941055.3005.73.camel@dyn-9-152-230-71.boeblingen.de.ibm.com> <20060530080700.GA9419@osiris.boeblingen.de.ibm.com>
In-Reply-To: <20060530080700.GA9419@osiris.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heiko Carstens wrote:
>>  	case CPU_UP_PREPARE:
>>  		stat->pdata->ptrs[cpu] = statistic_alloc_ptr(stat, GFP_ATOMIC,
> 
> Why not GFP_KERNEL?

I see. Schedule() is permitted in this context. Will change it.

>> +		if (!stat->pdata->ptrs[cpu])
>> +			return -ENOMEM;
> 
> NOTIFY_BAD instead of -ENOMEM, I guess.

Not a bug, but slightly confusing. I think I will clean it up in my
next update patch.

>>  		break;
>>  	case CPU_UP_CANCELED:
>>  	case CPU_DEAD:
> 
> I think your merge code (which gets called if CPU_UP_PREPARE fails) expects
> stat->pdata->ptrs[cpu] to be non-zero, right?

That's a bug and needs fixing (just bail out if pointer if zero).

Thanks, Martin

