Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268410AbUJSMg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268410AbUJSMg5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 08:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268329AbUJSMg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 08:36:57 -0400
Received: from svr68.ehostpros.com ([67.15.48.48]:44228 "EHLO
	svr68.ehostpros.com") by vger.kernel.org with ESMTP id S268576AbUJSMgW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 08:36:22 -0400
From: "Amit S. Kale" <amitkale@linsyssoft.com>
Organization: LinSysSoft Technologies Pvt Ltd
To: Tom Rini <trini@kernel.crashing.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: gdb support for kgdb [Re: Help for kgdb]
Date: Tue, 19 Oct 2004 18:04:52 +0530
User-Agent: KMail/1.5
References: <4136A9BA.9050802@us.ibm.com> <200409302033.49104.amitkale@linsyssoft.com> <20041018150216.GF26624@smtp.west.cox.net>
In-Reply-To: <20041018150216.GF26624@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410191804.53160.amitkale@linsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr68.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linsyssoft.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

GDB gurus have suggested number of changes. I have checked in the major change 
today which is to remove the target "i386-lk". Instead I have added an osabi 
"Linux-kernel". I am pasting a part of the checked in README file here for 
your quick reference.

I can see a good info threads listing with the context frames as pointed out 
by me in earlier emails.
-Amit

--------
2. Building gdb
Compile the gdb with a configure followed by a make.

3. Using gdb
Supply vmlinux to gdb on command line and specify osabi to be "Linux-kernel"
_before_ "target remote" command.

Example:

[amitkale@pythagoras gdb-build]$ gdb/gdb  ~/build/2.6.9-rc2-i386/vmlinux
GNU gdb 6.2.50_2004-10-15-cvs
Copyright 2004 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i686-pc-linux-gnu"...Using host libthread_db 
library "/lib/tls/libthread_db.so.1".

(gdb) set osabi Linux-kernel
(gdb) tar re /dev/ttyS0
Remote debugging using /dev/ttyS0
breakpoint () at /home/amitkale/work/linux-2.6.9-rc2/kernel/kgdb.c:1285
1285            atomic_set(&kgdb_setting_breakpoint, 0);
warning: no shared library support for this OS / ABI
(gdb) bt
#0  breakpoint () at /home/amitkale/work/linux-2.6.9-rc2/kernel/kgdb.c:1285
--------------

On Monday 18 Oct 2004 8:32 pm, Tom Rini wrote:
> On Thu, Sep 30, 2004 at 08:33:49PM +0530, Amit S. Kale wrote:
> > On Thursday 30 Sep 2004 7:47 pm, Tom Rini wrote:
> > > On Wed, Sep 29, 2004 at 10:56:21AM -0700, George Anzinger wrote:
> > > > IMHO, any and ALL documentation of that sort should be in the
> > > > Documentation branch of the kernel tree once the patch is applied.
> > > > Likewise a
> > >
> > > It's a good thing we've been doing that, then.  :)  Right now we've got
> > > a mini-HOWTO and code documentation done in DocBook.
> > >
> > > > recommended .gdbinit file, which would do the required set up.  Mine
> > > > also
> > >
> > > What required setup?  'target remote /dev/ttyS0' (or udp:ip:port) and
> > > go.
> > >
> > > Having said that, I wouldn't mind some sample GDB macros.  Patches to
> > > the DocBook file are welcome.  ... and once it is in the kernel, it's
> > > just another part of 'make *docs' of course.
> > >
> > > [snip]
> > >
> > > > As to the gdb changes, the key issue in my mind is acceptance by the
> > > > gdb folks.
> > >
> > > Yes.  Amit, any news on this front (such as you've submitted it or will
> > > in a few days) ?
> >
> > I have checked in some gdb code today. I'll need to do a few more
> > changes. I'll submit it to gdb folks by end of next week.
>
> So, what's the status of this?  Thanks.

