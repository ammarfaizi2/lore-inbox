Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965303AbWGJWsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965303AbWGJWsl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 18:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965307AbWGJWsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 18:48:41 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:45997 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S965303AbWGJWsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 18:48:40 -0400
Subject: Re: [PATCH 1/3] stack overflow safe kdump (2.6.18-rc1-i386) -
	safe_smp_processor_id
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao 
	<fernando@oss.ntt.co.jp>,
       vgoyal@in.ibm.com, akpm@osdl.org, ak@suse.de,
       linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
In-Reply-To: <m1irm5nwyw.fsf@ebiederm.dsl.xmission.com>
References: <1152517852.2120.107.camel@localhost.localdomain>
	 <1152540988.7275.7.camel@mulgrave.il.steeleye.com>
	 <m1irm5nwyw.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Mon, 10 Jul 2006 15:58:16 -0500
Message-Id: <1152565096.4027.4.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-10 at 12:20 -0600, Eric W. Biederman wrote:
> I agree that it shows the problem, and that voyager is different from the
> rest of the x86 implementations. 

As a non-apic based SMP implementation, I don't think there was ever any
dissent about the latter.

> At least for things like the cpumask_t density of processor ids
> is still an interesting property.  The basic issue is that apicids are
> not in general dense on x86.  Not being able compile with support
> for only two cpus because your cpus happen to be apicid 0 and apicid
> 6 by default is an issue.

Density or lack of it is pretty much irrelevant nowadays since the CPU
map iterators are sparse efficient.  Whether x86 PC chooses to avail
itself of this or not is the business of the PC subarch maintainers.
The vast marjority of non-x86 SMP implementations still have sparse (or
at least physical only) CPU maps.

> To some extent this also shows the mess that the x86 subarch code is
> because it is never clear if code is implemented in a subarchitecture
> or not.

Erm, it does?  How?  My statement is that introducing subarch specific
#defines into subarch independent header files is a problem (which it
is).  If you grep for subarch defines in the rest of the arch
independent headers, I don't believe you'll find any.  This would rather
tend to show that for the last seven years, the subarch interface has
been remarkably effective ....

> Fernando can you just put a trivial voyager specific definition of
> safe_smp_processor_id in mach-voyager/voyager_smp.c.  It isn't a fast
> path so the little extra overhead of making two separate functions
> is not an issue and then the generic header doesn't have to have
> subarch breakage.  Just a definition of safe_smp_processor_id().

Yes, that should work.

James


