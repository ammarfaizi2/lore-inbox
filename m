Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263096AbTDBVXd>; Wed, 2 Apr 2003 16:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263148AbTDBVXd>; Wed, 2 Apr 2003 16:23:33 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:3601
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S263096AbTDBVXd>; Wed, 2 Apr 2003 16:23:33 -0500
Subject: Re: fairsched + O(1) process scheduler
From: Robert Love <rml@tech9.net>
To: Antonio Vargas <wind@cocodriloo.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20030402213629.GB13168@wind.cocodriloo.com>
References: <20030401125159.GA8005@wind.cocodriloo.com>
	 <20030401164126.GA993@holomorphy.com>
	 <20030401221927.GA8904@wind.cocodriloo.com>
	 <20030402124643.GA13168@wind.cocodriloo.com>
	 <20030402163512.GC993@holomorphy.com>
	 <20030402213629.GB13168@wind.cocodriloo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1049319300.2872.21.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 02 Apr 2003 16:35:00 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-02 at 16:36, Antonio Vargas wrote:

> I've been thinking about this thing a while ago, and I think I could do this:
> 
> a. Have a kernel thread which wakes up on each tick.

Why not use the timer tick itself?  It already calls scheduler_tick()...

Oh, because you need to grab uidhash_lock?  Ew.  Needing a kernel thread
for this is not pretty.

> Also, this locking rule means I can't even read current->user->time_slice?
> What if I changed the type to an atomic_int?

You can always read a single word-sized type atomically.  No need for
atomic_t's.

	Robert Love

