Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932485AbWFQH3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbWFQH3i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 03:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbWFQH3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 03:29:38 -0400
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:44633 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932485AbWFQH3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 03:29:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=HXnEJW+hii3+07xsQg7ZzHrRoHA/rcIEBOEEH2lMTCmzQCArLewEmfAGpQwOB13+2MaDafS85XS1RJiH09RyZApmEH1ZqgHcX90ahza1m5ACWOxEXcniRcQeCT8a4GB7+Y02hHrA2Eqo01tmyga8NoGuwJX6xdFA59nx4LfYiLo=  ;
Message-ID: <4493AF5C.4080600@yahoo.com.au>
Date: Sat, 17 Jun 2006 17:29:32 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
CC: ak@suse.de, ashok.raj@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] avoid cpu hot remove of cpus which have special
 RT tasks.
References: <20060616162343.02c3ce62.kamezawa.hiroyu@jp.fujitsu.com>	<p7364j1qx66.fsf@verdi.suse.de>	<20060616192654.50f4f6b7.kamezawa.hiroyu@jp.fujitsu.com>	<200606161236.50302.ak@suse.de>	<44937B16.3050204@yahoo.com.au> <20060617141216.dba310af.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060617141216.dba310af.kamezawa.hiroyu@jp.fujitsu.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KAMEZAWA Hiroyuki wrote:
> On Sat, 17 Jun 2006 13:46:30 +1000
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>>If its CPU fails much worse things than that will happen.
>>>
>>>One way might be to break affinity of all processes in the system on hot unplug
>>>- then your deadlock would be avoided - but it might be a bit radical.
>>
>>Agreed. The kernel is just doing some basic fallback behaviour. If you
>>actually have a critical RT system, you probably need to have much more
>>sophisticated handling of CPU unplug anyway. So it doesn't make much
>>sense to complicate the kernel for this.
>>
> 
> But it seems the kernel does what users doesn't want.

But they have to tell it to unplug the CPU, don't they? So if they ask
to unplug it but don't want it to unplug, then the kernel can only do
so much.

Or do we automatically unplug in response to some exceptions nowadays?
In that case, it might be better to have a sysctl that can cause it to
do some other behaviour than unplug.

> threads which is tightly coupled to some cpu has some important meanings for
> the userk.
> If the apps are sophisticated as you say, cpus_allowed containes other cpus
> before hotplug.

Yes, then they'll be able to be migrated without changing their cpumask.
So what's the problem?

> As SIGSTOP/KILL patch I posted, the apps shouldn't do unexpected
> work, I think.

I don't quite understand you here... the kernel doesn't need to enforce
anything but a dumb fallback policy where userspace is otherwise capable
of handling it themselves.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
