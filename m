Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262144AbVAYVCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262144AbVAYVCU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 16:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbVAYU7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 15:59:05 -0500
Received: from orb.pobox.com ([207.8.226.5]:39879 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262128AbVAYU5W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 15:57:22 -0500
Date: Tue, 25 Jan 2005 12:57:14 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Barry K. Nathan" <barryn@pobox.com>, linux-kernel@vger.kernel.org,
       Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>,
       fastboot@lists.osdl.org, Dave Jones <davej@redhat.com>
Subject: Re: [PATCH 4/29] x86-i8259-shutdown
Message-ID: <20050125205714.GA5726@ip68-4-98-123.oc.oc.cox.net>
References: <x86-i8259-shutdown-11061198973856@ebiederm.dsl.xmission.com> <1106623970.2399.205.camel@d845pe> <20050125035930.GG13394@redhat.com> <m1sm4phpor.fsf@ebiederm.dsl.xmission.com> <20050125094350.GA6372@ip68-4-98-123.oc.oc.cox.net> <m1brbdhl3l.fsf@ebiederm.dsl.xmission.com> <20050125104904.GB5906@ip68-4-98-123.oc.oc.cox.net> <m17jm1hh41.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m17jm1hh41.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 04:40:14AM -0700, Eric W. Biederman wrote:
> Cool I wonder how many more bugs work on kexec can flush out?

BTW, I got your other e-mail with the patch. I'll see if I can try the
patch sometime in the next few hours.

> > 3. "Shutdown: hda
> >     Power down."
> > 
> > You (or I, at least) would expect things to stop here, but we enter the
> > Twilight Zone instead:
> 
> So would I.
>  
> > 4. "Kernel panic - not syncing: Attempted to kill init!" (Nothing this
> > weird ever happens if I have ACPI enabled. In that case it either
> > freezes or properly shuts down.)
> 
> What lines are printed just before that?  It would be nice
> to know which part of the kernel panic if we can.
> 
> At least if you can reproduce this that would be nice.

100% reproducible for me:

---begin quote---
Shutdown: hda
Power down.
Kernel panic - not syncing: Attempted to kill init!
---end quote---

> I wonder if APM is really disabled at this point.  I guess since
> I have found the ACPI bug we can save the APM bug for later.

Earlier in boot it says "apm: bios not found" or something like that. I
can try again without ACPI or APM compiled into the kernel at all and
see what happens. (IIRC, on all of my systems with working APM, the patch
doesn't introduce any problems -- shutdown just works.)

> > If anyone's interested, the source code to my minimal /sbin/init is
> > here:
> > http://bugme.osdl.org/attachment.cgi?id=4398&action=view
> 
> Interesting.  
> 
> I am wondering if you see the same symptoms if you make this
> your /init in a initcpio.gz.  I am wondering if some of the
> issues might be related to something not being shutdown properly.

Yeah, I need to give that a try, but it's possible that I won't be able
to do that for a couple of days.

> > The problem occurs even with no other kexec patches applied. And
> > applying all kexec patches except the i8259 shutdown patch fails to
> > reproduce the problem.
> 
> Very odd.   I was wondering how many test cases had run, before I found
> the acpi bug above.  If the problem was not 100% the correlation with
> this patch might have been a fluke.  I just want to be certain.

For me, it's absolute 100% correlation over 20-30 test runs or so
(unfortunately it didn't occur to me to keep an exact count).

> Well if you can help me track this down I would appreciate it.
> 
> Do you think you would have time to try some test patches?

Yes, I should have time to test patches.

-Barry K. Nathan <barryn@pobox.com>
