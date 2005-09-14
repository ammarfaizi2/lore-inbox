Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965071AbVINWdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965071AbVINWdO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 18:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965077AbVINWdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 18:33:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33480 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965071AbVINWdN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 18:33:13 -0400
Message-ID: <4328A3A2.7010605@redhat.com>
Date: Wed, 14 Sep 2005 18:26:42 -0400
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Assar <assar@permabit.com>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfs client, kernel 2.4.31: readlink result overflow
References: <78irx6wh6j.fsf@sober-counsel.permabit.com>	<200509121846.j8CIk5YE025124@turing-police.cc.vt.edu>	<784q8qrsad.fsf@sober-counsel.permabit.com>	<200509122001.j8CK1kpW028651@turing-police.cc.vt.edu>	<788xy2qas0.fsf@sober-counsel.permabit.com>	<20050913183948.GE14889@dmt.cnet>	<784q8okdfn.fsf@sober-counsel.permabit.com>	<20050913193539.GB17222@dmt.cnet>	<784q8oivp4.fsf@sober-counsel.permabit.com>	<43287221.8020602@redhat.com>	<7864t3h1xw.fsf@sober-counsel.permabit.com>	<432883E5.6000004@redhat.com> <78ek7rfg0o.fsf@sober-counsel.permabit.com>
In-Reply-To: <78ek7rfg0o.fsf@sober-counsel.permabit.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Assar wrote:

>Peter Staubach <staubach@redhat.com> writes:
>  
>
>>This code appears to assume that rcvbuf->page_base is zero here, but then
>>uses rcvbuf->page_base when calculating where to place the null byte.  It
>>seems to me that it should either use rcvbuf->page_base in both
>>calculations or neither.
>>    
>>
>
>The meaning of page_len and page_base are not totally clear to me.  Is
>it the case that the data starts at offset page_base and there is
>page_len bytes of it.  If that's the case, I think the code is doing
>the right thing.
>

I am not clear either, but I would think that kmap_atomic() would return
a pointer to the beginning of the page.  There is also an assumption that
there is only one page.  If page_base needs to be used to offset from
the address returned by kmap_atomic(), then I wouldn't think that the
current test is correct.  I think that it needs to take page_base into
account when checking for the boundary.

    Thanx...

       ps
