Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262221AbUKKLZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbUKKLZA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 06:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262211AbUKKLWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 06:22:54 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:47082 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262214AbUKKLU4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 06:20:56 -0500
Message-ID: <41934AE8.7040008@in.ibm.com>
Date: Thu, 11 Nov 2004 16:50:08 +0530
From: Sripathi Kodi <sripathik@in.ibm.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Dinakar Guniguntala <dino@in.ibm.com>, linux-kernel@vger.kernel.org,
       Roland McGrath <roland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] do_wait fix for 2.6.10-rc1
References: <418B4E86.4010709@in.ibm.com> <Pine.LNX.4.58.0411051101500.30457@ppc970.osdl.org> <418F826C.2060500@in.ibm.com> <Pine.LNX.4.58.0411080744320.24286@ppc970.osdl.org> <Pine.LNX.4.58.0411080806400.24286@ppc970.osdl.org> <Pine.LNX.4.58.0411080820110.24286@ppc970.osdl.org> <Pine.LNX.4.58.0411081708000.2301@ppc970.osdl.org> <20041109143118.GA8961@in.ibm.com> <Pine.LNX.4.58.0411090745250.2301@ppc970.osdl.org> <20041110143518.GC4502@in.ibm.com> <Pine.LNX.4.58.0411100903290.2301@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0411100903290.2301@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Wed, 10 Nov 2004, Dinakar Guniguntala wrote:
>  
>
>>How about if we set the flag only in the cases when the exit state is not
>>either TASK_DEAD or TASK_ZOMBIE. 
>>    
>>
>
>Why TASK_DEAD? We can't reap such a process anyway, no? But yes, I agree 
>with the approach.
>
>		Linus
>  
>
Linus,

Yes, when we see a process in TASK_DEAD state, we can't reap it. We 
shouldn't set the flag in this scenario because we have not really found 
an eligible child (one in any state other than TASK_DEAD). So we need to 
go back to parsing the list of children as if we have not found an 
eligible child at all.

Please let us know if this argument is correct and if we have reached 
the final shape for this fix.

Thanks,
Sripathi.
