Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbVCOIHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbVCOIHR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 03:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbVCOIHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 03:07:13 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:42215 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S262326AbVCOIHE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 03:07:04 -0500
Message-ID: <4236A6FB.2DD06AC@tv-sign.ru>
Date: Tue, 15 Mar 2005 12:12:27 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <christoph@lameter.com>
Cc: linux-kernel@vger.kernel.org, Shai Fultheim <Shai@Scalex86.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] del_timer_sync scalability patch
References: <4231E959.141F7D85@tv-sign.ru> <42343C61.6A1210C0@tv-sign.ru> <Pine.LNX.4.58.0503141134240.31933@server.graphe.net>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
>
> On Sun, 13 Mar 2005, Oleg Nesterov wrote:
>
> > I suspect that del_timer_sync() in its current form is racy.
> >
...snip...
> > next timer interrupt, __run_timers() picks
> > this timer again, sets timer->base = NULL
                      ^^^^^^^^^^^^^^^^^^^^^^^
> >
> > 						if (timer_pending(timer))	// no, timer->base == NULL
>
> timer->base is != NULL because the timer has rescheduled itself.
> __mod_timer sets timer->bBase

Christoph, please look again. Yes, __mod_timer sets timer->base,
but it is cleared in the _next_ timer interrupt on CPU 0.

Andrew, Ingo, what do you think?

Oleg.
