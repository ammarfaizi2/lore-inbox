Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261741AbVCaUK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbVCaUK3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 15:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbVCaUK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 15:10:29 -0500
Received: from fire.osdl.org ([65.172.181.4]:49344 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261741AbVCaUKH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 15:10:07 -0500
Message-ID: <424C5912.90607@osdl.org>
Date: Thu, 31 Mar 2005 12:09:54 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
CC: Yum Rayan <yum.rayan@gmail.com>, linux-kernel@vger.kernel.org,
       mvw@planets.elm.net
Subject: Re: [PATCH] Reduce stack usage in acct.c
References: <df35dfeb05033023394170d6cc@mail.gmail.com> <20050331150548.GC19294@wohnheim.fh-wedel.de>
In-Reply-To: <20050331150548.GC19294@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:
> On Wed, 30 March 2005 23:39:40 -0800, Yum Rayan wrote:
> 
>>Before patch
>>------------
>>check_free_space - 128
>>do_acct_process - 105
>>
>>After patch
>>-----------
>>check_free_space - 36
>>do_acct_process - 44
> 
> 
> It is always nice to see enthusiams, but in your case it might be a
> bit misguided.  None of the functions you worked on appear to be real
> problems wrt. stack usage.

Yes, this is similar to what I was about to write.
It would be more useful to tackle the really large stack consumers
or ones in deep call chains.

> But if you have time to tackle some of these functions, that may make
> a real difference:
> 
> http://wh.fh-wedel.de/~joern/stackcheck.2.6.11
> 
> In principle, all recursive paths should consume as little stack as
> possible.  Or the recursion itself could be avoided, even better.  And
> some of the call chains with ~3k of stack consumption may be
> problematic on other platforms, like the x86-64.  Taking care of those
> could result in smaller stacks for the respective platform.

Here is 2.6.12-rc1-bk3 raw checkstack output on x86-64:
http://developer.osdl.org/~rddunlap/doc/checkstack1.out

-- 
~Randy
