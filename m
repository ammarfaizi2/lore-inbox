Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267173AbUBMSoM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 13:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267175AbUBMSoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 13:44:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:18925 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267173AbUBMSoH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 13:44:07 -0500
Date: Fri, 13 Feb 2004 10:44:06 -0800
From: Chris Wright <chrisw@osdl.org>
To: Maciej Zenczykowski <maze@cela.pl>
Cc: Valdis.Kletnieks@vt.edu, =?iso-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>,
       linux-kernel@vger.kernel.org
Subject: Re: why are capabilities disabled?
Message-ID: <20040213104405.C14506@build.pdx.osdl.net>
References: <200402131808.i1DI8vfA020145@turing-police.cc.vt.edu> <Pine.LNX.4.44.0402131914280.12513-100000@gaia.cela.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0402131914280.12513-100000@gaia.cela.pl>; from maze@cela.pl on Fri, Feb 13, 2004 at 07:22:52PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Maciej Zenczykowski (maze@cela.pl) wrote:
> > or less). Also note that exploited code can cause an exec() in a program
> > that doesn't even have a call to exec() in it....
> 
> Obviously a program without exec in it should not have the 
> right/priviledge/capability to call exec period.

Add shared libraries and this distinction gets much less clear, at least
from a static analysis point of view.

> We should provide some sort of way for each process directly after 
> start-up (or later on, after it's done ssetting up whatever) to declare 
> which syscalls (subfunctions for networking) it will 
> never use so that they can be quickly and efficiently disabled to ENOSYS 
> or EDISABLED or whatever.  Such 'capabilities' should be per pid per 
> syscall/subfunction and should be inherited over fork/exec and should only 
> be allowed to be set (no enabling by self - only by a process with that 
> syscall only enabled for another process with it disabled).

While this is interesting, it quickly hits limitations.  Many programs
will need to open/read/write, for example.  So mediating at the syscall
level is only moderatly useful.  LSM gives finer grained mediation points,
and something like SELinux using LSM allows you to do what you've done,
and is much more flexible.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
