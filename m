Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266200AbUJEWg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266200AbUJEWg2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 18:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266221AbUJEWg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 18:36:28 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:11528 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S266200AbUJEWgY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 18:36:24 -0400
Date: Wed, 6 Oct 2004 00:36:21 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Console: fall back to /dev/null when no console is availlable
Message-ID: <20041005223621.GA4523@pclin040.win.tue.nl>
References: <20041005185214.GA3691@wohnheim.fh-wedel.de> <20041005212712.I6910@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041005212712.I6910@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2004 at 09:27:12PM +0100, Russell King wrote:
> On Tue, Oct 05, 2004 at 08:52:14PM +0200, Jörn Engel wrote:
> > Looks pretty trivial, but opinions on this subject may vary.
> > Comments?
> 
> There's a related problem.  /sbin/hotplug.  I keep seeing odd failures
> from /sbin/hotplug scripts which go away when I ensure that fd0,1,2 are
> directed at something real.

Yes. In principle, user space must be able to handle the case
where no fds 0,1,2 are available. For example in mount.c:

        while((fd = open("/dev/null", O_RDWR)) == 0 || fd == 1) ;
        if (fd > 2)
                close(fd);

or so.

Andries
