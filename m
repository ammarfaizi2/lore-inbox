Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751880AbWITQrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880AbWITQrv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 12:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbWITQrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 12:47:51 -0400
Received: from gw1a.telemetry-investments.com ([64.20.161.180]:15068 "EHLO
	sv2.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S1751880AbWITQru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 12:47:50 -0400
Date: Wed, 20 Sep 2006 12:47:48 -0400
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Mitch <Mitch@0Bits.COM>
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org
Subject: Re: UML build failure with 2.6.18
Message-ID: <20060920164748.GB31772@ti64.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Mitch <Mitch@0Bits.COM>, jdike@addtoit.com,
	linux-kernel@vger.kernel.org
References: <45115EC7.2010407@0Bits.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45115EC7.2010407@0Bits.COM>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2006 at 07:31:19PM +0400, Mitch wrote:
> It's no distro (built up myself, so you can assume a gentoo type build).
> I'm building from scratch, so it should use no headers since i'm 
> building a kernel.

You are probably missing the syscall macros?
 
I saw a similar problem the other day and noticed on Fedora Core that
upgrading glibc-kernheaders-2.4-9.1.94 to glibc-kernheaders-3.0-45 caused
a regression in /usr/include/linux/unistd.h:

--- -	2006-09-20 12:45:31.195152000 -0400
+++ /usr/include/linux/unistd.h	2006-06-22 09:49:00.000000000 -0400
@@ -6,63 +6,5 @@
  * Include machine specific syscallX macros
  */
 #include <asm/unistd.h>
-#include <sys/syscall.h>
-#include <unistd.h>
-         
-
-#undef _syscall0
-#undef _syscall1
-#undef _syscall2
-#undef _syscall3
-#undef _syscall4
-#undef _syscall5
-#undef _syscall6
-
-
-#define _syscall0(type,name) \
-type name(void) \
-{\
-	return syscall(__NR_##name);\
-}
-
-#define _syscall1(type,name,type1,arg1) \
-type name(type1 arg1) \
-{\
-	return syscall(__NR_##name, arg1);\
-}
-
-#define _syscall2(type,name,type1,arg1,type2,arg2) \
-type name(type1 arg1,type2 arg2) \
-{\
-	return syscall(__NR_##name, arg1, arg2);\
-}
-
-#define _syscall3(type,name,type1,arg1,type2,arg2,type3,arg3) \
-type name(type1 arg1,type2 arg2,type3 arg3) \
-{\
-	return syscall(__NR_##name, arg1, arg2, arg3);\
-}
-
-#define _syscall4(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4) \
-type name (type1 arg1, type2 arg2, type3 arg3, type4 arg4) \
-{\
-	return syscall(__NR_##name, arg1, arg2, arg3, arg4);\
-}
-
-#define _syscall5(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4, \
-	  type5,arg5) \
-type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5) \
-{\
-	return syscall(__NR_##name, arg1, arg2, arg3, arg4, arg5);\
-}
-
-
-#define _syscall6(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4, \
-	  type5,arg5,type6,arg6) \
-type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5,type6 arg6) \
-{\
-	return syscall(__NR_##name, arg1, arg2, arg3, arg4, arg5, arg6);\
-}
-
 
 #endif /* _LINUX_UNISTD_H_ */


Regards,

	Bill Rugolsky
