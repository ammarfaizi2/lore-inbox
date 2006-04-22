Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbWDVVFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWDVVFf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 17:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWDVVFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 17:05:35 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:62680 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751206AbWDVVFd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 17:05:33 -0400
Subject: [PATCH] 'make headers_install' kbuild target.
From: David Woodhouse <dwmw2@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: bunk@stusta.de, sam@ravnborg.org
Content-Type: text/plain
Date: Sat, 22 Apr 2006 03:17:20 +0100
Message-Id: <1145672241.16166.156.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attached is the current patch from mainline to my working tree at
git://git.infradead.org/~dwmw2/headers-2.6.git -- visible in gitweb at
http://git.infradead.org/?p=users/dwmw2/headers-2.6.git;a=summary

It adds a 'make headers_install' target to the kernel makefiles, which
exports a subset of the headers and runs 'unifdef' on them to clean them
up for installation in /usr/include.

You'll need unifdef, which is available at 
http://www.cs.cmu.edu/~ajw/public/dist/unifdef-1.0.tar.gz and can
probably be put into our scripts/ directory since it's BSD-licensed.

I expect the kbuild folks to reimplement what I've done in the Makefile,
but it works well enough to get us started. The text file listing the
header files will probably want to change -- maybe we'll have a file in
each directory listing the exportable files in that directory, or maybe
we'll put a marker in the public files which we can grep for. I don't
care much.

Implementation details aside, the point is that we can now work on
refining the choice of headers to be exported, and more importantly we
can start fixing the _contents_ of those headers so that nothing which
should be private is exported in them outside #ifdef __KERNEL__.

I've chosen headers in the generic directories and in asm-powerpc; the
other asm directories could do with a proper selection being made; the
rest of the current list is just inherited from Fedora's
glibc-kernheaders package for now.

For a start, the headers I've marked for export are sometimes including
headers which _weren't_ so marked, and hence which don't exist in our
exported set of headers. I've started to move those inclusions into
#ifdef __KERNEL__ where appropriate, but there's more of that to do
before we can even use these for building anything and actually start to
test them in earnest.

Adrian, I'm hoping we can persuade you to help us audit the resulting
contents of usr/include/* and apply your usual treatment to the headers
until it looks sane. That assistance would be very much appreciated.

-- 
dwmw2

