Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbWFPKZB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWFPKZB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 06:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWFPKZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 06:25:00 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:19865 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751127AbWFPKZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 06:25:00 -0400
Date: Fri, 16 Jun 2006 19:26:54 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Andi Kleen <ak@suse.de>
Cc: ashok.raj@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] avoid cpu hot remove of cpus which have special RT
 tasks.
Message-Id: <20060616192654.50f4f6b7.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <p7364j1qx66.fsf@verdi.suse.de>
References: <20060616162343.02c3ce62.kamezawa.hiroyu@jp.fujitsu.com>
	<p7364j1qx66.fsf@verdi.suse.de>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Jun 2006 11:14:57 +0200
Andi Kleen <ak@suse.de> wrote:

> KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> writes:
> > 
> > This is a bit pessimistic. But forecd migration of RT task which is bounded
> > to the special cpu will cause unpredictable trouble, I think.
> 
> More trouble than running it on a CPU that is about to fail?
> Doubtful.
> 
With my patch, RT tasks will continute to run.

Assume there are some multi-threaded tasks with SCHED_FIFO.
If they uses some kind of synchronization in user land and task is migrated to
other cpus, it will cause dead-lock.


> It seems like a case of "never check for an error you don't know
> how to handle"
> 

"Dont' migrate a task which may fall in dead-lock if it run on another cpu."

-Kame

