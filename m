Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264396AbUFZTgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264396AbUFZTgE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 15:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266395AbUFZTgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 15:36:04 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:23717 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S264396AbUFZTfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 15:35:52 -0400
Subject: Re: SATA_SIL works with 2.6.7-bk8 seagate drive, but oops
From: Albert Cahalan <albert@users.sf.net>
To: arjanv@redhat.com
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       george@galis.org, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1088262728.2805.7.camel@laptop.fenrus.com>
References: <1088253429.9831.1449.camel@cube>
	 <1088262728.2805.7.camel@laptop.fenrus.com>
Content-Type: text/plain
Organization: 
Message-Id: <1088270018.9831.1461.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 26 Jun 2004 13:13:38 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-06-26 at 11:12, Arjan van de Ven wrote:
> > You never did come up with an alternative to HZ-guessing
> > that would work on those old 1200-HZ Alpha boxes, the ARM
> > boxes that ran at 64 HZ and so on. I suppose you can blame
> > the arch maintainers, but user-space has to deal with it.
> > So HZ-guessing is a workaround for a kernel bug, especially
> > because you claim that HZ (USER_HZ now) is part of the ABI.
> 
> well.... this value is *passed to userspace* via the AT_ attributes ....
> glibc probably nicely exports this info via sysconf(). I guess/hope your
> tools are now using that ?

They use the AT_ attribute when it is provided.
(Linux 2.4 and above only)

The glibc wrapper is defective; it takes a bad
guess at HZ when the AT_ attribute is missing.
Had sysconf() worked as documented, returning an
error code on failure, it would have been used.

The sysconf() call for getting the number of CPUs
is also broken, at least on SPARC. It would return
a 0 instead of the proper -1 error code. I think
it tried to scan /proc/cpuinfo for CPUs.



