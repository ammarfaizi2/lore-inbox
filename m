Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268591AbUJFGnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268591AbUJFGnX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 02:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268265AbUJFGnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 02:43:23 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54793 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S268591AbUJFGnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 02:43:12 -0400
Date: Wed, 6 Oct 2004 07:43:05 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Console: fall back to /dev/null when no console is availlable
Message-ID: <20041006074305.A16588@flint.arm.linux.org.uk>
Mail-Followup-To: Andries Brouwer <aebr@win.tue.nl>,
	=?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
	Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20041005185214.GA3691@wohnheim.fh-wedel.de> <20041005212712.I6910@flint.arm.linux.org.uk> <20041005223621.GA4523@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041005223621.GA4523@pclin040.win.tue.nl>; from aebr@win.tue.nl on Wed, Oct 06, 2004 at 12:36:21AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2004 at 12:36:21AM +0200, Andries Brouwer wrote:
> On Tue, Oct 05, 2004 at 09:27:12PM +0100, Russell King wrote:
> > There's a related problem.  /sbin/hotplug.  I keep seeing odd failures
> > from /sbin/hotplug scripts which go away when I ensure that fd0,1,2 are
> > directed at something real.
> 
> Yes. In principle, user space must be able to handle the case
> where no fds 0,1,2 are available. For example in mount.c:
> 
>         while((fd = open("/dev/null", O_RDWR)) == 0 || fd == 1) ;
>         if (fd > 2)
>                 close(fd);
> 
> or so.

That's all well and good in theory, but do you really think that every
single userspace program handles this case correctly?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
