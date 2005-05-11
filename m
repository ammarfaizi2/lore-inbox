Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbVEKO7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbVEKO7T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 10:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbVEKO7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 10:59:19 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:6819 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261234AbVEKO6s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 10:58:48 -0400
Message-ID: <42821F65.3FEA7939@tv-sign.ru>
Date: Wed, 11 May 2005 19:06:13 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S.Miller" <davem@davemloft.net>
Cc: christoph@lameter.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       "Venkatesan, Ganesh" <ganesh.venkatesan@intel.com>
Subject: Re: [RFC][PATCH] timers fixes/improvements
References: <Pine.LNX.4.58.0505091449580.29090@graphe.net>
		<42808B84.BCC00574@tv-sign.ru>
		<Pine.LNX.4.58.0505101212350.20718@graphe.net> <20050510.125301.59655362.davem@davemloft.net>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Btw, i think that drivers/net/e1000/e1000_main.c:e1000_down() is buggy.

It calls del_timer_sync(&adapter->watchdog_timer), but e1000_watchdog()
calls schedule_work(e1000_watchdog_task), so the work could be queued
after del_timer_sync().

And e1000_watchdog_task() arms timers again.

Note that it's not enough to do flush_scheduled_work() here.

Oleg.
