Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261743AbVCOSkC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbVCOSkC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 13:40:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbVCOSiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 13:38:17 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:28847 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261647AbVCOSff (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 13:35:35 -0500
Message-ID: <42373A4C.D9B90D6@tv-sign.ru>
Date: Tue, 15 Mar 2005 22:41:00 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <christoph@lameter.com>
Cc: linux-kernel@vger.kernel.org, Shai Fultheim <Shai@Scalex86.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 0/2] del_timer_sync: proof of concept
References: <4231E959.141F7D85@tv-sign.ru> <Pine.LNX.4.58.0503111254270.25992@server.graphe.net>
	 <4237192B.7E8AA85A@tv-sign.ru> <Pine.LNX.4.58.0503151006550.25689@server.graphe.net>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
>
> However, this also means that __run_timers will not free up the timer and
> it has to be explicitly freed with del_timer_??.

I am not sure I understand you but no, del_timer{,_sync} is not needed.

__run_timer deletes timer from base->tv? list and clears 'pending flag'.

__del_timer_sync sets ->_base = NULL, but it is merely optimization.
It could set ->_base = base, but in that case next del_timer_sync()
call will need spin_lock(base->lock) again.

Oleg.
