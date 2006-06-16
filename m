Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbWFPKhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWFPKhD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 06:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWFPKhC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 06:37:02 -0400
Received: from cantor.suse.de ([195.135.220.2]:48040 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751263AbWFPKhA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 06:37:00 -0400
From: Andi Kleen <ak@suse.de>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [RFC][PATCH] avoid cpu hot remove of cpus which have special RT tasks.
Date: Fri, 16 Jun 2006 12:36:50 +0200
User-Agent: KMail/1.9.3
Cc: ashok.raj@intel.com, linux-kernel@vger.kernel.org
References: <20060616162343.02c3ce62.kamezawa.hiroyu@jp.fujitsu.com> <p7364j1qx66.fsf@verdi.suse.de> <20060616192654.50f4f6b7.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060616192654.50f4f6b7.kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606161236.50302.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 June 2006 12:26, KAMEZAWA Hiroyuki wrote:
> On 16 Jun 2006 11:14:57 +0200
> Andi Kleen <ak@suse.de> wrote:
> 
> > KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> writes:
> > > 
> > > This is a bit pessimistic. But forecd migration of RT task which is bounded
> > > to the special cpu will cause unpredictable trouble, I think.
> > 
> > More trouble than running it on a CPU that is about to fail?
> > Doubtful.
> > 
> With my patch, RT tasks will continute to run.

That's the problem - if the CPU is failing and you have to remove
it the task will likely corrupt its data or fail in other ways
if it doesn't allow it.

Better to let RT tasks run a little slower on another CPU.

 
> Assume there are some multi-threaded tasks with SCHED_FIFO.
> If they uses some kind of synchronization in user land and task is migrated to
> other cpus, it will cause dead-lock.

If its CPU fails much worse things than that will happen.

One way might be to break affinity of all processes in the system on hot unplug
- then your deadlock would be avoided - but it might be a bit radical.

-Andi

