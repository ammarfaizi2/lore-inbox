Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266775AbUIMN5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266775AbUIMN5T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 09:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266786AbUIMN5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 09:57:19 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:42233 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266775AbUIMN5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 09:57:13 -0400
Subject: Re: /proc/sys/kernel/pid_max issues
From: Albert Cahalan <albert@users.sf.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       wli@holomorphy.com, cw@f00f.org, anton@samba.org
In-Reply-To: <20040913075743.GA15722@elte.hu>
References: <1095045628.1173.637.camel@cube>
	 <20040913075743.GA15722@elte.hu>
Content-Type: text/plain
Organization: 
Message-Id: <1095083649.1174.1293.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 13 Sep 2004 09:54:09 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-13 at 03:57, Ingo Molnar wrote:
> * Albert Cahalan <albert@users.sf.net> wrote:
> 
> > I'd much prefer LRU allocation. There are
> > lots of system calls that take PID values.
> > All such calls are hazardous. They're pretty
> > much broken by design.
> 
> this is a pretty sweeping assertion. Would you
> care to mention a few examples of such hazards?

kill(12345,9)
setpriority(PRIO_PROCESS,12345,-20)
sched_setscheduler(12345, SCHED_FIFO, &sp)

Prior to the call being handled, the process may
die and be replaced. Some random innocent process,
or a not-so-innocent one, will get acted upon by
mistake. This is broken and dangerous.

Well, it's in the UNIX standard. The best one can
do is to make the race window hard to hit, with LRU.

> > BTW, since pid_max is now adjustable, reducing
> > the default to 4 digits would make sense. [...]
> 
> i'm not sure what you mean by 'now', pid_max has
> been adjustable for quite some time.

2.6.x series I believe, not 2.4.xx series


