Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261805AbVCOTIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbVCOTIf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 14:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbVCOTFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 14:05:20 -0500
Received: from 209-204-138-32.dsl.static.sonic.net ([209.204.138.32]:55564
	"EHLO graphe.net") by vger.kernel.org with ESMTP id S261787AbVCOTCz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 14:02:55 -0500
Date: Tue, 15 Mar 2005 11:02:53 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@server.graphe.net
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: linux-kernel@vger.kernel.org, Shai Fultheim <Shai@Scalex86.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 0/2] del_timer_sync: proof of concept
In-Reply-To: <42373A4C.D9B90D6@tv-sign.ru>
Message-ID: <Pine.LNX.4.58.0503151100210.27117@server.graphe.net>
References: <4231E959.141F7D85@tv-sign.ru> <Pine.LNX.4.58.0503111254270.25992@server.graphe.net>
  <4237192B.7E8AA85A@tv-sign.ru> <Pine.LNX.4.58.0503151006550.25689@server.graphe.net>
 <42373A4C.D9B90D6@tv-sign.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2005, Oleg Nesterov wrote:

> Christoph Lameter wrote:
> >
> > However, this also means that __run_timers will not free up the timer and
> > it has to be explicitly freed with del_timer_??.
>
> I am not sure I understand you but no, del_timer{,_sync} is not needed.
>
> __run_timer deletes timer from base->tv? list and clears 'pending flag'.
>
> __del_timer_sync sets ->_base = NULL, but it is merely optimization.
> It could set ->_base = base, but in that case next del_timer_sync()
> call will need spin_lock(base->lock) again.

For some reason I thought that ->base == NULL would have special
significance outside of the function you discussed. Looks fine to me now.

