Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbVFNPvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVFNPvg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 11:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVFNPvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 11:51:36 -0400
Received: from smtp-auth.no-ip.com ([8.4.112.95]:43180 "HELO
	smtp-auth.no-ip.com") by vger.kernel.org with SMTP id S261171AbVFNPvd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 11:51:33 -0400
From: dagit@codersbase.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Shaohua Li <shaohua.li@intel.com>, stefandoesinger@gmx.at,
       acpi-dev <acpi-devel@lists.sourceforge.net>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: S3 test tool (was : Re: Bizarre oops after suspend to RAM (was:
 Re: [ACPI] Resume from Suspend to RAM))
References: <200506061531.41132.stefandoesinger@gmx.at>
	<1118125410.3828.12.camel@linux-hp.sh.intel.com>
	<87ll5diemh.fsf@www.codersbase.com> <20050614090652.GA1863@elf.ucw.cz>
Organization: Coders' Base
Date: Tue, 14 Jun 2005 08:51:26 -0700
In-Reply-To: <20050614090652.GA1863@elf.ucw.cz> (Pavel Machek's message of
 "Tue, 14 Jun 2005 11:06:52 +0200")
Message-ID: <87aclthr7l.fsf@www.codersbase.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-REPORT-SPAM-TO: abuse@no-ip.com
X-NO-IP: codersbase.com@noip-smtp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

> Hi!
>
>> If you've looked at this bug you will know that myself at and atleast
>> one other person experience a reboot on resume at a specific line in
>> the wakeup code:
>> http://bugme.osdl.org/show_bug.cgi?id=3586
>> 
>> One note about the code in the bug, my code for detecting PM is
>> backwards, so ignore it, what I say in this email is still valid.
>> 
>> Specifically, if I get rid of the pushl;popl then the computer does
>> not reboot.  See the attached diff.  The question is 1) is this
>> pushl;popl the final nail in the coffin? 2) Does windows not clear the
>> flags completely, but instead sets them to some "special value"?
>> 
>> The reason for (1) is because as I understand it, when a certain
>> number of illegal operations (3 iirc) are issued at certain times
>> (real mode iirc) the machine automatically reboots.  That could be
>> what we are seeing here.
>
> You got this wrong. It is three illegal instructions but
> *nested*. Like error, error in fault handler, error in doublefault
> handler.

Ah.  Yeah, this isn't an area I know much about :)  Thanks for the
correction. 

> Try replacing flags manipulation with any stack manipulation to see
> what is wrong.

Do you mean try something like this? Replace the push 0 with push
0x1234 ; push 0x1234 ; pop ; pop and try to figure out which line
causes the reboot?

> Like perhaps processor docs?

Is that what I want to look at?  I was the one asking the question. ;)

Thanks,
Jason

