Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261480AbSIWTz2>; Mon, 23 Sep 2002 15:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261369AbSIWTz1>; Mon, 23 Sep 2002 15:55:27 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:6797 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261480AbSIWTzX>;
	Mon, 23 Sep 2002 15:55:23 -0400
Message-ID: <3D8F70F5.4040406@watson.ibm.com>
Date: Mon, 23 Sep 2002 15:52:21 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: clemc@alumni.cmu.edu
Cc: Stephen Hemminger <shemminger@osdl.org>,
       Benjamin LaHaise <bcrl@redhat.com>, Andrew Morton <akpm@digeo.com>,
       Alexander Viro <viro@math.psu.edu>, linux-aio <linux-aio@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] adding aio_readv/writev
References: <200209231851.g8NIpea12782@igw2.watson.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clement T. Cole wrote:

>>>Comments, reasons for not doing async readv/writev directly welcome.
>>>
>
>How about the case for it...  See Pages 404-406 [Section 12.7] of
>Richard Steven's ``Advanced Programming in the Unix Environment''
>[aka APUE].  Richard measures almost a factor of 2 difference
>in system time between using vectored I/O and not using it on
>a Sun and on a x86.
>
It would have been nice to have corresponding data for the async path.

><snip>
>
>So... let's get back to the basic issue....
>
>We know that vectored/scatter gather I/O can help a number of real
>applications ... Richard demonstrated that.  We have some examples
>[like DB2] that have use vectored I/O successfully.  We also
>know asynchronous I/O has been demonstrated to be useful and
>know that some commerical folks have used that.  
>
>I'm gather from some of the comments, adding async/vectored
>will make an already complex subsystem, even more so [i.e. not
>a resounding endorsement for sure this is easy].
>

I wouldn't say so. Adding async vectored I/O to the 2.5 code won't make 
it more complex since the underlying functions
do handle iovec's anyway.

>
>
>So the question is can async vectored I/O be implemented 
>to have a positive gain, such as it did within the traditonal one.
>If the complexity is too high and it does not help much...then
>maybe this is a Chimera to leave alone.   But.... if it can be
>done with some level of elegance... well.... the past history is
>that the commerical folks have used those features.
>

It seems to be a case of "complexity is low, benefits are unknown". I 
guess the best thing is to develop a patch and see what people think 
about the complexity part. The benefits part will become clear only when 
the async interfaces are reasonable functional and we can compare the 
following

- call async readv directly
vs
- multiple calls to io_submit using one iocb (each call corresponds to 
one element of user's vector)
vs
- single call to io_submit using multiple iocb's (each iocb corresponds 
to one element of user's vector)

Since the raw/O_DIRECT interfaces offer asynchrony (through Badari 
Pulavarty & Mingming Cao's patches), it should be possible to test this 
out.

More on this shortly,
- Shailabh

