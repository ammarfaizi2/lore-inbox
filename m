Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751441AbVI3M4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbVI3M4r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 08:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbVI3M4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 08:56:47 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:4054 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751441AbVI3M4q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 08:56:46 -0400
Date: Fri, 30 Sep 2005 13:56:45 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: kernel cross-toolchain (FC4)
Message-ID: <20050930125645.GJ7992@ftp.linux.org.uk>
References: <20050905035848.GG5155@ZenIV.linux.org.uk> <20050905155522.GA8057@mipter.zuzino.mipt.ru> <20050905160313.GH5155@ZenIV.linux.org.uk> <20050905164712.GI5155@ZenIV.linux.org.uk> <20050905212026.GL5155@ZenIV.linux.org.uk> <20050907183131.GF5155@ZenIV.linux.org.uk> <20050912191744.GN25261@ZenIV.linux.org.uk> <20050912192049.GO25261@ZenIV.linux.org.uk> <20050930120831.GI7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050930120831.GI7992@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Easy cross-toolchain for kernel

Requirements:
	* should be built from the same source as native toolchain with
minimal patches
	* should produce normal packages
	* should be buildable with minimal PITA in reasonable time
	* package metadata can (and obviously will) differ, but delta should
be minimal and easy to maintain

Recipe for FC4 follows; feel free to contribute equivalents for other
platforms.

1) Grab binutils-2.15.94.0.2.2, gcc-4.0.1-4.fc4, glibc-kernheaders-2.4-9.1.94
and glibc-2.3.5-10.3 SRPMs from any mirror (i.e. sources for native toolchain).
Install them (rpm -i .....src.rpm).

2) grab ftp.linux.org.uk/pub/people/viro/cross-build/*

3) out of the above, drop binutils*.patch into the SOURCES directory where
rpm had left vanilla binutils source

4) sh build-binutils and install resulting rpms (binutils-<target>)

5) sh build-kern_headers and install resulting rpms
(glibc-kernheaders-{alpha,ia64}) 

6) sh build-libc-headers and install resulting rmps (libc-headers-{alpha,ia64})

7) sh build-gcc and install the results (gcc-<target>, cpp-<target>)

List of targets to build in is file called, surprisingly, "targets".  libc
headers are needed only for alpha and ia64; if you don't need those, ignore
(5) and (6).
