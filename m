Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265978AbUJEVPB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265978AbUJEVPB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 17:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265331AbUJEVPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 17:15:00 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:56592 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265978AbUJEVNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 17:13:38 -0400
Date: Tue, 5 Oct 2004 22:13:33 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: J?rn Engel <joern@wohnheim.fh-wedel.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Console: fall back to /dev/null when no console is availlable
Message-ID: <20041005221333.L6910@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	J?rn Engel <joern@wohnheim.fh-wedel.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20041005185214.GA3691@wohnheim.fh-wedel.de> <20041005212712.I6910@flint.arm.linux.org.uk> <20041005210659.GA5276@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041005210659.GA5276@kroah.com>; from greg@kroah.com on Tue, Oct 05, 2004 at 02:06:59PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2004 at 02:06:59PM -0700, Greg KH wrote:
> On Tue, Oct 05, 2004 at 09:27:12PM +0100, Russell King wrote:
> > On Tue, Oct 05, 2004 at 08:52:14PM +0200, J?rn Engel wrote:
> > > Looks pretty trivial, but opinions on this subject may vary.
> > > Comments?
> > 
> > There's a related problem.  /sbin/hotplug.  I keep seeing odd failures
> > from /sbin/hotplug scripts which go away when I ensure that fd0,1,2 are
> > directed at something real.
> 
> Which scripts cause this problem?

I have no idea.  Somewhere in the depths of the Red Hat networking
scripts.  There's multiple of them calling multiple other programs
and it's impossible to debug what's going on.  All I know is that
IPv6 doesn't get configured if fd0,1,2 are closed, but does if they're
open.

It could be a script, or some other program.  There's no way to tell.

> > It's rather annoying because it currently means that, when my PCMCIA net
> > interface on the firewall comes up, the IPv4 configuration works fine
> > but IPv6 configuration falls dead on its nose without any explaination
> > why.
> > 
> > And, like I say, redirecting fd0,1,2 fixes it.
> 
> Redirecting it in the script itself?  Or in the kernel like this patch?

I'm redirecting them in the /sbin/hotplug script to something sane,
but I think the kernel itself should be directing these three fd's
to somewhere whenever it invokes any user program, even if it is
/dev/null.

I think Alan disagrees with me, but I think the history that these
types of problems _keep_ cropping up over and over is proof enough
that it's necessary for sane userspace.

(Another example which is happening _now_: having /sbin/init die over
 a suspend/resume cycle because you have no system console on your
 embedded device isn't nice.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
