Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263572AbUDWTMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263572AbUDWTMR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 15:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264590AbUDWTMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 15:12:17 -0400
Received: from smtpout.mac.com ([17.250.248.44]:30919 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S263572AbUDWTML (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 15:12:11 -0400
Subject: Re: [PATCH] coredump - as root not only if euid switched
From: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@mac.com>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton OSDL <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1082734536.3450.682.camel@cube>
References: <1082734536.3450.682.camel@cube>
Content-Type: text/plain
Message-Id: <1082747589.2710.100.camel@picklock.adams.family>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 23 Apr 2004 21:14:37 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fr, 2004-04-23 um 17.35 schrieb Albert Cahalan:
> > While it's more secure to not dump core at all if the
> > program has switched euid, it's also very unpractical.
> > Since only programs started from root, being setuid
> > root or have CAP_SETUID it's far more practical to
> > dump as root.root mode 600. This is the bahavior 
> > of Solaris.
> 
> Solaris can keep their security holes.
> 

I checked (older) versions on

HP-UX, True64, AiX, MacOsX

HP-UX didn't dump core on a seteuid 0->n prog
Aix,MacOsX and True64 dumped core with ownership of user
I could check Irix

> Consider a setuid core dump on removable media which
> is user-controlled.
> 

boot into rescue system...

> Also consider filesystems that don't store full security
> data, like vfat and smb/cifs.
> 
> Core dumps to remote filesystems are a problem in
> general, because the server might not implement the
> type of security you expect it to implement.
> 

mkdir /var/cores
chmod a+rwx,o+t /var/cores
echo /var/cores/%e.core.%p > /proc/sys/kernel/core_pattern

> 
> Here's a better idea: add a sysctl for insecure core
> dumps. When set, dump all cores as root.root mode 444.
> Ignore directory permissions when doing so, so that
> forcing dumps into a MacOS-style /cores directory does
> not require that users be able to access it normally.
> This lets appropriately authorized users debug setuid
> apps and get support for them without adding security
> holes like Solaris has.

It's tunable via coreadm

troll, troll


