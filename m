Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317576AbSGJRqz>; Wed, 10 Jul 2002 13:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317577AbSGJRqy>; Wed, 10 Jul 2002 13:46:54 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:40434 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317576AbSGJRqx>; Wed, 10 Jul 2002 13:46:53 -0400
Subject: Re: CPU load
From: Robert Love <rml@tech9.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: David Chow <davidchow@shaolinmicro.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020710165443.GA15916@holomorphy.com>
References: <1026312615.6584.18.camel@star15.staff.shaolinmicro.com> 
	<20020710165443.GA15916@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 10 Jul 2002 10:49:29 -0700
Message-Id: <1026323370.1352.70.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-10 at 09:54, William Lee Irwin III wrote:

> Examine the avenrun array declared in kernel/timer.c in a manner similar
> to how loadavg_read_proc() in fs/proc/proc_misc.c does.

David, I wanted to add that we formalized the locking rules on
avenrun[3] a couple kernel revisions ago.

In 2.4, I believe it is implicitly assumed you will do a cli() before
accessing the data (if you want all 3 values to be in sync you need the
read to be safe).

In 2.5, grab a read_lock on xtime_lock and go at it.

	Robert Love

