Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261737AbVCOSTm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbVCOSTm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 13:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbVCOSS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 13:18:58 -0500
Received: from 209-204-138-32.dsl.static.sonic.net ([209.204.138.32]:43780
	"EHLO graphe.net") by vger.kernel.org with ESMTP id S261740AbVCOSPR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 13:15:17 -0500
Date: Tue, 15 Mar 2005 10:15:11 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@server.graphe.net
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: linux-kernel@vger.kernel.org, Shai Fultheim <Shai@Scalex86.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 0/2] del_timer_sync: proof of concept
In-Reply-To: <4237192B.7E8AA85A@tv-sign.ru>
Message-ID: <Pine.LNX.4.58.0503151006550.25689@server.graphe.net>
References: <4231E959.141F7D85@tv-sign.ru> <Pine.LNX.4.58.0503111254270.25992@server.graphe.net>
 <4237192B.7E8AA85A@tv-sign.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I like the idea and it would solve the concerns that we had. The encoding
of a bit in a pointer is weird but we have done that before in the
page_struct.

However, this also means that __run_timers will not free up the timer and
it has to be explicitly freed with del_timer_??. There may be code
that relies on not having to delete a single shot timer after it has been
fired.
