Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267388AbRGLAqH>; Wed, 11 Jul 2001 20:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267389AbRGLAp6>; Wed, 11 Jul 2001 20:45:58 -0400
Received: from adsl-204-0-249-112.corp.se.verio.net ([204.0.249.112]:15350
	"EHLO tabby.cats-chateau.net") by vger.kernel.org with ESMTP
	id <S267388AbRGLApn>; Wed, 11 Jul 2001 20:45:43 -0400
From: Jesse Pollard <jesse@cats-chateau.net>
Reply-To: jesse@cats-chateau.net
To: Kip Macy <kmacy@netapp.com>, Paul Jakma <paul@clubi.ie>
Subject: Re: Switching Kernels without Rebooting?
Date: Wed, 11 Jul 2001 19:31:22 -0500
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: Helge Hafting <helgehaf@idb.hist.no>, "C. Slater" <cslater@wcnet.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.10.10107111545130.14769-100000@clifton-fe.eng.netapp.com>
In-Reply-To: <Pine.GSO.4.10.10107111545130.14769-100000@clifton-fe.eng.netapp.com>
MIME-Version: 1.0
Message-Id: <01071119453600.23085@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2001, Kip Macy wrote:
>In the future when Linux is more heavily used at the enterprise level
>there will likely be upgrade/revert modules to allow such a transition to
>take place.

I use some of the largest UNIX supercomputers ever built (IBM SP, Cray T3E,
SV1, YMP, XMP, J90, SGI Origin). None of them can start of a new kernel from an
earlier version. There are too many things that will fail:

	Any network activity
	Active disk I/O
	Locked memory
	File modification
	File structures
	Disk structures (yes they change...)
	Clock Synchronization (SMP and cluster)
	Shared memory (SMP and cluster)
	semaphores (SMP and cluster)
	login sessions
	device status
	shared disks and distributed file systems (cluster)
	pipes

Before you even try switching kernels, first implement a process
checkpoint/restart. The process must be resumed after a boot using the same
kernel, with all I/O resumed. Now get it accepted into the kernel.

Anything else is just another name for "reboot using new kernel".
	

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: jesse@cats-chateau.net

Any opinions expressed are solely my own.
