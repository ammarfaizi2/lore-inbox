Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264891AbUDWR5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264891AbUDWR5n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 13:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264893AbUDWR5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 13:57:43 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:53921 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S264891AbUDWR5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 13:57:40 -0400
Subject: Re: [PATCH] coredump - as root not only if euid switched
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: pwaechtler@mac.com, Andrew Morton OSDL <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1082734536.3450.682.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 23 Apr 2004 11:35:37 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> While it's more secure to not dump core at all if the
> program has switched euid, it's also very unpractical.
> Since only programs started from root, being setuid
> root or have CAP_SETUID it's far more practical to
> dump as root.root mode 600. This is the bahavior 
> of Solaris.

Solaris can keep their security holes.

Consider a setuid core dump on removable media which
is user-controlled.

Also consider filesystems that don't store full security
data, like vfat and smb/cifs.

Core dumps to remote filesystems are a problem in
general, because the server might not implement the
type of security you expect it to implement.

Here's a better idea: add a sysctl for insecure core
dumps. When set, dump all cores as root.root mode 444.
Ignore directory permissions when doing so, so that
forcing dumps into a MacOS-style /cores directory does
not require that users be able to access it normally.
This lets appropriately authorized users debug setuid
apps and get support for them without adding security
holes like Solaris has.


