Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbTIPOvm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 10:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbTIPOvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 10:51:42 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:17925 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S261918AbTIPOvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 10:51:41 -0400
Message-ID: <3F672396.10906@techsource.com>
Date: Tue, 16 Sep 2003 10:52:06 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
CC: David Yu Chen <dychen@stanford.edu>, linux-kernel@vger.kernel.org,
       mc@cs.stanford.edu, David Woodhouse <dwmw2@infradead.org>,
       linux-mtd@lists.infradead.org
Subject: Re: [CHECKER] 32 Memory Leaks on Error Paths
References: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU> <20030916065553.GA12329@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> 276:	/* OK, it's not open. Create cache info for it */
>>START -->
>> 277:	mtdblk = kmalloc(sizeof(struct mtdblk_dev), GFP_KERNEL);
>> 278:	if (!mtdblks)
>>END -->
>> 279:		return -ENOMEM;

> 
> Invalid.  This is quite an obvious false positive, at least if your
> algorithm checks for possible value ranges.

Wait... one is "mtdblk", and the other is "mtdblks".  One has an extra 
's' on it.  Unless there is some kind of aliasing going on, they would 
appear to be different variables.  Naturally, I didn't check the 
original code, so I could be full of it.  :)

