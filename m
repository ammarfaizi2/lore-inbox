Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263759AbUDQJtP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 05:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263770AbUDQJtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 05:49:15 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:37051 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S263759AbUDQJtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 05:49:11 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Subject: consolidate compat readv/writev/execve/select/nfsservctl [v2]
Date: Fri, 16 Apr 2004 18:00:22 +0200
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404161800.22367.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm following up with patches to introduce new compat_sys_* functions
for the largest four ones. All of these had some bugs on most
architectures, usually resulting from missing updates after the
native handler was changed.

This is the second version of these cleanups that include a fix for
compat_sys_select and an update from Arun Sharma to use compat_do_execve
on ia64 as well.

For readv, writev, execve and select, ia64 and x86_64 use a different
method from the others and I chose to use the more common one, which
is a bit more code but avoids an extra copy of the user data.

The patches are also available at
http://www.arndb.de/patches/linux/2.6.6-rc1/ and apply cleanly
to 2.6.6-rc1 and 2.6.5-mm6. They are tested on x86_64, ia64 and s390.

Please consider for 2.6.6-rc*-mm* and 2.6.7.

	Arnd <><

