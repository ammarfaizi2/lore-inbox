Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261876AbVAYKQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbVAYKQA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 05:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbVAYKQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 05:16:00 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:47571 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261876AbVAYKPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 05:15:54 -0500
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
       Andrew Morton <akpm@osdl.org>, fastboot@lists.osdl.org,
       Dave Jones <davej@redhat.com>
Subject: Re: [PATCH 4/29] x86-i8259-shutdown
References: <x86-i8259-shutdown-11061198973856@ebiederm.dsl.xmission.com>
	<1106623970.2399.205.camel@d845pe> <20050125035930.GG13394@redhat.com>
	<m1sm4phpor.fsf@ebiederm.dsl.xmission.com>
	<20050125094350.GA6372@ip68-4-98-123.oc.oc.cox.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 25 Jan 2005 03:14:06 -0700
In-Reply-To: <20050125094350.GA6372@ip68-4-98-123.oc.oc.cox.net>
Message-ID: <m1brbdhl3l.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Barry K. Nathan" <barryn@pobox.com> writes:

> On Tue, Jan 25, 2005 at 01:35:00AM -0700, Eric W. Biederman wrote:
> > So I will ask again, as I did when Andrew first pointed this in my
> > direction.  What code path in the kernel could possibly care if we
> > disable the i8259 after we have disabled all of the other hardware in
> > the system.
> 
> This may be a foolish question, but, are there possibly any code paths
> in the *BIOS* that could care?

Fairly unlikely at this point, as the state we have traditionally
reprogrammed the i8259 to, delivers interrupts to different vectors
than the firmware uses.   So I don't see how telling it not
to deliver interrupts where the firmware won't expect them
is likely to change things.

It could be that ACPI AML code is trying something at an inappropriate 
time.  But I can not even find the ACPI soft power code path.  pm_power_off
never seems to get hooked. 

Or it could one of the other kexec related patches for all I know.

Until I get a good data point or a reproducer I can't do anything.
It doesn't even make sense to drop the patch because then
I won't get a good data point.  And I won't know if similar symptoms
crop of if I need to do something else.

Eric
