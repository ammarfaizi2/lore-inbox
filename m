Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268479AbUJJVMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268479AbUJJVMQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 17:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268497AbUJJVMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 17:12:16 -0400
Received: from blfd-d9bb97c9.pool.mediaWays.net ([217.187.151.201]:19216 "EHLO
	citd.de") by vger.kernel.org with ESMTP id S268479AbUJJVMN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 17:12:13 -0400
Date: Sun, 10 Oct 2004 23:12:08 +0200
From: Matthias Schniedermeyer <ms@citd.de>
To: Olaf =?unknown-8bit?Q?Fr=B1czyk?= <olaf@cbk.poznan.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to umount a busy filesystem?
Message-ID: <20041010211208.GA6986@citd.de>
References: <1097441558.2235.9.camel@venus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097441558.2235.9.camel@venus>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.10.2004 22:52, Olaf Fr?czyk wrote:
> Hi,
> 
> Why I cannot umount filesystem if it is being accessed?
> I tried MNT_FORCE option but it doesn't work.
> 
> Killing all processes that access a filesystem is not an option. They
> should just get an error when accessing filesystem that is umounted.
> 
> Any idea how to do it?

umount -l

removes the mount in "lazy"-mode, this way the mount-point "vanishes"
for all programs whose working-dirs aren't "within" that mount-point.
After all files are closed the filesystem is unmounted totally.
You can "reuse" the mount-point immediatly.

iow. If a programs want to open a file with an absolute path (including
the "<path_to_mountpoint>") then it will fail (or see the other
mountpoint). A program whose working dir is "inside" the mountpoint
(e.g. if it was started from a path "inside" the mountpoint) can still
open file if they use relative paths. Also when you have a bash whose
working dir is "inside" the mountpoint, you can still start programs
that can access the files within that mountpoint.

If you have luck then the program(s) can't open new files (or "see" the
new mountpint). But many (maybe most) programs don't have problems with
a lazy-unmounted mountpoint. Personally i have only encountered one
program that (failed/saw the "other"), which was "acroread" (xpdf on the
other side still can open files in a lazy unmounted mountpoint)

Seems this is the best you can do.



Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

