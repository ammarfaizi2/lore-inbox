Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262317AbVAZOoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262317AbVAZOoW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 09:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbVAZOoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 09:44:21 -0500
Received: from speedy.student.utwente.nl ([130.89.163.131]:31619 "EHLO
	speedy.student.utwente.nl") by vger.kernel.org with ESMTP
	id S262317AbVAZOn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 09:43:57 -0500
Date: Wed, 26 Jan 2005 15:43:46 +0100
From: Sytse Wielinga <s.b.wielinga@student.utwente.nl>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Barry K. Nathan" <barryn@pobox.com>, linux-kernel@vger.kernel.org,
       Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>,
       fastboot@lists.osdl.org, Dave Jones <davej@redhat.com>
Subject: Re: [PATCH 4/29] x86-i8259-shutdown
Message-ID: <20050126144346.GD23182@speedy.student.utwente.nl>
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	"Barry K. Nathan" <barryn@pobox.com>, linux-kernel@vger.kernel.org,
	Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>,
	fastboot@lists.osdl.org, Dave Jones <davej@redhat.com>
References: <20050125035930.GG13394@redhat.com> <m1sm4phpor.fsf@ebiederm.dsl.xmission.com> <20050125094350.GA6372@ip68-4-98-123.oc.oc.cox.net> <m1brbdhl3l.fsf@ebiederm.dsl.xmission.com> <20050125104904.GB5906@ip68-4-98-123.oc.oc.cox.net> <m13bwphflw.fsf@ebiederm.dsl.xmission.com> <20050125220229.GB5726@ip68-4-98-123.oc.oc.cox.net> <m1651lupjj.fsf@ebiederm.dsl.xmission.com> <20050126132741.GA23182@speedy.student.utwente.nl> <m1pszsffnp.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1pszsffnp.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2005 at 07:06:50AM -0700, Eric W. Biederman wrote:
> Sytse Wielinga <s.b.wielinga@student.utwente.nl> writes:
> 
> > On my box this patch breaks shutdown instead, while it was working without it
> > on -rc2-mm1.
> > 
> > I have an Asus A7V8X motherboard with a VIA VT8377 (KT400) north bridge and a
> > VT8235 south bridge (according to lspci). The IO-APIC is used for interrupt
> > routing.
> 
> Hmm.  The patch had a couple of hard coded assumptions about the
> configuration (using ACPI etc), but I don't think it was significant
> enough to break anything.  You have a UP board and a K7 processor
> so my removal of set_cpus_allowed that should not affect anything.
>
> But you are using an SMP kernel or at least the apic support.
Yes, I have only one processor but I am using the IO-APIC.

> Are you using ACPI poweroff?
Yes.

> How does the kernel shutdown fail?
It halts after saying 'acpi_power_off called'. Strangely, it only breaks when
using the Alt-SysRq-O poweroff function. Shutting down normally still powers
off the system (and does print 'acpi_power_off called'). I think it must have
something to do with the IDE devices not having powered down before
acpi_power_off is called, but I haven't seen the code so I have no idea what
really causes it to break.

    Sytse
