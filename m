Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbVKWMDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbVKWMDN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 07:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbVKWMDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 07:03:13 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:24714
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1750729AbVKWMDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 07:03:11 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Neil Brown <neilb@suse.de>
Subject: Re: pivot_root broken in 2.6.15-rc1-mm2
Date: Wed, 23 Nov 2005 06:02:52 -0600
User-Agent: KMail/1.8
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org
References: <17283.52960.913712.454816@cse.unsw.edu.au> <20051123021545.GP27946@ftp.linux.org.uk> <17283.56197.347658.787608@cse.unsw.edu.au>
In-Reply-To: <17283.56197.347658.787608@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511230602.53960.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 November 2005 21:01, Neil Brown wrote:
> Ah, OK.
> It's just that pivot_root works in this context in 2.6.11.9, so I
> figured it was a breakage.

And if you then umount the ramfs you just pivoted, the kernel locks hard.

That was a bug.

What you're looking for is switch_root, which has variants buried in klib, or 
in the current CVS version of busybox, or glued into Red Hat's weird little 
multi-function ramdisk shell, and probably a few other places by now.

Rather than unmounting rootfs, it deletes everything out of it to free up the 
space.  (It basically does the functional equivalent of "find / -xdev | xargs 
rm -rf", overmounts the old root with the new root, does a chroot, and execs 
the new init out of the new root.  Actually getting it right's a bit tricky, 
of course.  I still need to test the busybox version a whole lot more.  It's 
on my to-do list...)

Rob
