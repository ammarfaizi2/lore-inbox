Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263740AbTKKUWP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 15:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263745AbTKKUWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 15:22:15 -0500
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:36834 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S263740AbTKKUWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 15:22:09 -0500
Date: Tue, 11 Nov 2003 15:22:09 -0500
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OT: why no file copy() libc/syscall ??
Message-ID: <20031111202209.GB23283@delft.aura.cs.cmu.edu>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Qvw7.5Qf.9@gated-at.bofh.it> <QH4e.eV.3@gated-at.bofh.it> <3FB0EE0E.6090103@softhome.net> <20031111150256.GA13283@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031111150256.GA13283@bitwizard.nl>
User-Agent: Mutt/1.5.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 11, 2003 at 04:02:56PM +0100, Rogier Wolff wrote:
> Fine. For compatibilty we'll leave "sendfile" in place. But if somehow
> someone builds a filesystem which cannot use the pagecache, then
> "sendfile" will fail. Or if somehow we manage to get the socket hooked
...
> (*) Suppose I manage to stop and restart an application. The "restart"
> program might need to "sit between" the original application and its
> filedescriptors. So now, what used to be a socket suddenly becomes a
> pipe. It'd be nice if things would continue to work. Everything is a
> file remember?

man sendfile(2)

NOTES
    ...
    Applications may wish to fall back to read/write in the case
    where sendfile() fails with EINVAL or ENOSYS.

So we get something in a userspace library (libc?) that does
copyfile(whatever, whereever) and uses a few kernel primitives like
open/close/sendfile and the appropriate fallback code to a read/write
loop whenever the sendfile doesn't work.

It works now, and it will work better when sendfile becomes more
versatile, and the sky is the limit once the underlying filesystem can
provide it's own optimized implementation for instance when both fd's
refer to objects within the same (remote) filesystem.

Similarily, we might at some point be able to optimize sendfile between
two sockets by pushing the connection off to a router somewhere in the
network completely bypassing the local NIC.

Jan

