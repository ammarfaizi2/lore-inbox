Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262643AbVCSRZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262643AbVCSRZH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 12:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbVCSRYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 12:24:43 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:27558 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261578AbVCSRYk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 12:24:40 -0500
Message-ID: <423C6FB2.56D1A396@tv-sign.ru>
Date: Sat, 19 Mar 2005 21:30:10 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Christoph Lameter <christoph@lameter.com>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 0/5] timers: description
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

These patches are updated version of 'del_timer_sync: proof of concept'
2 patches.

1/5:
	unchanded.

2/5:
	del_timer_sync() simplified. It is not neccessary to unlock and
	retry if __TIMER_PENDING has changed, it is only neccessary if
	timer's base == (timer->_base & ~1) has changed. Also, comments
	are updated.

3/5:
	The reworked del_timer_sync() can't work unless timers are
	serialized wrt to itself. They are not.
	I missed the fact that __mod_timer() can change timer's base
	while the timer is running.

4/5:
	remove memory barrier in __run_timers() and del_timer().

5/5:
	kill ugly __get_base(), it was temporal.


The del_singleshot_timer_sync function now unneeded, but it looks like
additional test for del_timer_sync(), so it will be removed later.

Btw, add_timer_on() is racy against __mod_timer(), is it worth fixing?

Oleg.
