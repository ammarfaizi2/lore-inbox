Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266243AbUIONjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266243AbUIONjR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 09:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266193AbUIONhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 09:37:38 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:54412 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266155AbUIONgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 09:36:22 -0400
Message-ID: <41484558.6060301@namesys.com>
Date: Wed, 15 Sep 2004 06:36:24 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Lee Revell <rlrevell@joe-job.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Robert Love <rml@ximian.com>, Andrea Arcangeli <andrea@novell.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sched: fix scheduling latencies for !PREEMPT kernels
References: <41470021.1030205@yahoo.com.au> <20040914150316.GN4180@dualathlon.random> <1095185103.23385.1.camel@betsy.boston.ximian.com> <20040914185212.GY9106@holomorphy.com> <1095188569.23385.11.camel@betsy.boston.ximian.com> <20040914192104.GB9106@holomorphy.com> <1095189593.16988.72.camel@localhost.localdomain> <1095207749.2406.36.camel@krustophenia.net> <20040915014610.GG9106@holomorphy.com> <1095213644.2406.90.camel@krustophenia.net> <20040915023611.GH9106@holomorphy.com>
In-Reply-To: <20040915023611.GH9106@holomorphy.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

>On Tue, 2004-09-14 at 21:46, William Lee Irwin III wrote:
>  
>
>>>I've not heard a peep about anyone trying to fix this. It should be
>>>killed off along with the rest, of course, but like I said before, it's
>>>the messiest, dirtiest, and ugliest code that's left to go through,
>>>which is why it's been left for last. e.g. driver ->ioctl() methods.
>>>      
>>>
>
>On Tue, Sep 14, 2004 at 10:00:44PM -0400, Lee Revell wrote:
>  
>
>>Andrew tried to fix this a few times in 2.4 and it broke the FS in
>>subtle ways.  Don't have an archive link but the message is
>><20040712163141.31ef1ad6.akpm@osdl.org>.  I asked Hans directly about it
>>and he said "balancing makes it hard, the fix is reiser4", see
>><411925FA.2000303@namesys.com>.
>>    
>>
>
>I have neither of these locally. I suspect someone needs to care enough
>about the code for anything to happen soon. I suppose there are things
>that probably weren't tried, e.g. auditing to make sure dependencies on
>external synchronization are taken care of, removing implicit sleeping
>with the BKL held, then punt a private recursive spinlock in reiser3's
>direction. Not sure what went on, or if I want to get involved in this
>particular case.
>
>
>-- wli
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>
Why bother?  It is V3, it should be left undisturbed except for 
bugfixes.  Please, spend your efforts on reducing V4 latency and 
measuring whether it fails to scale to multiple processors.  That would 
be very useful to me if someone helped with that.  V4 has the 
architecture for doing such things well, but there are always accidental 
bottlenecks that testing can discover, and I am sure we will have a 
handful of things preventing us from scaling well that are not hard to 
fix.  It would be nice to fix those......

The hard stuff for scalability, the locking of the tree, we did that.  
We just haven't tested and evaluated and refined like we need to in V4.



Hans
