Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965203AbWEKILX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965203AbWEKILX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 04:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965206AbWEKILX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 04:11:23 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:13263 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965203AbWEKILW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 04:11:22 -0400
Date: Thu, 11 May 2006 04:11:09 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Al Viro <viro@ftp.linux.org.uk>
cc: Andrew Morton <akpm@osdl.org>, davem@davemloft.net, dwalker@mvista.com,
       alan@lxorguk.ukuu.org.uk, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm] sys_semctl gcc 4.1 warning fix
In-Reply-To: <20060511012818.GL27946@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0605110400340.1121@gandalf.stny.rr.com>
References: <20060510162106.GC27946@ftp.linux.org.uk> <20060510150321.11262b24.akpm@osdl.org>
 <20060510221024.GH27946@ftp.linux.org.uk> <20060510.153129.122741274.davem@davemloft.net>
 <20060510224549.GI27946@ftp.linux.org.uk> <20060510160548.36e92daf.akpm@osdl.org>
 <20060510232042.GJ27946@ftp.linux.org.uk> <20060510164554.27a13ca9.akpm@osdl.org>
 <20060511012818.GL27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 11 May 2006, Al Viro wrote:

>
> FWIW, I've got mostly finished pile of scripts (still needs to be
> consolidated, with merge into git for some parts) that does that following:
> take two trees and build log for the first one; generate remapped log
> with all lines of form <filename>:<line number>:<text> modified.  If line
> in question survives in the new tree, turn it into
> N:<new filename>:<new line number>:<text>
> with new filename and line giving its new location, otherwise turn it into
> O:<filename>:<line number>:<text>

And FWIW, not everyone has your scripts or the time to use them. The
init_self(x) thinging (and yes I hate that name) can be made to be a
compile time option.  So for those that are writing code, and only want to
look at the warnings that effect them, they have an option to turn off the
warnings of others (marked as false positives only). Heck, make the false
positives on as the default, and let others turn it off when developing.

I am one that spent several hours debugging my code, looking for a bug
that was caused by an "uninitialized variable".  The problem was, that I
became so damn use to ignoring those warnings, that I ignored them in my
own code.  I'm now a little more careful, but it still takes more time to
notice if those warnings are in code that I changed, or not.


>
> That reduces the size of diff between build logs a _lot_ - basically,
> all noise from changed line numbers is gone and we are left with real
> changes.  It works better with git (we catch renames that way), but
> even starting with diff between the trees works fairly well.
>
> IME, it makes watching for regressions quite simple, even when dealing with
> something like 2.6.16-rc2 and current, with shitloads of changes in between.
> And yes, I _do_ watch ia64 tree, with all its noise.  Moreover, I watch
> CHECK_ENDIAN sparse builds, aka thousands of warnings all over the tree...
>
> I'll get that stuff into sane form and post it; IMO it solves the noise
> problem just fine.

And IMO it solves it for you.  Not for everyone else.  Really, the only
argument that I see you have is the ugliness of the macro.  Since it can
be made configureable whether or not it disables those warnings, it
shouldn't affect you in any other way.  But it will really help those that
want to skip those warnings while looking at the compile output of their
code while they are developing it.

-- Steve

