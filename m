Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261788AbVCKVJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbVCKVJj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 16:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbVCKVAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 16:00:30 -0500
Received: from 209-204-138-32.dsl.static.sonic.net ([209.204.138.32]:1032 "EHLO
	graphe.net") by vger.kernel.org with ESMTP id S261367AbVCKU5P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 15:57:15 -0500
Date: Fri, 11 Mar 2005 12:57:07 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@server.graphe.net
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: linux-kernel@vger.kernel.org, Shai Fultheim <Shai@Scalex86.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] del_timer_sync scalability patch
In-Reply-To: <4231E959.141F7D85@tv-sign.ru>
Message-ID: <Pine.LNX.4.58.0503111254270.25992@server.graphe.net>
References: <4231E959.141F7D85@tv-sign.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Mar 2005, Oleg Nesterov wrote:

> I think it is not enough to exchange these 2 lines in
> __run_timers, we also need barriers.

Maybe its best to drop last_running_timer as Ingo suggested.

Replace the magic with a flag that can be set to stop scheduling a timer
again.

Then del_timer_sync may

1. Set the flag not to reschedule
2. delete the timer
3. wait till the timer function is complete
4. (eventually verify that the timer is really gone)
5. reset the no reschedule flag

