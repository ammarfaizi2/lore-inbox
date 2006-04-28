Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964932AbWD1Km5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbWD1Km5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 06:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbWD1Km5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 06:42:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:63671 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964932AbWD1Km5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 06:42:57 -0400
X-Authenticated: #14349625
Subject: Re: [ckrm-tech] Re: [PATCH 0/9] CPU controller
From: Mike Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, Kirill Korotaev <dev@sw.ru>,
       MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>, akpm@osdl.org,
       ckrm-tech@lists.sourceforge.net
In-Reply-To: <200604282026.39520.kernel@kolivas.org>
References: <20060428013730.9582.9351.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
	 <200604282009.41725.kernel@kolivas.org> <1146219372.8067.31.camel@homer>
	 <200604282026.39520.kernel@kolivas.org>
Content-Type: text/plain
Date: Fri, 28 Apr 2006 12:42:51 +0200
Message-Id: <1146220971.17763.11.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-28 at 20:26 +1000, Con Kolivas wrote:
> On Friday 28 April 2006 20:16, Mike Galbraith wrote:
> > > How many tasks? Your function was O(n) so the more tasks the longer that
> > > max value was.
> >
> > Nope.  It's not O(tasks), it's O(occupied_queues).  Occupied queues is
> > generally not a large number.
> 
> Ok well that P4 does about 700,000 context switches per second so 4us sounds 
> large to me.

I'm not always calling it now, only when necessary.  In any case, I'd
much rather pay 4us (it averages 1) every 100ms when at 100% cpu than
take a multi-second latency hit for high priority tasks as now occurs
with a heavy load when the array switch is forced.  This hit is more
likely with my (unfortunately necessary) change to wake tasks on the
expired array.  That's why I started trying to eliminate the switch.

	-Mike

