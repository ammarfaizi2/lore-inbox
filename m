Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWFWO2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWFWO2K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 10:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWFWO2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 10:28:10 -0400
Received: from rune.pobox.com ([208.210.124.79]:3269 "EHLO rune.pobox.com")
	by vger.kernel.org with ESMTP id S1750776AbWFWO2J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 10:28:09 -0400
Date: Fri, 23 Jun 2006 09:27:46 -0500
From: Nathan Lynch <ntl@pobox.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, pavel@suse.cz,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, clameter@sgi.com, akpm@osdl.org,
       ashok.raj@intel.com, ak@suse.de, nickpiggin@yahoo.com.au, mingo@elte.hu
Subject: Re: [RFC][PATCH] avoid cpu hot removal if busy take3
Message-ID: <20060623142746.GO16029@localdomain>
References: <20060623164042.3a828e8e.kamezawa.hiroyu@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623164042.3a828e8e.kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KAMEZAWA Hiroyuki wrote:
> 
> Now, cpu hot remove migrates all tasks on target cpu by force.
> 
> During cpu-hot-remove, if tsk->cpus_allowed contains the only target
> cpu of removal, tsk->cpus_allowd is disposed and the kernel migrate it to
> any cpu at random. It's obvious that user-land configuration before cpu hot
> removal was bad. This looks a realisitc workaround, but this is not good in
> carefully scheduled environment.
> 
> In this case,
> 1. ignore bad configuration in user-land just do warnings.
> 2. cancel cpu hot removal and warn users to fix the problem and retry.
> seems to be a realisitc workaround. Killing the problematic process may
> cause some trouble in user-land (dead-lock etc..)
> 
> This patch adds sysctl cpu_removal_migration.
> If cpu_removal_migration == 1, all tasks are migrated by force.
> If cpu_removal_migration == 0, cpu_hotremoval can fail because of not-migratable
> tasks.
> 
> Note: cpu scheduler's notifier chain has the highest priority. then, this
>       failure detection will be done at first.

I'm still not convinced that this is a good thing to do.  I reiterate:
this can be implemented in userspace (probably with fewer lines of
code, even).  Why should this policy be in the kernel?


