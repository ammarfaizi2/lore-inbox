Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285155AbRLXQws>; Mon, 24 Dec 2001 11:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285156AbRLXQwi>; Mon, 24 Dec 2001 11:52:38 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:46510 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S285155AbRLXQwb>; Mon, 24 Dec 2001 11:52:31 -0500
Message-ID: <3C275D4E.1010205@redhat.com>
Date: Mon, 24 Dec 2001 11:52:30 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011217
X-Accept-Language: en-us
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Assigning syscall numbers for testing
In-Reply-To: <26616.1009155672@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:

> On Sun, 23 Dec 2001 12:06:04 -0500, 
> Benjamin LaHaise <bcrl@redhat.com> wrote:
> 
>>On Sun, Dec 23, 2001 at 04:10:21PM +1100, Keith Owens wrote:
>>
>>>I'm glad somebody understands the code :).
>>>
>>There are two directions of binary compatibility: forwads and backwards.  
>>Your patch breaks forwards compatibility if used outside the main tree.  Try 
>>to understand this.
>>
> 
> Too vague, give me an example with real code and effects.


Well, I'm not going to mess with code, but here's the example.  Say you 
start at syscall 240 for dynamic registration.  Someone then submits a patch 
to Linus that he accepts and which uses syscalls 240 and 241.  Now, you can 
modify the base of your patch, but if it has been accepted into any real 
kernels anywhere, then someone could inadvertently end up running a user 
space app compiled against Linus' new kernel and that uses the newly 
allocated syscalls 240 and 241.  If that's run on an older kernel with your 
patch, then you call into the wrong syscalls with the wrong data.  That's 
how forward compatibility is broken.  Ben's point is that you can move the 
numbers up as high as you want, move them around as often as you want, but 
unless either A) Linus grants your dynamic range as an *official* set of 
syscall numbers or B) you get rid of the numbers entirely, it is never 
guaranteed to be compatible with binaries compiled against newer kernels.





-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

