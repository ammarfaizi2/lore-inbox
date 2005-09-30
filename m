Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030387AbVI3Ucd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030387AbVI3Ucd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 16:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030391AbVI3Ucd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 16:32:33 -0400
Received: from magic.adaptec.com ([216.52.22.17]:22470 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1030387AbVI3Ucc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 16:32:32 -0400
Message-ID: <433DA0DF.9080308@adaptec.com>
Date: Fri, 30 Sep 2005 16:32:31 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: andrew.patterson@hp.com
CC: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>, dougg@torque.net,
       Linus Torvalds <torvalds@osdl.org>, Luben Tuikov <ltuikov@yahoo.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01A9FA11@otce2k03.adaptec.com>	 <1128105594.10079.109.camel@bluto.andrew>  <433D9035.6000504@adaptec.com> <1128111290.10079.147.camel@bluto.andrew>
In-Reply-To: <1128111290.10079.147.camel@bluto.andrew>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Sep 2005 20:32:31.0216 (UTC) FILETIME=[14DA8F00:01C5C5FE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/30/05 16:14, Andrew Patterson wrote:
> 
> Yes you can, which is what I am trying to do.  However, is that library
> also available on Solaris and Windows? Is it up to date?  These are the

Is the kernel the latest one? Is it up to date?

See?  Same argument.

>>>Note that a sysfs implementation has problems.  Binary attributes are
>>>discouraged/not-allowed.
>>
>>I've never heard that.  Is this similar to the argument
>>"The sysfs tree would be too deep?"
> 
> 
>>From Documentation/filesystes/sysfs.txt
> 
> "Attributes should be ASCII text files, preferably with only one value
> per file. It is noted that it may not be efficient to contain only
> value per file, so it is socially acceptable to express an array of
> values of the same type.
> 
> Mixing types, expressing multiple lines of data, and doing fancy
> formatting of data is heavily frowned upon. Doing these things may get
> you publically humiliated and your code rewritten without notice."

I see this talk _only_ about non-binary attributes.

Plus you have to admit: the SAS sysfs "smp_portal" binary
attribute is very versatile: you completely control the
expander from user space _if_ you can see it:  It is 
almost like "point and click".

I imagine there would be GUIs built on top of it, which would
actually implement that "point, click, control".

> My understanding is that sysfs is meant to be human-readable.  I do not

But `cat /sysfs/.../smp_portal` _is_ human readable.  See?  Its size is
0 bytes and when you read it you get 0 data read.

> User space locking can only guarantee atomic operations in user space.  

And user space is the whole audience of this interface.

> Not sure at the moment, can I guarantee this for the future?

How far in the future? 1, 3, 6 months?  1, 3, 6 years?
Plus if you need an attribute larger than 4K, you've got
other problems to worry about.

> There are as many as one would want.  We now have 32 bit device numbers.
> Old technology is fine as long as it works, especially if their is no
> new technology to replace it.  Note that I don't like the character
> device solution either. What would really be nice is something that will
> allow us to pass an arbitrary request buffer, and get an arbitrary
> response buffer back in a single transaction,

Here:

/* User space lock */

fd = open(smp_portal, ...);
write(fd, smp_req, smp_req_size);
read(fd, smp_resp, smp_resp_size);
close(fd);

/* User space unlock */

> See above.  This stuff works for trivial user-space apps.  It will not
> suffice for most storage management apps.  

Sorry but I completely fail to see this argument.

How will it "fail for most storage managament apps"?

	Luben
