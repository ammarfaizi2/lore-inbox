Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285177AbRLXRGi>; Mon, 24 Dec 2001 12:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285179AbRLXRG3>; Mon, 24 Dec 2001 12:06:29 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:14257 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S285177AbRLXRGU>; Mon, 24 Dec 2001 12:06:20 -0500
Message-ID: <3C27608B.4030900@redhat.com>
Date: Mon, 24 Dec 2001 12:06:19 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011217
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Keith Owens <kaos@ocs.com.au>, Benjamin LaHaise <bcrl@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] Assigning syscall numbers for testing
In-Reply-To: <E16IYdY-0004bY-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>Well, I'm not going to mess with code, but here's the example.  Say you 
>>start at syscall 240 for dynamic registration.  Someone then submits a patch 
>>
> 
> The number you start at depends on the kernel you run.
> 
> 
>>modify the base of your patch, but if it has been accepted into any real 
>>kernels anywhere, then someone could inadvertently end up running a user 
>>space app compiled against Linus' new kernel and that uses the newly 
>>allocated syscalls 240 and 241.  If that's run on an older kernel with your 
>>
> 
> The code on execution will read the syscall numbers from procfs. It will
> find new numbers and call those. Its a very simple implementation of lazy
> binding. It only breaks if you actually run out of syscalls, and then it
> fails safe.
> 
> Alan
> 
> 

No it doesn't.  You are *assuming* that *all* code will check the lazy 
syscall bindings.  My example was about code using the predefined syscall 
number for new functions on an older kernel where those functions don't 
exist, but where they overlap with the older dynamic syscall numbers.  In 
short, the patch is safe for code that uses the lazy binding, but it can 
still overlap with future syscall numbers and code that doesn't use the lazy 
binding but instead uses predefined numbers.

-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

