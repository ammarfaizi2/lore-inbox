Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbULWJeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbULWJeD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 04:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbULWJeC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 04:34:02 -0500
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36]:52633 "EHLO
	dgate2.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S261195AbULWJdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 04:33:50 -0500
X-SBRSScore: None
X-IronPort-AV: i="3.88,83,1102287600"; 
   d="scan'208"; a="1213388:sNHT24389848"
Message-ID: <41CA90F4.8000800@fujitsu-siemens.com>
Date: Thu, 23 Dec 2004 10:33:40 +0100
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc3, i386: fpu handling on sigreturn
References: <41C9B21F.90802@fujitsu-siemens.com.suse.lists.linux.kernel> <p73mzw5zzk2.fsf@verdi.suse.de> <41CA0813.1070707@fujitsu-siemens.com> <20041222235448.GA17720@verdi.suse.de>
In-Reply-To: <20041222235448.GA17720@verdi.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Thu, Dec 23, 2004 at 12:49:39AM +0100, Bodo Stroesser wrote:
> 
>>Andi Kleen wrote:
>>
>>>Bodo Stroesser <bstroesser@fujitsu-siemens.com> writes:
>>>
>>>
>>>>Now, the interrupted processes fpu no longer is cleared!
>>>
>>>
>>>I agree it's a bug, although it's probably pretty obscure so people
>>>didn't notice it.  The right fix would be to just clear_fpu again
>>>in this case.  The problem has been in Linux forever.
>>
>>Wouldn't it be better to also reset used_math to 0? (As it has been,
>>before the sighandler was started)
> 
> 
> It would only be an optimization, and i doubt it's worth to optimize for 
> such an obscure case. 
> 
> -Andi
Sorry, I don't agree. AFAICS, if used_math isn't reset, on the next
attempt of the process to use the fpu, it will be reloaded with the
values, that come from the sighandler and that still reside in
thread.i387. Thus, clear_cpu() without resetting used_math has no
effect to the userspace task.
Resetting current->used_math to 0 would make math_state_restore()
calling init_fpu(), that clears thread.i387 before the fpu is loaded.

Bodo
