Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269458AbUJFUHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269458AbUJFUHK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 16:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269451AbUJFUDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 16:03:45 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3601 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S269419AbUJFUBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 16:01:18 -0400
Date: Wed, 6 Oct 2004 21:01:14 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       J?rn Engel <joern@wohnheim.fh-wedel.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Console: fall back to /dev/null when no console is availlable
Message-ID: <20041006210114.A16305@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	J?rn Engel <joern@wohnheim.fh-wedel.de>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20041005185214.GA3691@wohnheim.fh-wedel.de> <20041005212712.I6910@flint.arm.linux.org.uk> <20041005210659.GA5276@kroah.com> <20041005221333.L6910@flint.arm.linux.org.uk> <1097074822.29251.51.camel@localhost.localdomain> <20041006174108.GA26797@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041006174108.GA26797@kroah.com>; from greg@kroah.com on Wed, Oct 06, 2004 at 10:41:08AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2004 at 10:41:08AM -0700, Greg KH wrote:
> On Wed, Oct 06, 2004 at 04:00:23PM +0100, Alan Cox wrote:
> > On Maw, 2004-10-05 at 22:13, Russell King wrote:
> > > I'm redirecting them in the /sbin/hotplug script to something sane,
> > > but I think the kernel itself should be directing these three fd's
> > > to somewhere whenever it invokes any user program, even if it is
> > > /dev/null.
> > 
> > Someone should yes. There are lots of fascinating things happen when
> > hotplug opens a system file, it gets assigned fd 2 and then we write to
> > stderr.
> 
> Good point.  So, should we do it in the kernel, in call_usermodehelper,
> so that all users of this function get it correct, or should I do it in
> userspace, in the /sbin/hotplug program?

If we're going to use /dev/console, how about we re-use what Jorn has for
opening the console when starting init(8) ?

(Appologies Jorn - I'm not on a machine which allows me to type foreign
characters, or even cut'n'paste atm.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
