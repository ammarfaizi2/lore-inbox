Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbTFZOm6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 10:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbTFZOm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 10:42:57 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:65029 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261808AbTFZOm4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 10:42:56 -0400
Date: Thu, 26 Jun 2003 10:50:26 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: O(1) scheduler & interactivity improvements
In-Reply-To: <3EFAC408.4020106@aitel.hist.no>
Message-ID: <Pine.LNX.3.96.1030626104733.17562D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jun 2003, Helge Hafting wrote:

> This can be fine-tuned a bit: We may want the pipe-waiter
> to get a _little_ bonus at times, but that has to be
> subtracted from whatever bonus the process at the
> other end of the pipe has.  I.e. no new bonus
> created, just shift some the existing bonus around.
> The "other end" may, after all, have gained legitimate
> bonus from waiting on the disk/network/paging/os, and passing
> some of that on to "clients" might make sense.
> 
> So irman and similar pipe chains wouldn't be able to build
> artifical priority, but if it get some priority
> in an "acceptable" way then it is passed
> along until it expires.
> 
> I.e. "bzcat file.bz2 | grep something | sort | less" could
> pass priority down the chain when bzcat suffers
> a long nfs wait...

This is the case which worries me, passing back the priority of the
process which is waiting for user input. It's desirable, but hard to do
and subject to unintended boosts.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

