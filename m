Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265197AbUFMQA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265197AbUFMQA1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 12:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265201AbUFMQA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 12:00:26 -0400
Received: from gprs214-6.eurotel.cz ([160.218.214.6]:24448 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265197AbUFMQAY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 12:00:24 -0400
Date: Sun, 13 Jun 2004 17:59:59 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       herbert@gondor.apana.org.au, mochel@digitalimplant.org,
       linux-kernel@vger.kernel.org
Subject: Re: Fix memory leak in swsusp
Message-ID: <20040613155959.GB2683@elf.ucw.cz>
References: <20040610105629.GA367@gondor.apana.org.au> <20040610212448.GD6634@elf.ucw.cz> <20040610233707.GA4741@gondor.apana.org.au> <20040611094844.GC13834@elf.ucw.cz> <20040611101655.GA8208@gondor.apana.org.au> <20040611102327.GF13834@elf.ucw.cz> <20040611110314.GA8592@gondor.apana.org.au> <40CA75CA.2030209@linuxmail.org> <20040611210059.2522e02d.akpm@osdl.org> <20040612111016.GA23441@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040612111016.GA23441@redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > >  We were avoiding the use of memcpy because it messes up the preempt count with 3DNow, and 
>  > >  potentially as other unseen side effects. The preempt could possibly simply be reset at resume time, 
>  > >  but the point remains.
>  > 
>  > eh?  memcpy just copies memory.  Maybe your meant copy_*_user()?
> 
> See arch/i386/lib/memcpy.c  The 3dnow routine does kernel_fpu_begin()/..end()
> which futzes with preempt count.  What I'm missing though is that the count
> afterwards should be the same as it was before the memcpy. Why is this
> a problem for the suspend folks?

It does not hurt here, but as someone else explained already it is a
problem when doing atomic copy of memory. (You increment, than copy
whole memory, you decrement; but you only decrement in original, not
in copy...)
									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
