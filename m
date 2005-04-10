Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261595AbVDJUPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbVDJUPT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 16:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbVDJUPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 16:15:18 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:25041 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261595AbVDJUPM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 16:15:12 -0400
Date: Sun, 10 Apr 2005 22:14:55 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Oliver Neukum <oliver@neukum.org>
Cc: Andreas Steinmetz <ast@domdv.de>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] zero disk pages used by swsusp on resume
Message-ID: <20050410201455.GA21568@elf.ucw.cz>
References: <42592697.8060909@domdv.de> <200504102040.38403.oliver@neukum.org> <42597E99.8010802@domdv.de> <200504102203.29602.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504102203.29602.oliver@neukum.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Oliver Neukum wrote:
> > > What is the point in doing so after they've rested on the disk for ages?
> > 
> > The point is not physical access to the disk but data gathering after
> > resume or reboot.
> 
> After resume or reboot normal access control mechanisms will work
> again. Those who can read a swap partition under normal circumstances
> can also read /dev/kmem. It seems to me like you are putting an extra
> lock on a window on the third floor while leaving the front door open.

Andreas is right, his patches are needed.

Currently, if your laptop is stolen after resume, they can still data
in swsusp image.

Zeroing the swsusp pages helps a lot here, because at least they are
not getting swsusp image data without heavy tools. [Or think root
compromise month after you used swsusp.]

Encrypting swsusp image is of course even better, because you don't
have to write large ammounts of zeros to your disks during resume ;-).

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
