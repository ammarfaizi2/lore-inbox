Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbVFNJHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVFNJHe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 05:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbVFNJHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 05:07:34 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:45785 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261165AbVFNJHP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 05:07:15 -0400
Date: Tue, 14 Jun 2005 11:06:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: dagit@codersbase.com
Cc: Shaohua Li <shaohua.li@intel.com>, stefandoesinger@gmx.at,
       acpi-dev <acpi-devel@lists.sourceforge.net>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: S3 test tool (was : Re: Bizarre oops after suspend to RAM (was: Re: [ACPI] Resume from Suspend to RAM))
Message-ID: <20050614090652.GA1863@elf.ucw.cz>
References: <200506061531.41132.stefandoesinger@gmx.at> <1118125410.3828.12.camel@linux-hp.sh.intel.com> <87ll5diemh.fsf@www.codersbase.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ll5diemh.fsf@www.codersbase.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> If you've looked at this bug you will know that myself at and atleast
> one other person experience a reboot on resume at a specific line in
> the wakeup code:
> http://bugme.osdl.org/show_bug.cgi?id=3586
> 
> One note about the code in the bug, my code for detecting PM is
> backwards, so ignore it, what I say in this email is still valid.
> 
> Specifically, if I get rid of the pushl;popl then the computer does
> not reboot.  See the attached diff.  The question is 1) is this
> pushl;popl the final nail in the coffin? 2) Does windows not clear the
> flags completely, but instead sets them to some "special value"?
> 
> The reason for (1) is because as I understand it, when a certain
> number of illegal operations (3 iirc) are issued at certain times
> (real mode iirc) the machine automatically reboots.  That could be
> what we are seeing here.

You got this wrong. It is three illegal instructions but
*nested*. Like error, error in fault handler, error in doublefault
handler.

Try replacing flags manipulation with any stack manipulation to see
what is wrong.

> Also, what flags are being cleared?  What is their meaning?  Can you
> or someone on this list point me to the approriate documentation?  I'd
> love to look at it and try to understand my hardware better.

Like perhaps processor docs?
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
