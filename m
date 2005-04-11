Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbVDKDY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbVDKDY6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 23:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbVDKDY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 23:24:58 -0400
Received: from ultra7.eskimo.com ([204.122.16.70]:36358 "EHLO
	ultra7.eskimo.com") by vger.kernel.org with ESMTP id S261677AbVDKDYv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 23:24:51 -0400
Date: Sun, 10 Apr 2005 20:23:40 -0700
From: Elladan <elladan@eskimo.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Oliver Neukum <oliver@neukum.org>, Andreas Steinmetz <ast@domdv.de>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] zero disk pages used by swsusp on resume
Message-ID: <20050411032340.GC9933@eskimo.com>
References: <42592697.8060909@domdv.de> <200504102040.38403.oliver@neukum.org> <42597E99.8010802@domdv.de> <200504102203.29602.oliver@neukum.org> <20050410201455.GA21568@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050410201455.GA21568@elf.ucw.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2005 at 10:14:55PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > Oliver Neukum wrote:
> > > > What is the point in doing so after they've rested on the disk for ages?
> > > 
> > > The point is not physical access to the disk but data gathering after
> > > resume or reboot.
> > 
> > After resume or reboot normal access control mechanisms will work
> > again. Those who can read a swap partition under normal circumstances
> > can also read /dev/kmem. It seems to me like you are putting an extra
> > lock on a window on the third floor while leaving the front door open.
> 
> Andreas is right, his patches are needed.
> 
> Currently, if your laptop is stolen after resume, they can still data
> in swsusp image.
> 
> Zeroing the swsusp pages helps a lot here, because at least they are
> not getting swsusp image data without heavy tools. [Or think root
> compromise month after you used swsusp.]
> 
> Encrypting swsusp image is of course even better, because you don't
> have to write large ammounts of zeros to your disks during resume ;-).

How does zeroing help if they steal the laptop?  The data is there, they
can just pull the hard disk out and mirror it before they boot.

The only way to improve security here is to encrypt it.  Zeroing will
help some if they compromise root later, but I doubt that's really worth
it considering you're screwed after a root compromise anyway.

-J

