Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968042AbWLEDU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968042AbWLEDU3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 22:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968044AbWLEDU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 22:20:29 -0500
Received: from smtp.osdl.org ([65.172.181.25]:40378 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968042AbWLEDU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 22:20:28 -0500
Date: Mon, 4 Dec 2006 19:20:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kasper Sandberg <lkml@metanurb.dk>
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: BUG? atleast >=2.6.19-rc5, x86 chroot on x86_64
Message-Id: <20061204192018.2a61814f.akpm@osdl.org>
In-Reply-To: <1165286169.6023.1.camel@localhost>
References: <1164205742.13434.4.camel@localhost>
	<20061122152559.72efd379.akpm@osdl.org>
	<1165286169.6023.1.camel@localhost>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Dec 2006 03:36:09 +0100
Kasper Sandberg <lkml@metanurb.dk> wrote:

> i know i said i suspected this was another bug, but i have revised my
> suspecisions, and i do believe its in relation to x86 chroot on x86_64
> install, as it has happened with more stuff now, inside the chroot, and
> only inside the chroot, while the same apps dont do it outside chroot.
> 
> 2.6.19 release is affected too

Please don't top-post.

> On Wed, 2006-11-22 at 15:25 -0800, Andrew Morton wrote:
> > On Wed, 22 Nov 2006 15:29:02 +0100
> > Kasper Sandberg <lkml@metanurb.dk> wrote:
> > 
> > > it appears some sort of bug has gotten into .19, in regards to x86
> > > emulation on x86_64.
> > > 
> > > i have only tested with >=rc5, thw folling, as an example, appears in
> > > dmesg:
> > > ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
> > > arg(00221000) on /home/redeeman
> > > ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
> > > arg(00221000) on /home/redeeman/.wine/drive_c/windows/system32
> > 
> > Try
> > 
> > 	echo 0 > /proc/sys/kernel/compat-log
> > 
> > I don't _think_ we did anything to change the logging in there.  Which kernel
> > version were you using previously (the one which didn't do this)?

Possibly some ioctl got removed.  I don't know why it would only occur
within a chrooted environment.

Possibly one could work out what's going on by reverse-engineering x86_64
ioctl command 0x82187201, but unfortunately I don't have time to do that. 

Also unfortunately there appears to be an assumption that unless I
personally can immediately and straightforwardly identify a bug-owner, I
personally own the bug.  The best I can suggest is that you raise a report
at bugzilla.kernel.org so this issue gets ignored in a more organised
fashion.

Sorry.
