Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264002AbUFFSxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264002AbUFFSxa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 14:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264012AbUFFSxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 14:53:30 -0400
Received: from S010600a0c9f25a40.vn.shawcable.net ([24.87.160.169]:23518 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id S264002AbUFFSx0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 14:53:26 -0400
Date: Sun, 6 Jun 2004 11:53:19 -0700
From: Simon Kirby <sim@netnation.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: clone() <-> getpid() bug in 2.6?
Message-ID: <20040606185319.GA5022@netnation.com>
References: <Pine.LNX.4.58.0406051341340.7010@ppc970.osdl.org> <20040605205547.GD20716@devserv.devel.redhat.com> <20040605215346.GB29525@taniwha.stupidest.org> <1086475663.7940.50.camel@localhost> <Pine.LNX.4.58.0406051553130.2261@bigblue.dev.mdolabs.com> <Pine.LNX.4.58.0406051610430.7010@ppc970.osdl.org> <40C2A6E4.7020103@ThinRope.net> <Pine.LNX.4.58.0406052244290.7010@ppc970.osdl.org> <20040606075754.GA10642@codepoet.org> <Pine.LNX.4.58.0406060937330.7010@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406060937330.7010@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 06, 2004 at 09:57:20AM -0700, Linus Torvalds wrote:

> 	/* Write the pid into the lockfile, fsync it */
> 	write(fd, name + 9, len - 9);
> 	fsync(fd);

Unrelated to this discussion -- and there is a close() missing -- but is
there any reason for fsync() to be there?  I've seen this often before,
but I've never understood why it would be necessary to force the data to
disk, especially when it will likely be removed later before it would
have otherwise been written to disk.  Shouldn't the lock file behave
properly without fsync(), even across NFS, and even across all OSes?

Simon-
