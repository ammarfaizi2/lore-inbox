Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262119AbVCHU3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbVCHU3y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 15:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbVCHU2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 15:28:23 -0500
Received: from 209-204-138-32.dsl.static.sonic.net ([209.204.138.32]:26854
	"EHLO graphe.net") by vger.kernel.org with ESMTP id S262241AbVCHUFu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 15:05:50 -0500
Date: Tue, 8 Mar 2005 12:05:38 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@server.graphe.net
To: Andrew Morton <akpm@osdl.org>
cc: Ingo Molnar <mingo@elte.hu>, roland@redhat.com, shai@scalex86.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] del_timer_sync scalability patch
In-Reply-To: <20050308003340.306b8293.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0503081159430.2943@server.graphe.net>
References: <Pine.LNX.4.58.0503072244270.20044@server.graphe.net>
 <20050307233202.1e217aaa.akpm@osdl.org> <20050308081921.GA25679@elte.hu>
 <20050308003340.306b8293.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2005, Andrew Morton wrote:

> If we're prepared to rule that a timer handler is not allowed to do
> add_timer_on() then a recurring timer is permanently pinned to a CPU, isn't
> it?

The process may be rescheduled to run on different processor. Then the
add_timer() function (called from schedule_next_timer in
kernel/posix-timers.c) will also add the timer to the new processor
because it is called from the signal handling code. So I think that it
is possible that a periodic timer will be scheduled on different
processors.
