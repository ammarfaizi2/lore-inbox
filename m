Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262197AbVBKGqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbVBKGqp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 01:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbVBKGqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 01:46:44 -0500
Received: from lyle.provo.novell.com ([137.65.81.174]:55601 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S262197AbVBKGqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 01:46:42 -0500
Subject: Re: [ANNOUNCE] hotplug-ng 001 release
From: Greg KH <gregkh@suse.de>
To: Bill Nottingham <notting@redhat.com>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20050211031823.GE29375@nostromo.devel.redhat.com>
References: <20050211004033.GA26624@suse.de>
	 <20050211031823.GE29375@nostromo.devel.redhat.com>
Content-Type: text/plain
Date: Thu, 10 Feb 2005 22:46:57 -0800
Message-Id: <1108104417.32129.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-10 at 22:18 -0500, Bill Nottingham wrote:
> Greg KH (gregkh@suse.de) said: 
> > I'd like to announce, yet-another-hotplug based userspace project:
> > linux-ng.  This collection of code replaces the existing linux-hotplug
> > package with very tiny, compiled executable programs, instead of the
> > existing bash scripts.
> > 
> > It currently provides the following:
> > 	- a /sbin/hotplug multiplexer.  Works identical to the existing
> > 	  bash /sbin/hotplug.
> 
> How does this interact with current usage of udevsend as the hotplug
> multiplexer?

First off, not everyone wants to use udev (I know, horrible thought...)
This provides those people a solution to a "I want a tiny /sbin/hotplug"
problem.

Also, udevstart working as /sbin/hotplug is great for keeping things in
order, which is important during normal operation.  But during the boot
sequence, the odds of getting out-of-order events, or even remove
events, is somewhat limited.  So, this /sbin/hotplug replacement can
work in an initrd/initramfs image when udevstart would be overkill.

And finally, even if you do use udevstart to manager /sbin/hotplug
events, you still need a module autoloader program.  This package
provides executables for that problem, if you don't want to (or you
can't) use the existing linux-hotplug scripts.  udev will never do the
module loading logic, so there's no duplication in this case.

Hope this helps.  I do realize the whole hotplug process is getting a
bit complicated.  I hope to write up some good documentation on what all
is involved to help clear up some of the confusion that the combination
of udev, udevsend, udevd, hal, /etc/hotplug.d/, /etc/dev.d/,
and /sbin/hotplug have caused lately.

thanks,

greg k-h

