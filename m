Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbVLCJnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbVLCJnh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 04:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbVLCJnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 04:43:37 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:45236 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751224AbVLCJng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 04:43:36 -0500
Date: Sat, 3 Dec 2005 10:43:14 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Al Viro <viro@ftp.linux.org.uk>,
       Vinay Venkataraghavan <raghavanvinay@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: copy_from_user/copy_to_user question
Message-ID: <20051203094314.GB8135@osiris.boeblingen.de.ibm.com>
References: <20051202224025.39396.qmail@web32108.mail.mud.yahoo.com> <1133572199.32583.93.camel@localhost.localdomain> <20051203013833.GG27946@ftp.linux.org.uk> <1133575346.4894.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133575346.4894.7.camel@localhost.localdomain>
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > Secondly, they seem to use memcpy as opposed to using
> > > > copy_to_user/copy_from_user which is also very
> > > > dangerous.
> > > 
> > > If they are grabbing data from user context into kernel (or vise versa)
> > > that could easily cause an oops.  Not to mention it is a security risk.
> > 
> > Not to mention it simply won't work on a many platforms, no matter what...
> 
> Hmm, I've only worked with a few platforms (i386, x86_64, ppc, mips, and
> a little arm but I don't remember that much).  I believe that a memcpy
> could work on all these platforms (error prone of course, but if the
> memory is mapped its OK).  When entering a system call, the kernel still
> has access to the memory locations assigned to the user.

Won't work at all on platforms that have distinct address spaces for user
and kernel space. E.g. on s390/s390x it wouldn't work. And yes, there are
special instructions to copy data between address spaces.

Heiko
