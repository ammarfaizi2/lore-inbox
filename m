Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267372AbUIMO0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267372AbUIMO0o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 10:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267411AbUIMO0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 10:26:44 -0400
Received: from holomorphy.com ([207.189.100.168]:61067 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267372AbUIMOYo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 10:24:44 -0400
Date: Mon, 13 Sep 2004 07:24:37 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Albert Cahalan <albert@users.sf.net>
Cc: Ingo Molnar <mingo@elte.hu>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>, cw@f00f.org,
       anton@samba.org
Subject: Re: /proc/sys/kernel/pid_max issues
Message-ID: <20040913142437.GB9106@holomorphy.com>
References: <1095045628.1173.637.camel@cube> <20040913075743.GA15722@elte.hu> <1095083649.1174.1293.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095083649.1174.1293.camel@cube>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-13 at 03:57, Ingo Molnar wrote:
>> this is a pretty sweeping assertion. Would you
>> care to mention a few examples of such hazards?

On Mon, Sep 13, 2004 at 09:54:09AM -0400, Albert Cahalan wrote:
> kill(12345,9)
> setpriority(PRIO_PROCESS,12345,-20)
> sched_setscheduler(12345, SCHED_FIFO, &sp)
> Prior to the call being handled, the process may
> die and be replaced. Some random innocent process,
> or a not-so-innocent one, will get acted upon by
> mistake. This is broken and dangerous.
> Well, it's in the UNIX standard. The best one can
> do is to make the race window hard to hit, with LRU.

How do you propose to queue pid's? This is space constrained. I don't
believe it's feasible and/or desirable to attempt this, as there are
4 million objects to track independent of machine size. The general
tactic of cyclic order allocation is oriented toward making this rare
and/or hard to trigger by having a reuse period long enough that what
processes there are after a pid wrap are likely to have near-indefinite
lifetimes. i.e. it's the closest feasible approximation of LRU. If you
truly want/need reuse to be gone, 64-bit+ pid's are likely best.


-- wli
