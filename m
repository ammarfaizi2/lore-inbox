Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319155AbSIKPmd>; Wed, 11 Sep 2002 11:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319160AbSIKPmd>; Wed, 11 Sep 2002 11:42:33 -0400
Received: from mx2.elte.hu ([157.181.151.9]:57261 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S319155AbSIKPmc>;
	Wed, 11 Sep 2002 11:42:32 -0400
Date: Wed, 11 Sep 2002 17:52:56 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Oleg Drokin <green@namesys.com>
Cc: Jens Axboe <axboe@suse.de>, Robert Love <rml@tech9.net>,
       Thomas Molina <tmolina@cox.net>, <linux-kernel@vger.kernel.org>,
       <andre@linux-ide.org>
Subject: Re: 2.5 Problem Status Report
In-Reply-To: <Pine.LNX.4.44.0209111745530.19474-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209111752001.19738-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  -	preempt_count()--; \
>  +	if (!--preempt_count()) \
>  +		BUG(); \

and that should be:

  -	preempt_count()--; \
  +	if (!preempt_count()--) \
  +		BUG(); \

ie. we try to check whether a 0 preempt count is decreased to -1.

	Ingo

