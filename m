Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261852AbSJNPYM>; Mon, 14 Oct 2002 11:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261853AbSJNPYM>; Mon, 14 Oct 2002 11:24:12 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:44664 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S261852AbSJNPYL>; Mon, 14 Oct 2002 11:24:11 -0400
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not suspend devices
References: <200210132359.QAA01092@adam.yggdrasil.com>
	<m1of9xlw7g.fsf@frodo.biederman.org> <1034573925.2786.55.camel@cpq>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Oct 2002 09:28:43 -0600
In-Reply-To: <1034573925.2786.55.camel@cpq>
Message-ID: <m13cr9kpjo.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Blade <eblade@blackmagik.dynup.net> writes:

> Here is where I realize that I've forgotten to CC: the list on all the
> traffic that I keep sending between Eric and Adam.  D'oh.
> 
> 
> On Sun, 2002-10-13 at 20:07, Eric W. Biederman wrote:
> > > 
> > > 	However, I'm not trying to quash what you want to discuss.
> > > I'd be interested in hearing about clarifications and perhaps
> > > extensions of the struct device_driver methods, which I think is what
> > > you're getting at, perhaps here or on linux-hotplug.  It's just that,
> > > for this thread, I'm trying to focus on my patch that eliminates the
> > > software suspend on reboot (pros and cons, alternatives to it, etc.).
> > 
> > The 2.5.41 variant is below.  The bug is reusing the old enumeration value
> > as was previously mentioned.
> > 
> 
> I tried to submit a fix to this, but the only response I've gotten back
> is that it failed to apply.  My original patch excluded the bit from
> device.h that added a new state to the enumeration, and when it got into
> the tree, it got into the tree using the current states that were
> available.  My bad.  
> 
> Eric has already indicated earlier, that Adam's issue is, however, not
> with the changes to drivers/base/power.c but to the changes to the IDE
> driver.  

Correct.  But when people try to use power management they will see
the bug.  SUSPEND_POWER_DOWN (a request for the driver to remove power
from the device) is a very different state from SUSPEND_DETACH (a
request to disassociate the driver from the device).  I am not fully
convinced the two cases should be merged.

SUSPEND_POWER_DOWN as defined should actually cause the behavior Adam
was seeing.  Which made it doubly interesting.

Will you submit a patch detangling this mess?  I believe Adams
only problem was that it did not obviously fix his problem.

Eric



