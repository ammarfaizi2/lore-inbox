Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264850AbSJVSwe>; Tue, 22 Oct 2002 14:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264833AbSJVSwe>; Tue, 22 Oct 2002 14:52:34 -0400
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:55186 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S264834AbSJVSwd>; Tue, 22 Oct 2002 14:52:33 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: Mark Mielke <mark@mark.mielke.cc>
Subject: Re: Use of yield() in the kernel
Date: Tue, 22 Oct 2002 20:58:55 +0200
User-Agent: KMail/1.4.7
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@digeo.com>
References: <200210151536.39029.baldrick@wanadoo.fr> <200210201110.33254.baldrick@wanadoo.fr> <20021022172404.GB1314@mark.mielke.cc>
In-Reply-To: <20021022172404.GB1314@mark.mielke.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200210222058.55621.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 October 2002 19:24, Mark Mielke wrote:
> Would it be sensible to add a "yield_short()" function to the kernel?

You can do:

set_current_state(TASK_RUNNING);
schedule();

I'm not clear on what you are guaranteed to get - for example,
it looks as if it can sometimes return without sleeping at all.
There is also cond_resched(), which is

static inline void cond_resched(void)
{
        if (need_resched())
                __cond_resched();
}

void __cond_resched(void)
{
        set_current_state(TASK_RUNNING);
        schedule();
}

I don't know when need_resched evaluates to true, I haven't
had time to look into this yet.

Ciao, Duncan.
