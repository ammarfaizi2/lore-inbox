Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312792AbSDFURS>; Sat, 6 Apr 2002 15:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312798AbSDFURR>; Sat, 6 Apr 2002 15:17:17 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:37090 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S312792AbSDFURQ>; Sat, 6 Apr 2002 15:17:16 -0500
Message-ID: <3CAF5775.2020401@didntduck.org>
Date: Sat, 06 Apr 2002 15:15:49 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Clean up x86 interrupt entry code
In-Reply-To: <3CAF54AA.1020303@didntduck.org> <1018123940.899.104.camel@phantasy>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> On Sat, 2002-04-06 at 15:03, Brian Gerst wrote:
> 
> 
>>-ENTRY(ret_from_intr)
>>-	GET_THREAD_INFO(%ebx)
>>-	init_ret_intr
>>+ret_from_intr:
>>+	preempt_stop
>>+	DEC_PRE_COUNT(%ebx)
> 
> 
> You removed GET_THREAD_INFO and there does not seem to be a
> replacement.  Is there some assurance *thread_info is now pointed to by
> %ebx here?
> 
> 	Robert Love
> 

Yes.  It is set before the INC_PRE_COUNT and since it is preserved by 
called functions it is still set when it gets to ret_from_intr.

-- 

						Brian Gerst

