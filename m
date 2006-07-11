Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965217AbWGKGVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965217AbWGKGVx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 02:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965219AbWGKGVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 02:21:53 -0400
Received: from ns.oss.ntt.co.jp ([222.151.198.98]:7302 "EHLO
	serv1.oss.ntt.co.jp") by vger.kernel.org with ESMTP id S965217AbWGKGVx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 02:21:53 -0400
Subject: Re: [Fastboot] [PATCH 1/3] stack overflow safe kdump
	(2.6.18-rc1-i386) -	safe_smp_processor_id
From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao 
	<fernando@oss.ntt.co.jp>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, akpm@osdl.org,
       fastboot@lists.osdl.org, ak@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <1152565096.4027.4.camel@mulgrave.il.steeleye.com>
References: <1152517852.2120.107.camel@localhost.localdomain>
	 <1152540988.7275.7.camel@mulgrave.il.steeleye.com>
	 <m1irm5nwyw.fsf@ebiederm.dsl.xmission.com>
	 <1152565096.4027.4.camel@mulgrave.il.steeleye.com>
Content-Type: text/plain
Organization: =?UTF-8?Q?NTT=E3=82=AA=E3=83=BC=E3=83=97=E3=83=B3=E3=82=BD=E3=83=BC?=
	=?UTF-8?Q?=E3=82=B9=E3=82=BD=E3=83=95=E3=83=88=E3=82=A6=E3=82=A7?=
	=?UTF-8?Q?=E3=82=A2=E3=82=BB=E3=83=B3=E3=82=BF?=
Date: Tue, 11 Jul 2006 15:21:50 +0900
Message-Id: <1152598910.2414.74.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Thank you for taking the time to review the code!

On Mon, 2006-07-10 at 15:58 -0500, James Bottomley wrote:
> On Mon, 2006-07-10 at 12:20 -0600, Eric W. Biederman wrote:
> > I agree that it shows the problem, and that voyager is different from the
> > rest of the x86 implementations. 
> 
> As a non-apic based SMP implementation, I don't think there was ever any
> dissent about the latter.
> 
> > At least for things like the cpumask_t density of processor ids
> > is still an interesting property.  The basic issue is that apicids are
> > not in general dense on x86.  Not being able compile with support
> > for only two cpus because your cpus happen to be apicid 0 and apicid
> > 6 by default is an issue.
> 
> Density or lack of it is pretty much irrelevant nowadays since the CPU
> map iterators are sparse efficient.  Whether x86 PC chooses to avail
> itself of this or not is the business of the PC subarch maintainers.
> The vast marjority of non-x86 SMP implementations still have sparse (or
> at least physical only) CPU maps.
> 
> > To some extent this also shows the mess that the x86 subarch code is
> > because it is never clear if code is implemented in a subarchitecture
> > or not.
> 
> Erm, it does?  How?  My statement is that introducing subarch specific
> #defines into subarch independent header files is a problem (which it
> is).  If you grep for subarch defines in the rest of the arch
> independent headers, I don't believe you'll find any.  This would rather
> tend to show that for the last seven years, the subarch interface has
> been remarkably effective ....
> 
> > Fernando can you just put a trivial voyager specific definition of
> > safe_smp_processor_id in mach-voyager/voyager_smp.c.  It isn't a fast
> > path so the little extra overhead of making two separate functions
> > is not an issue and then the generic header doesn't have to have
> > subarch breakage.  Just a definition of safe_smp_processor_id().
> 
> Yes, that should work.
Done. I hope I got it right this time. Anyway, if there is something
incorrect in the new patches (1/4 and 2/4 in particular) let me know.

Regards,

Fernando

