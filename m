Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263477AbTDSVqX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 17:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263478AbTDSVqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 17:46:23 -0400
Received: from [12.47.58.203] ([12.47.58.203]:30677 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263477AbTDSVqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 17:46:21 -0400
Date: Sat, 19 Apr 2003 14:58:23 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Prasanta Sadhukhan" <prasanta@tataelxsi.co.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: calling context of unregister_netdev
Message-Id: <20030419145823.4867d595.akpm@digeo.com>
In-Reply-To: <3EA14DD6.4B5983EA@tataelxsi.co.in>
References: <3EA14DD6.4B5983EA@tataelxsi.co.in>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Apr 2003 21:58:13.0731 (UTC) FILETIME=[C651D330:01C306BE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Prasanta Sadhukhan" <prasanta@tataelxsi.co.in> wrote:
>
> So my question is whether we can call unregister_netdev() function from
> interrupt context(i.e, in ISR process context)

No, you cannot.

This is a bug which occurs in multiple places in the pcmcia code.  usually it
is doing illegal things from within timer handlers.  In your case, within
hard IRQ context.

Your fix (using schedule_task()) is fine.  It is the preferred way to resolve
this bug.

