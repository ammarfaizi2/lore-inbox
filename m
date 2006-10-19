Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422864AbWJSKMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422864AbWJSKMt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 06:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423267AbWJSKMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 06:12:49 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:7084 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1422864AbWJSKMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 06:12:48 -0400
Date: Thu, 19 Oct 2006 19:16:23 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: clameter@sgi.com, nickpiggin@yahoo.com.au, suresh.b.siddha@intel.com,
       mingo@elte.hu, pwil3058@bigpond.net.au, linux-kernel@vger.kernel.org,
       "kaneshige.kenji@soft.fujitsu.com" <kaneshige.kenji@soft.fujitsu.com>
Subject: Re: [RFC] sched_tick with interrupts enabled
Message-Id: <20061019191623.5279bc77.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20061018191900.D26521@unix-os.sc.intel.com>
References: <Pine.LNX.4.64.0610181001480.28582@schroedinger.engr.sgi.com>
	<4536629C.4050807@yahoo.com.au>
	<Pine.LNX.4.64.0610181059570.28750@schroedinger.engr.sgi.com>
	<45366DF0.6040702@yahoo.com.au>
	<Pine.LNX.4.64.0610181145250.29163@schroedinger.engr.sgi.com>
	<45367D32.6090301@yahoo.com.au>
	<Pine.LNX.4.64.0610181457130.30795@schroedinger.engr.sgi.com>
	<20061018191900.D26521@unix-os.sc.intel.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2006 19:19:00 -0700
"Siddha, Suresh B" <suresh.b.siddha@intel.com> wrote:

> On Wed, Oct 18, 2006 at 02:59:07PM -0700, Christoph Lameter wrote:
> > load_balancing has the potential of running for some time if f.e.
> > sched_domains for a system with 1024 processors have to be balanced.
> > We currently do all of that with interrupts disabled. So we may be unable
> > to service interrupts for some time. Most of that time is potentially
> > spend in rebalance_tick.
> 
> Did you see an issue because of this or just theoretical?
> 

IIRC, Fujitsu's 64-cpu ia64/SMP system sufferred from this issue *in older kernel*. 
Now, we avoid it by creating NUMA nodes and dividing scheduler domains.

Situation was...:
5 runnable processes which were pinned to a cpu in a 64cpu system.
the system was always rebalanced and seems to be hanged.

-Kame

