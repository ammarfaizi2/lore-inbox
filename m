Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbWGKTmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWGKTmK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 15:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbWGKTmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 15:42:09 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:38610 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751215AbWGKTmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 15:42:08 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Fernando Luis =?iso-8859-1?Q?V=E1zquez?= Cao 
	<fernando@oss.ntt.co.jp>,
       vgoyal@in.ibm.com, akpm@osdl.org, ak@suse.de,
       linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
Subject: Re: [PATCH 1/3] stack overflow safe kdump (2.6.18-rc1-i386) - safe_smp_processor_id
References: <1152517852.2120.107.camel@localhost.localdomain>
	<1152540988.7275.7.camel@mulgrave.il.steeleye.com>
	<m1irm5nwyw.fsf@ebiederm.dsl.xmission.com>
	<1152565096.4027.4.camel@mulgrave.il.steeleye.com>
	<m18xn0lsdq.fsf@ebiederm.dsl.xmission.com>
	<1152621374.3575.1.camel@mulgrave.il.steeleye.com>
Date: Tue, 11 Jul 2006 13:41:03 -0600
In-Reply-To: <1152621374.3575.1.camel@mulgrave.il.steeleye.com> (James
	Bottomley's message of "Tue, 11 Jul 2006 08:36:14 -0400")
Message-ID: <m1mzbgexps.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@SteelEye.com> writes:

> On Mon, 2006-07-10 at 21:42 -0600, Eric W. Biederman wrote:
>> But I do agree the subarch header files are clean.
>> And no this case except for the fact no one realized that the
>> code doesn't even compile on voyager does not show how brittle
>> the x86 subarch code is.    Except for the fact that it seems
>> obvious that kernel/smp.c is generic code that every smp subarch
>> would use.
>
> OK ... that's the mistaken assumption.  kernel/smp.c is not subarch
> generic, it's APIC specific.  So all apic using subarchs, which is
> pretty much everything except voyager, use it.  Since voyager uses
> vic/qic based smp harness, it has its own version of this file (in fact
> voyager has a completely separate SMP HAL).

Yep.  My point is that with the current subarch structure on x86 it is
really easy to make mistaken assumptions like kernel/smp.c applies to
all x86 subarchitectures, because the lines are not clear.  The
architectures where I have seen that the lines are clear generally
allow for building a single kernel that can boot on any subarch.

My hope is that we can recognized how non-obvious the x86 subarch code
is so that future work will be able to improve the situation.

To give credit I do think the division of labor between the subarch's
appears sound.  I just don't like how the subarches are glued together
into the x86 arch.

Eric
