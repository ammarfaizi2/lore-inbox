Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262701AbVCWCLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262701AbVCWCLL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 21:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbVCWCLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 21:11:11 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:49575 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262701AbVCWCLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 21:11:04 -0500
Message-ID: <4240D022.1020202@yahoo.com.au>
Date: Wed, 23 Mar 2005 13:10:42 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: Andrew Morton <akpm@osdl.org>, hugh@veritas.com, tony.luck@intel.com,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] freepgt: free_pgtables use vma list
References: <B8E391BBE9FE384DAA4C5C003888BE6F03211851@scsmsx401.amr.corp.intel.com>	<Pine.LNX.4.61.0503230052500.10858@goblin.wat.veritas.com>	<20050322171013.5c52dd18.akpm@osdl.org> <20050322180020.7ce75c30.davem@davemloft.net>
In-Reply-To: <20050322180020.7ce75c30.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

>On Tue, 22 Mar 2005 17:10:13 -0800
>Andrew Morton <akpm@osdl.org> wrote:
>
>
>>Hugh Dickins <hugh@veritas.com> wrote:
>>
>>>On Tue, 22 Mar 2005, Luck, Tony wrote:
>>> > 
>>> > But I'm still confused by all the math on addr/end at each
>>> > level.
>>>
>>> You think the rest of us are not ;-?
>>>
>>umm, given the difficulty which you guys are having with this, I get a bit
>>worried about clarity, simplicity and maintainability of the end result.
>>
>
>We're working on it, trust me :-)
>
>I have a simplification in mind that should take care of the issue
>that led us to these problems.  We should simply pass in "ceiling"
>as "-1" instead of "0".  Every single test against ceiling is
>really done against "ceiling - 1".
>
>Therefore, passing ceiling in as "top - 1" and then adjusting the
>tests will clean this up substantially and make is much simpler.
>
>

The ugly thing you get with an inclusive ceiling is that your masking
becomes more difficult I think.

I might try to attack this from another angle and see if I can come up
with something.


