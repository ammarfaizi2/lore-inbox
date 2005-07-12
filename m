Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbVGLKGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVGLKGG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 06:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVGLKGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 06:06:06 -0400
Received: from [203.171.93.254] ([203.171.93.254]:11149 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261266AbVGLKGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 06:06:04 -0400
Subject: Re: [PATCH] [3/48] Suspend2 2.1.9.8 for 2.6.12:
	301-proc-acpi-sleep-activate-hook.patch
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E1DsHMp-00062f-00@chiark.greenend.org.uk>
References: <11206164393426@foobar.com> <11206164393081@foobar.com>
	 <20050710230347.GB513@infradead.org> <20050710230347.GB513@infradead.org>
	 <1121150703.13869.27.camel@localhost>
	 <E1DsHMp-00062f-00@chiark.greenend.org.uk>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1121162866.13869.142.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 12 Jul 2005 20:07:47 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2005-07-12 at 19:47, Matthew Garrett wrote:
> Nigel Cunningham <ncunningham@cyclades.com> wrote:
> 
> > When the user has an initrd or initramfs, they're supposed to include
> > 
> > echo > /proc/software_suspend/do_resume
> 
> This is a different interface to the one in swsusp, which is under /sys.
> Do we really need to keep multiple interfaces to the same functionality?

We already have that - the reboot handler, acpi S4 support and the sysfs
interface. This should have been asked when sysfs was added :>. For the
sake of backwards compatibility for current suspend2 users, it should
stay for a while at least. The other thing here is that there is much
more to /proc/software_suspend than do_resume.

> > at the point in their initrd where drivers needed for accessing the
> > image, encryption keys and so on have been set up, but the root fs has
> > not yet been mounted. If they don't do that, we should scream loudly,
> > because mounting the root fs (even read only) will replay the journal,
> > making the image not match what is on disk. This in turn can and
> > probably will result in hard disk corruption if they echo to do_resume
> > from say /etc/rc.d/rc.sysinit.
> 
> In general, the kernel does very little to prevent users from shooting
> themselves in the foot (or even chainsawing off their arms). We can do
> these checks in userspace rather than adding more kernel code.

Just because the kernel does very little, that doesn't mean it should.
Particularly for something like suspend to disk, where it's not just a
matter of an oops but of potential hard disk corruption, this is
important.

If I could do it in userspace, I would. The trouble is, the userspace
app may not be there to tell the user what is happening, and this might
be part of the problem.

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

