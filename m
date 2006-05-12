Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbWELLlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbWELLlV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 07:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWELLlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 07:41:21 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:9409 "EHLO pilet.ens-lyon.fr")
	by vger.kernel.org with ESMTP id S1751240AbWELLlT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 07:41:19 -0400
Date: Fri, 12 May 2006 13:41:42 +0200
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: john stultz <johnstul@us.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc3-mm1
Message-ID: <20060512114142.GD6876@ens-lyon.fr>
References: <20060501014737.54ee0dd5.akpm@osdl.org> <40f323d00605030211t78e41d18h298c8be3721a135a@mail.gmail.com> <20060503064816.ef7ec2b7.akpm@osdl.org> <1146665732.27820.75.camel@localhost.localdomain> <20060503144318.GA5505@ens-lyon.fr> <20060505150509.GA16562@ens-lyon.fr> <1146911438.7467.13.camel@localhost.localdomain> <1147110520.13441.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147110520.13441.4.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2006 at 10:48:39AM -0700, john stultz wrote:
> On Sat, 2006-05-06 at 10:30 +0000, Thomas Gleixner wrote:
> > > and when urxvtd hanged I had the following in dmesg:
> > > [  356.696000] urxvtd: empty nanosleep 356726124322 17948911854451
> > > 
> > > So I suppose something is wrong in ktime_add()
> > 
> > Well, ktime_add is adding two 64 bit values.
> > 
> > The delta between the two values is 0xFFFFFFB3451. That looks like the
> > timekeeping on your box is screwed by 0x100000000000. 
> > 
> > John, any idea ?
> 
> I suspect the system is falling back to the PIT instead of the ACPI PM
> due to mis-merged patch in 2.6.17-rc3-mm1. The PIT has had a few reports
> of problems, and I've got a test patch which I'm waiting for some
> results on from a tester before sending (I can't reproduce the issue
> locally).
> 
> Applying the patch here should get the ACPI PM working again.
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=f0ec5e39765cd254d436a6d86e211d81795952a4;hp=30d55280b867aa0cae99f836ad0181bb0bf8f9cb

I am running with the above patch for few days and I couldn't reproduce
the bug with it. So it looks good.

Thanks,

Benoit

-- 
powered by bash/screen/(urxvt/fvwm|linux-console)/gentoo/gnu/linux OS
