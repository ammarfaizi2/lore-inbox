Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964920AbWEUTWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbWEUTWx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 15:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbWEUTWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 15:22:53 -0400
Received: from xenotime.net ([66.160.160.81]:33444 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964920AbWEUTWw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 15:22:52 -0400
Date: Sun, 21 May 2006 12:25:22 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: David Wilder <dwilder@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation update for kdump
Message-Id: <20060521122522.acac0f6f.rdunlap@xenotime.net>
In-Reply-To: <4463921D.4050402@us.ibm.com>
References: <4463921D.4050402@us.ibm.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2006 12:35:57 -0700 David Wilder wrote:

> This patch contains a re-write of the kdump documentation (kdump.txt).
> We have updated much of the document to reflect the current state of 
> kdump and reformatted the document for readability.


+Install kexec-tools and the Kdump patch
+---------------------------------------
+
+1) Login as the root user.
+
+2) Download the kexec-tools user-space package from the following URL:
+
+   http://www.xmission.com/~ebiederm/files/kexec/kexec-tools-1.101.tar.gz
+
+3) Unpack the tarball with the tar command, as follows:
+
+   tar xvpzf kexec-tools-1.101.tar.gz
+
+4) Download the latest consolidated Kdump patch from the following URL:
+
+   http://lse.sourceforge.net/kdump/
+   
+   (This location is being used until all the user-space Kdump patches
+   are integrated with the kexec-tools package.)
+   
+5) Change to the kexec-tools-1.101 directory, as follows:
+
+   cd kexec-tools-1.101
+
+6) Apply the consolidated patch to the kexec-tools-1.101 source tree
+   with the patch command, as follows. (Modify the path to the downloaded
+   patch as necessary.)
+   
+   patch -p1 < /path-to-kdump-patch/kexec-tools-1.101-kdump.patch
+
+7) Configure the package, as follows:
+
+   ./configure
+
+8) Compile the package, as follows:
+
+   make

Can 1) log in as root
be moved to here?

+9) Install the package, as follows:
+
+   make install


+The dump-capture kernel
+-----------------------
+
+1) Under "General setup," append "-kdump" to the current string in
+   "Local version."
+
+2) On x86, enable high memory support under "Processor type and
+   features":
+
+   CONFIG_HIGHMEM64G=y
+   or
+   CONFIG_HIGHMEM4G

That would be CONFIG_HIGHMEM4B=y
but why is either of these required?

+6) Use a suitable value for "Physical address where the kernel is
+   loaded" (under "Processor type and features"). This only appears when
+   "kernel crash dumps" is enabled. By default this value is 0x1000000
+   (16MB). It should be the same as X in the "crashkernel=Y@X" boot
+   parameter discussed above.
+
+   On x86 and x86_64, use "CONFIG_PHYSICAL_START=0x1000000".
+      
+   On ppc64 the value is automatically set at 32MB when
+   CONFIG_CRASH_DUMP is set.

Two 6)'s.

+6) Optionally enable "/proc/vmcore support" under "Filesystems" ->
+   "Pseudo filesystems".
+
+   CONFIG_PROC_VMCORE=y
+   (CONFIG_PROC_VMCORE is set by default when CONFIG_CRASH_DUMP is selected.)
+      


---
~Randy
