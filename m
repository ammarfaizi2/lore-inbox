Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030259AbWCQS05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030259AbWCQS05 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 13:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030256AbWCQS04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 13:26:56 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:63399 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030255AbWCQS0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 13:26:55 -0500
Subject: Re: chmod 111
From: Steven Rostedt <rostedt@goodmis.org>
To: Nick Warne <nick@linicks.net>
Cc: Felipe Alfaro Solana <felipe.alfaro@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200603171811.01963.nick@linicks.net>
References: <200603171746.18894.nick@linicks.net>
	 <6f6293f10603171007vbf752e5n8a3d6f2d65e0a1e7@mail.gmail.com>
	 <200603171811.01963.nick@linicks.net>
Content-Type: text/plain
Date: Fri, 17 Mar 2006 13:26:44 -0500
Message-Id: <1142620004.9478.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-17 at 18:11 +0000, Nick Warne wrote:
> On Friday 17 March 2006 18:07, Felipe Alfaro Solana wrote:
> > > I shouldn't be able to execute 'ls' as I can't read it, shouldn't it?
> >
> > Nop... you can execute binaries even if the read permission is not
> > granted. Note that I said "binaries". Shell script files need read and
> > execute permission, since they must be read by a shell interpreter in
> > order to get executed.
> 
> Hi Felipe,
> 
> First, apologies as this isn't kernel issue (but related, I suppose).
> 
> Yes, I see now after much messing about.  Why then are most binaries chmod 
> 755?  Who would need (why) to read a [system] binary?

Well, I guess you can't ptrace an executable that you can't read.

# cd /bin
# ls -l ls
-rwxr-xr-x 1 root root 80008 2006-03-02 15:08 ls
# chmod 711 ls
# ls -l ls
-rwx--x--x 1 root root 80008 2006-03-02 15:08 ls

$ cd /bin
$ ls -l ls
-rwx--x--x 1 root root 80008 2006-03-02 15:08 ls
$ gdb
GNU gdb 6.4-debian
Copyright 2005 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you
are
welcome to change it and/or distribute copies of it under certain
conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for
details.
This GDB was configured as "i486-linux-gnu".
(gdb) file /bin/ls
/bin/ls: Permission denied.
(gdb)


# chmod 755 ls

(gdb) file /bin/ls
Reading symbols from /bin/ls...(no debugging symbols found)...done.
Using host libthread_db library "/lib/tls/i686/cmov/libthread_db.so.1".
(gdb)


So I guess if you need to debug a system binary, you need it readable.
But I guess that can also be a security problem, and having system
binaries not readable, might make you system a little more secure.

-- Steve


