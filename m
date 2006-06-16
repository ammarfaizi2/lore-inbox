Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbWFPK4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbWFPK4K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 06:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWFPK4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 06:56:10 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:5541 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751316AbWFPK4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 06:56:09 -0400
Date: Fri, 16 Jun 2006 19:58:07 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Andi Kleen <ak@suse.de>
Cc: ashok.raj@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] avoid cpu hot remove of cpus which have special RT
 tasks.
Message-Id: <20060616195807.84fc0b97.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <200606161236.50302.ak@suse.de>
References: <20060616162343.02c3ce62.kamezawa.hiroyu@jp.fujitsu.com>
	<p7364j1qx66.fsf@verdi.suse.de>
	<20060616192654.50f4f6b7.kamezawa.hiroyu@jp.fujitsu.com>
	<200606161236.50302.ak@suse.de>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jun 2006 12:36:50 +0200
Andi Kleen <ak@suse.de> wrote:

> > Assume there are some multi-threaded tasks with SCHED_FIFO.
> > If they uses some kind of synchronization in user land and task is migrated to
> > other cpus, it will cause dead-lock.
> 
> If its CPU fails much worse things than that will happen.
> 
> One way might be to break affinity of all processes in the system on hot unplug
> - then your deadlock would be avoided - but it might be a bit radical.
> 
Hmm, ok. I undestand your point.
In "cpu is broken, so we have to remove it" case, my patch is harmful.

But (unpredictable) forced migration will cause something bad to user regardless
of scheduling type.

Should we send signal (kill or stop) to tasks whose cpus_allowed only contains
removed cpu rather than simple migration ?
(if this was discussed in past, I'm sorry)


-Kame

