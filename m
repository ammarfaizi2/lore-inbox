Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285196AbRLXSQw>; Mon, 24 Dec 2001 13:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285206AbRLXSQo>; Mon, 24 Dec 2001 13:16:44 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:12477 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S285196AbRLXSQb>; Mon, 24 Dec 2001 13:16:31 -0500
Message-ID: <3C2770FE.80403@redhat.com>
Date: Mon, 24 Dec 2001 13:16:30 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011217
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Keith Owens <kaos@ocs.com.au>, Benjamin LaHaise <bcrl@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] Assigning syscall numbers for testing
In-Reply-To: <E16IZl0-0004mP-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>syscall bindings.  My example was about code using the predefined syscall 
>>number for new functions on an older kernel where those functions don't 
>>exist, but where they overlap with the older dynamic syscall numbers.  In 
>>short, the patch is safe for code that uses the lazy binding, but it can 
>>still overlap with future syscall numbers and code that doesn't use the lazy 
>>binding but instead uses predefined numbers.
>>
> 
> Now I follow you. So if Linus takes that patch he needs to allocate a block
> of per architecture dynamic syscall number space for it to use. Negative
> syscall numbers seem the most promising approach ?
> 
> 

Something like that.  It needs to be a large enough range to reasonably 
support the maximum number of expected syscalls that could possibly be in 
testing at one time (which is a total guesstimate if you ask me), and it 
should hopefully be up high so that we aren't allocating new numbers around 
it.  However, I think it needs to be allocated *regardless* of whether Linus 
takes the patch into his kernel.  Even if the patch is simply used outside 
Linus's kernel, it still needs the allocation to truly be safe.

-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

