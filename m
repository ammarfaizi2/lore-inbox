Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264374AbTGKRhk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 13:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264543AbTGKRhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 13:37:40 -0400
Received: from mail5.iserv.net ([204.177.184.155]:32161 "EHLO mail5.iserv.net")
	by vger.kernel.org with ESMTP id S264374AbTGKRhg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 13:37:36 -0400
Message-ID: <3F0EF939.90506@didntduck.org>
Date: Fri, 11 Jul 2003 13:51:53 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Cole <elenstev@mesatop.com>
CC: Larry McVoy <lm@bitmover.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Tomas Szepe <szepe@pinerecords.com>,
       Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
References: <20030711140219.GB16433@suse.de>	 <1057933578.20636.17.camel@dhcp22.swansea.linux.org.uk>	 <20030711144617.GK10217@louise.pinerecords.com>	 <1057935630.20637.19.camel@dhcp22.swansea.linux.org.uk>	 <20030711151127.GA30378@work.bitmover.com> <1057937849.2337.4.camel@spc9.esa.lanl.gov>
In-Reply-To: <1057937849.2337.4.camel@spc9.esa.lanl.gov>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole wrote:
> On Fri, 2003-07-11 at 09:11, Larry McVoy wrote:
> 
>>On Fri, Jul 11, 2003 at 04:00:33PM +0100, Alan Cox wrote:
>>
>>>On Gwe, 2003-07-11 at 15:46, Tomas Szepe wrote:
>>>
>>>>>>- gcc 3.2.2-5 as shipped by Red Hat generates incorrect code in the
>>>>>>  kmalloc optimisation introduced in 2.5.71
>>>>>>  See http://linus.bkbits.net:8080/linux-2.5/cset@1.1410
>>>>>
>>>>>This URL appears wrong!
>>>>
>>>>Nahh, that's just the same old annoying bkbits bug.  Try with lynx...
>>>
>>>I did - it references a changeset unrelayed to kmalloc
>>
>>I know, sorry.  The version numbers in BK are not stable, they can't be.
>>You have to use the underlying internal version number.  If someone who
>>knows can show me the output of 
>>
>>	bk changes -r<correct rev>
>>
>>for that changeset I will figure out a way to have a URL that doesn't change
>>and send it to Dave for that doc as well as post it there.
> 
> 
> This looks like the right one as currently numbered.
> 
> http://linus.bkbits.net:8080/linux-2.5/cset@1.1215.127.10
> 
> Steven

There is no problem with the current version of this patch.  I rewrote 
the original patch to work around the bug in gcc.  The bug is that:

	if (size < X) return kmem_cache_alloc(...);

would not cause the remaining if statements to be marked as dead code, but:

	if (size < X) goto found;
	...
	found: return kmem_cache_alloc(...);

does optimize properly.

--
				Brian Gerst

