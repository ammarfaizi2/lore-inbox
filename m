Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965092AbVHZXnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965092AbVHZXnz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 19:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965176AbVHZXnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 19:43:55 -0400
Received: from mxsf39.cluster1.charter.net ([209.225.28.166]:4290 "EHLO
	mxsf39.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S965092AbVHZXny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 19:43:54 -0400
X-IronPort-AV: i="3.96,145,1122868800"; 
   d="scan'208"; a="1486214215:sNHT15239200"
Message-ID: <430FA93A.8040103@cybsft.com>
Date: Fri, 26 Aug 2005 18:43:54 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.13-rc7-rt3 compile fix
References: <430F86E7.9020605@cybsft.com> <1125092197.5365.50.camel@localhost.localdomain>
In-Reply-To: <1125092197.5365.50.camel@localhost.localdomain>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> On Fri, 2005-08-26 at 16:17 -0500, K.R. Foley wrote:
> 
>>2.6.13-rc7-rt3 won't compile without the simple patch below.
>> 
> 
> -       __raw_spin_lock(old_owner->task->pi_lock);
> +       __raw_spin_lock(&old_owner->task->pi_lock);
>         TRACE_WARN_ON_LOCKED(plist_empty(&waiter->pi_list));
>         TRACE_WARN_ON_LOCKED(lock_owner(lock));
>  
> @@ -683,7 +683,7 @@
>         }
>         TRACE_WARN_ON_LOCKED(1);
>  ok:
> -       __raw_spin_unlock(old_owner->task->pi_lock);
> +       __raw_spin_unlock(&old_owner->task->pi_lock);
>         return;
> 
> 
> Oops! my bad.  I saw that needed locking, but I didn't have the tracing
> on (I was trying for internal deadlocks), so that part of the code
> wasn't compiling.  If you turn off tracing it would compile :-)

Understood. ;-)

> 
> Anyway, the next time I modify code that's protected by ifdefs, I'll
> change my config and see at least the code compiles.
> 
> Thanks,
> 
> -- Steve
> 
> 
> 


-- 
   kr
