Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752710AbWKCJJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710AbWKCJJO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 04:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752941AbWKCJJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 04:09:14 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:35038 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1752710AbWKCJJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 04:09:13 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Adrian Bunk <bunk@stusta.de>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, linux-kernel@vger.kernel.org,
       ak@suse.de, discuss@x86-64.org
Subject: Re: 2.6.19-rc1: x86_64 slowdown in lmbench's fork
References: <1162485897.10806.72.camel@localhost.localdomain>
	<m1d5851yxd.fsf@ebiederm.dsl.xmission.com>
	<1162492453.10806.75.camel@localhost.localdomain>
	<20061103021145.GD13381@stusta.de>
Date: Fri, 03 Nov 2006 02:08:42 -0700
In-Reply-To: <20061103021145.GD13381@stusta.de> (Adrian Bunk's message of
	"Fri, 3 Nov 2006 03:11:45 +0100")
Message-ID: <m1bqnozylh.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

> On Thu, Nov 02, 2006 at 10:34:13AM -0800, Tim Chen wrote:
>> On Thu, 2006-11-02 at 11:33 -0700, Eric W. Biederman wrote:
>> 
>> > My only partial guess is that it might be worth adding the per cpu
>> > variables my patch adds without any of the corresponding code changes.
>> > And see if adding variables to the per cpu area is what is causing the
>> > change.
>> > 
>> > The two tests I can see in this line are:
>> > - to add the percpu vector_irq variable.
>> > - to increase NR_IRQs.
>> 
>> Increasing the NR_IRQs resulted in the regression.
>>...
>
> What's your CONFIG_NR_CPUS setting that you are seeing such a big
> regression?

Also could we see the section of System.map that deals with
per cpu variables.

I believe there are some counters for processes and the like
just below kstat whose size increase is causing you real
problems.

Ugh.  I just looked at include/linux/kernel_stat.h
kstat has the per cpu irq counters and all of the cpu process
time accounting so it is quite likely that we are going to be
touching this structure plus the run queues and the process counts
during a fork.  All of which are now potentially much more spread out.

Also has anyone else reproduce this problem yet?

I don't doubt that it exists but having a few more data points or
eyeballs on the problem couldn't hurt.

Eric
