Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287149AbSALQH4>; Sat, 12 Jan 2002 11:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287155AbSALQHr>; Sat, 12 Jan 2002 11:07:47 -0500
Received: from colorfullife.com ([216.156.138.34]:36879 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S287149AbSALQHe>;
	Sat, 12 Jan 2002 11:07:34 -0500
Message-ID: <3C405F4E.EADB2294@colorfullife.com>
Date: Sat, 12 Jan 2002 17:07:42 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.2-pre11 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org,
        Manfred Spraul <manfreds@colorfullife.com>
Subject: Re: Q: behaviour of mlockall(MCL_FUTURE) and VM_GROWSDOWN segments
In-Reply-To: <3C3F3C7F.76CCAF76@colorfullife.com.suse.lists.linux.kernel> <3C3F4FC6.97A6A66D@zip.com.au.suse.lists.linux.kernel> <p73r8ow4dd7.fsf@oldwotan.suse.de> <20020112163332.M1482@inspiron.school.suse.de> <20020112165443.A13179@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> For the stack they can get minor faults anyways when they allocate new
> stack space below ESP. There is no good way to fix that from the kernel; the
> application has to preallocate its memory on stack. I think it's reasonable
> if it does the same for holes on the stack.
>
Ok, everyone agrees that mlockall() should not grow VM_GROWSDOWN
segments to their maximum size.
Should the page fault handler fill the hole created by

void * grow_stack(void)
{
	char data[100000];
	data[0] = '0';
	return data;
}

The principle of least surprise would mean filling holes, but OTHO sane
apps would use memset(data,0,sizeof(data)).

--
	Manfred
