Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262511AbULDAXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262511AbULDAXP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 19:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262509AbULDAWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 19:22:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:36517 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262510AbULDAVk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 19:21:40 -0500
Date: Fri, 3 Dec 2004 16:05:38 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: host name length
Message-Id: <20041203160538.77a22864.rddunlap@osdl.org>
In-Reply-To: <40521AA6.7070308@redhat.com>
References: <40521AA6.7070308@redhat.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2004 12:16:38 -0800 Ulrich Drepper wrote:

| POSIX nowadays contains
| 
|   _POSIX_HOST_NAME_MAX
| and
|   HOST_NAME_MAX
| 
| for programs to use to learn about the maximum host name length which is
| allowed.  _POSIX_HOST_NAME_MAX is the standard-required minimum maximum
| and the value must be 256.
| 
| The problem is that HOST_NAME_MAX currently is defined as 64, as defined
| by __NET_UTS_LEN in <linux/utsname.h>.  I.e., we have HOST_NAME_MAX as
| smaller than the minimum maximum which is obviously not POSIX compliant.
| 
| Now, we can simply ignore the problem or do something about it and
| introduce a third version of the utsname structure with sufficiently big
| nodename field.
| 
| Many OSes used small values before but 256 was chosen as a minimum
| maximum and some OSes were changed since host names longer than 64 chars
| indeed do exist.  I wonder why this never has been brought to the
| attention.  Or were people happy enough with truncated host names?
| 
| 
| Anyway, is there interest in getting this changed?

Yes (if not all forgotten).
I was waiting for 2.7, but that seems to be the wrong thing to do.


Can you show/tell me where _POSIX_HOST_NAME_MAX is specified to be
at least 256?  All that I have found so far is SuSv3
[ http://www.unix.org/single_unix_specification/ ], which says for
sys/utsname.h - system name structure:

char  sysname[]  Name of this implementation of the operating system. 
char  nodename[] Name of this node within the communications 
                 network to which this node is attached, if any. 
char  release[]  Current release level of this implementation. 
char  version[]  Current version level of this release. 
char  machine[]  Name of the hardware type on which the system is running. 

The character arrays are of unspecified size, but the data stored in them
shall be terminated by a null byte.
</quote>


and LSB 2.0.1:
[ http://refspecs.freestandards.org/LSB_2.0.1/LSB-Core/LSB-Core.html ]

Maximum length of a host name (not including the terminating null) as returned
from the gethostname function shall be at least 255 bytes.
</quote>

Is there somewhere else to look?
Anyway, I'm willing to do the kernel work if you want help with it.

---
~Randy
