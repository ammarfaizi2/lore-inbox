Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262626AbTDAQCw>; Tue, 1 Apr 2003 11:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262627AbTDAQCw>; Tue, 1 Apr 2003 11:02:52 -0500
Received: from cm19173.red.mundo-r.com ([213.60.19.173]:35352 "EHLO
	trasno.mitica") by vger.kernel.org with ESMTP id <S262626AbTDAQCu>;
	Tue, 1 Apr 2003 11:02:50 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@digeo.com>,
       colpatch@us.ibm.com, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (2.5.66-mm2) War on warnings
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <20030401152703.GA21986@gtf.org> (Jeff Garzik's message of
 "Tue, 1 Apr 2003 10:27:03 -0500")
References: <19200000.1049210557@[10.10.2.4]> <20030401152703.GA21986@gtf.org>
Date: Tue, 01 Apr 2003 18:14:10 +0200
Message-ID: <86u1diyz3h.fsf@trasno.mitica>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.2.93
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "jeff" == Jeff Garzik <jgarzik@pobox.com> writes:

jeff> On Tue, Apr 01, 2003 at 07:22:37AM -0800, Martin J. Bligh wrote:
>> drivers/base/node.c: In function `register_node_type':
>> drivers/base/node.c:96: warning: suggest parentheses around assignment used as truth value
>> drivers/base/memblk.c: In function `register_memblk_type':
>> drivers/base/memblk.c:54: warning: suggest parentheses around assignment used as truth value
>> 
>> Bah.
>> 
>> --- linux-2.5.66-mm2/drivers/base/node.c	2003-04-01 06:40:02.000000000 -0800
>> +++ 2.5.66-mm2/drivers/base/node.c	2003-04-01 06:37:32.000000000 -0800
>> @@ -93,7 +93,7 @@ int __init register_node_type(void)
>> {
>> int error;
>> if (!(error = devclass_register(&node_devclass)))
>> -		if (error = driver_register(&node_driver))
>> +		if ((error = driver_register(&node_driver)))
>> devclass_unregister(&node_devclass);

jeff> Personally, I feel statements like these are prone to continual error
jeff> and confusion.  I would prefer to break each test like this out into
jeff> separate assignment and test statements.  Combining them decreases
jeff> readability, while saving a paltry few extra bytes of source code.

jeff> Sure, the gcc warning is silly, but the code is a bit obtuse too.

I think:
- gcc warning is good, normally you want to test, not assignation
- Linus style for that is:

            if ((error = driver_register(&node_driver)) != 0) 

which sounds more logical.  the double parens things is just a bad
hack IMHO.

Later, Juan.


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
