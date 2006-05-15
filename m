Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbWEOXBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWEOXBX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 19:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWEOXBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 19:01:23 -0400
Received: from mx.pathscale.com ([64.160.42.68]:3211 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1750734AbWEOXBV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 19:01:21 -0400
Message-ID: <60844.71.131.57.117.1147734080.squirrel@rocky.pathscale.com>
In-Reply-To: <1147727447.2773.14.camel@chalcedony.pathscale.com>
References: <f8ebb8c1e43635081b73.1147477418@eng-12.pathscale.com> 
    <adazmhjth56.fsf@cisco.com>
    <1147727447.2773.14.camel@chalcedony.pathscale.com>
Date: Mon, 15 May 2006 16:01:20 -0700 (PDT)
Subject: Re: [PATCH 53 of 53] ipath - add memory barrier when waiting for 
     writes
From: ralphc@pathscale.com
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: "Roland Dreier" <rdreier@cisco.com>, openib-general@openib.org,
       linux-kernel@vger.kernel.org, ralphc@pathscale.com
User-Agent: SquirrelMail/1.4.6
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 2006-05-15 at 08:57 -0700, Roland Dreier wrote:
>>  >  static void i2c_wait_for_writes(struct ipath_devdata *dd)
>>  >  {
>>  > +	mb();
>>  >  	(void)ipath_read_kreg32(dd, dd->ipath_kregs->kr_scratch);
>>  >  }
>>
>> This needs a comment explaining why it's needed.  A memory barrier
>> before a readl() looks very strange since readl() should be ordered
>> anyway.
>
> Yeah.  It's actually working around what appears to be a gcc bug if the
> kernel is compiled with -Os.  Ralph knows the details; he can give a
> more complete answer.
>
> 	<b

I don't have a lot to add to this other than I looked at the
assembly code output for -Os and -O3 and both looked OK.
I put the mb() in to be sure the writes were complete and
I found this to work by experimentation.
Without it, the driver fails to read the EEPROM correctly.

