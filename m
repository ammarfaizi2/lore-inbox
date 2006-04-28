Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751825AbWD1AT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbWD1AT2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 20:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751735AbWD1ATN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 20:19:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:24277 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751732AbWD1ASm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 20:18:42 -0400
Date: Thu, 27 Apr 2006 17:17:09 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       brian.b@hp.com, Andi Kleen <ak@suse.de>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 04/24] x86_64: Pass -32 to the assembler when compiling the 32bit vsyscall pages
Message-ID: <20060428001709.GE18750@kroah.com>
References: <20060428001226.204293000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="x86_64-pass-32-to-the-assembler-when-compiling-the-32bit-vsyscall-pages.patch"
In-Reply-To: <20060428001557.GA18750@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

This quietens warnings and actually fixes a bug. The unwind tables would
come out wrong without -32, causing pthread cancellation during them 
to crash in the gcc runtime.

The problem seems to only happen with newer binutils
(it doesn't happen with 2.16.91.0.2 but happens wit 2.16.91.0.5) 

Thanks to Brian Baker @ HP for test case and initial analysis.

Cc: brian.b@hp.com

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 arch/x86_64/ia32/Makefile |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.16.11.orig/arch/x86_64/ia32/Makefile
+++ linux-2.6.16.11/arch/x86_64/ia32/Makefile
@@ -27,5 +27,5 @@ $(obj)/vsyscall-sysenter.so $(obj)/vsysc
 $(obj)/vsyscall-%.so: $(src)/vsyscall.lds $(obj)/vsyscall-%.o FORCE
 	$(call if_changed,syscall)
 
-AFLAGS_vsyscall-sysenter.o = -m32
-AFLAGS_vsyscall-syscall.o = -m32
+AFLAGS_vsyscall-sysenter.o = -m32 -Wa,-32
+AFLAGS_vsyscall-syscall.o = -m32 -Wa,-32

--
