Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262326AbVAZPON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262326AbVAZPON (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 10:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbVAZPON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 10:14:13 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:33752 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262326AbVAZPOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 10:14:06 -0500
To: Sytse Wielinga <s.b.wielinga@student.utwente.nl>
Cc: "Barry K. Nathan" <barryn@pobox.com>, linux-kernel@vger.kernel.org,
       Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>,
       fastboot@lists.osdl.org, Dave Jones <davej@redhat.com>
Subject: Re: [PATCH 4/29] x86-i8259-shutdown
References: <20050125035930.GG13394@redhat.com>
	<m1sm4phpor.fsf@ebiederm.dsl.xmission.com>
	<20050125094350.GA6372@ip68-4-98-123.oc.oc.cox.net>
	<m1brbdhl3l.fsf@ebiederm.dsl.xmission.com>
	<20050125104904.GB5906@ip68-4-98-123.oc.oc.cox.net>
	<m13bwphflw.fsf@ebiederm.dsl.xmission.com>
	<20050125220229.GB5726@ip68-4-98-123.oc.oc.cox.net>
	<m1651lupjj.fsf@ebiederm.dsl.xmission.com>
	<20050126132741.GA23182@speedy.student.utwente.nl>
	<m1pszsffnp.fsf@ebiederm.dsl.xmission.com>
	<20050126144346.GD23182@speedy.student.utwente.nl>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 26 Jan 2005 08:12:05 -0700
In-Reply-To: <20050126144346.GD23182@speedy.student.utwente.nl>
Message-ID: <m1llagfcmy.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sytse Wielinga <s.b.wielinga@student.utwente.nl> writes:

> On Wed, Jan 26, 2005 at 07:06:50AM -0700, Eric W. Biederman wrote:
> > How does the kernel shutdown fail?
> It halts after saying 'acpi_power_off called'. Strangely, it only breaks when
> using the Alt-SysRq-O poweroff function.  Shutting down normally still powers
> off the system (and does print 'acpi_power_off called'). I think it must have
> something to do with the IDE devices not having powered down before
> acpi_power_off is called, but I haven't seen the code so I have no idea what
> really causes it to break.


I am starting to hate the poor factoring of all of this stuff 
in the kernel.

kernel/power/poweroff.c re-implements the wheel it comes to doing
poweroff a system.  Instead of doing a graceful power off it
skips calling the powerdown notifer and calling device_shutdown.

Since I moved the acpi prepare for powerdown in device_shutdown
it makes sense that code path would now fail.

Do you know if there is any deliberate reason Alt-SysRq-O skips
doing a normal device shutdown work?

If not I think I will just extract a common factor from 
kernel/sys.c/sys_reboot(CMD_POWER_OFF);
And have both code paths call it.


Eric
