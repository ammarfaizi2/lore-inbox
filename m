Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311701AbSDSH1X>; Fri, 19 Apr 2002 03:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311749AbSDSH1W>; Fri, 19 Apr 2002 03:27:22 -0400
Received: from tolkor.sgi.com ([192.48.180.13]:7076 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S311701AbSDSH1V>;
	Fri, 19 Apr 2002 03:27:21 -0400
Message-ID: <3CBFC755.50106@sgi.com>
Date: Fri, 19 Apr 2002 02:29:25 -0500
From: Stephen Lord <lord@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Peloquin <peloquin@us.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Bio pool & scsi scatter gather pool usage
In-Reply-To: <OFCF00F1A4.2665039D-ON85256B9F.006B755C@pok.ibm.com> from "Mark Peloquin" at Apr 18, 2002 05:58:16 PM <E16yLS4-0005vN-00@the-village.bc.nu> <3CBF5B67.E488A8E5@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Alan Cox wrote:
>
>>>Perhaps, but calls are expensive. Repeated calls down stacked block
>>>devices will add up. In only the most unusually cases will there
>>>
>>You don't need to repeatedly query. At bind time you can compute the
>>limit for any device heirarchy and be done with it.
>>
>
>S'pose so.  The ideal request size is variable, based
>on the alignment.  So for exampe if the start block is
>halfway into a stripe, the ideal BIO size is half a stripe.
>
>But that's a pretty simple table to generate once-off,
>as you say.
>

But this gets you lowest common denominator sizes for the whole
volume, which is basically the buffer head approach, chop all I/O up
into a chunk size we know will always work. Any sort of nasty  boundary
condition at one spot in a volume means the whole thing is crippled
down to that level. It then becomes a black magic art to configure a
volume which is not restricted to a small request size.

Steve


