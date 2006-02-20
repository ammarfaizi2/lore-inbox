Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932683AbWBTHbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932683AbWBTHbm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 02:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932684AbWBTHbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 02:31:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11460 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932683AbWBTHbl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 02:31:41 -0500
Date: Sun, 19 Feb 2006 23:29:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: stern@rowland.harvard.edu, psusi@cfl.rr.com, pavel@suse.cz,
       torvalds@osdl.org, mrmacman_g4@mac.com, alon.barlev@gmail.com,
       linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org
Subject: Re: Flames over -- Re: Which is simpler?
Message-Id: <20060219232926.256665d6.akpm@osdl.org>
In-Reply-To: <200602200755.57699.oliver@neukum.org>
References: <43F89F55.5070808@cfl.rr.com>
	<200602192144.57748.oliver@neukum.org>
	<20060219130243.52af0782.akpm@osdl.org>
	<200602200755.57699.oliver@neukum.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum <oliver@neukum.org> wrote:
>
> Am Sonntag, 19. Februar 2006 22:02 schrieb Andrew Morton:
> > Oliver Neukum <oliver@neukum.org> wrote:
> > >
> > > Am Sonntag, 19. Februar 2006 21:02 schrieb Andrew Morton:
> > > > For a), the current kernel behaviour is what we want - make the thing
> > > > appear at a new place in the namespace and in the hierarchy.  Then
> > > > userspace can do whatever needs to be done to identify the device, and
> > > > apply some sort of policy decision to the result.
> > > 
> > > How? If you have a running user space the connection to the open files
> > > is already severed, as any access in that time window must fail.
> > 
> > That's a separate issue, which we haven't discussed yet.  We have a device
> > which has gone away and which might come back later on.  Presently we will
> > return an I/O error if I/O is attempted in that window.  Obviously we'll
> > need to do something different, such as block reads and block or defer writes.
> 
> But how do you handle memory management?
> If you simply block writes, the system will stall random tasks laundering
> pages, including those needed to make progress. Even syncing before
> suspend won't help you, as a running user space may dirty pages.

Well of _course_ that will happen.  If we have dirty pages we need to
either keep them in memory or lose them.  If someone wants to run a massive
memory stresstest, unplug the disks in the middle of it and have the
machine serenely sail along as if nothing happened then they're being
unreasonable.

> And what about the rootfs?

If you disconnect that then everything stops until you reconnect it, provided
all the tools needed to handle the reconnect are in the correct place - if
the system providers got that wrong then the machine is obviously toast.

Your questions boil down to "what if the user is crazy or the implementation
is buggy?".   Let's assume neither is true, OK?

