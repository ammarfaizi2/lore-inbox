Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292931AbSB0U2R>; Wed, 27 Feb 2002 15:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292937AbSB0U1w>; Wed, 27 Feb 2002 15:27:52 -0500
Received: from web12308.mail.yahoo.com ([216.136.173.106]:8 "HELO
	web12308.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S292936AbSB0U0r>; Wed, 27 Feb 2002 15:26:47 -0500
Message-ID: <20020227202645.79987.qmail@web12308.mail.yahoo.com>
Date: Wed, 27 Feb 2002 12:26:45 -0800 (PST)
From: Raghu Angadi <raghuangadi@yahoo.com>
Subject: Re: Fw: memory corruption in tcp bind hash buckets on SMP?
To: kuznet@ms2.inr.ac.ru
Cc: davem@redhat.com, raghuangadi@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <200202272008.XAA10326@ms2.inr.ac.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- kuznet@ms2.inr.ac.ru wrote:
> So, its absence in bind hash must be guaranteed to the time of destruction.
> Look at this from another aspect: imagine you increment refcnt when
> adding to binding table. 

> OK. So, what does guarantee that bucket
> will not remain in bind hash forever? 
ease of finding the bug :). 'cause this would leave tw in the list withought
deleting it.. that would blow tw_bind_bucket_cache pool and that is so much
easier to find. would've been fixed in very early days.. probably in 2.3.0.1
:->. Still not argueing for double refcount. Reversing the removal order
would work too.. now we will have "if (!tw->tb) return;" instead.

> And "it will not" is equivalent
> to "refcnt is not useful".
> 
> Anyway, I will think on this at night, I am not ready to tell how to
> do this right.
> 
> 
> > If you want to avoid timewait_kill() getting called twice altogether.
> 
> Sorry, I did not understand what do you mean here. It can be called
> twice or three times or more. This is impossible to avoid without adding
> spinlock to timewait bucket.

I didn't think you would want to avoid multiple calls to tw_kill() either. 

Raghu.
> Alexey


__________________________________________________
Do You Yahoo!?
Yahoo! Greetings - Send FREE e-cards for every occasion!
http://greetings.yahoo.com
