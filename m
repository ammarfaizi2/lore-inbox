Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262003AbTCRFS1>; Tue, 18 Mar 2003 00:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262019AbTCRFS1>; Tue, 18 Mar 2003 00:18:27 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:16366 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP
	id <S262003AbTCRFS0>; Tue, 18 Mar 2003 00:18:26 -0500
Date: Tue, 18 Mar 2003 17:27:02 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [PATCH] Don't refill pcp lists during SWSUSP.
In-reply-to: <20030317160556.4efc880f.akpm@digeo.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1047965222.2430.3.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1047945372.1714.19.camel@laptop-linux.cunninghams>
 <20030317160556.4efc880f.akpm@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-18 at 12:05, Andrew Morton wrote:
> Nigel Cunningham <ncunningham@clear.net.nz> wrote:
> >
> > +extern unsigned int suspend_task;
> 
> 
> Please do:
> 
> #ifdef CONFIG_SOFTWARE_SUSPEND
> unsigned int suspend_task;
> #else
> #define suspend_task 0
> #endif
> 
> so the compiler can remove the few fast-path instructions which you have
> added.

Okee doke. Will do.

I said I was going to use dynamically allocated bitmaps instead of page
flags. Do you mind if I do use pageflags after all (at least for the
moment)? I've used one in the generate_free_page_map patch, and need one
more to mark pages which will be saved in another pageset.

> >  	
> > +	suspend_task = current->pid;
> > +
> 
> Zero is a valid PID (the idle task...).  It might be clearer to make
> suspend_task a task_struct*.

Mmm, but I will use suspend_task elsewhere and wanted to make the test
simple (zero = not suspending at the moment; since init will never be
the suspend task, it's safe usage).

Regards,

Nigel

-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Be diligent to present yourself approved to God as a workman who does
not need to be ashamed, handling accurately the word of truth.
	-- 2 Timothy 2:14, NASB.

