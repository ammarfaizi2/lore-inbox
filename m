Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbWITMtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbWITMtr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 08:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWITMtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 08:49:47 -0400
Received: from sorrow.cyrius.com ([65.19.161.204]:59922 "EHLO
	sorrow.cyrius.com") by vger.kernel.org with ESMTP id S1751218AbWITMtq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 08:49:46 -0400
Date: Wed, 20 Sep 2006 14:49:08 +0200
From: Martin Michlmayr <tbm@cyrius.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
Subject: AUDIT=y build failure on ARM
Message-ID: <20060920124908.GA30389@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the build failure below with AUDIT=y on ARM.  The problem is
that lib/audit.c includes asm-generic/audit_dir_write.h which lists a
number of syscalls that are not defined on ARM (and some other platforms).

What's the right fix for this?  I don't think I saw this problem with
2.6.18-rc7 but on the other hand I cannot see any relevant changes
since then.

The failure is:

  CC      lib/audit.o
In file included from lib/audit.c:7:
include/asm-generic/audit_dir_write.h:9: error: '__NR_mkdirat' undeclared here (not in a function)
include/asm-generic/audit_dir_write.h:10: error: '__NR_mknodat' undeclared here (not in a function)
include/asm-generic/audit_dir_write.h:11: error: '__NR_unlinkat' undeclared here (not in a function)
include/asm-generic/audit_dir_write.h:12: error: '__NR_renameat' undeclared here (not in a function)
include/asm-generic/audit_dir_write.h:13: error: '__NR_linkat' undeclared here (not in a function)
include/asm-generic/audit_dir_write.h:14: error: '__NR_symlinkat' undeclared here (not in a function)
...
In file included from lib/audit.c:22:
include/asm-generic/audit_change_attr.h:12: error: '__NR_fchownat' undeclared here (not in a function)
include/asm-generic/audit_change_attr.h:12: error: initializer element is not constant
include/asm-generic/audit_change_attr.h:12: error: (near initialization for 'chattr_class[11]')
include/asm-generic/audit_change_attr.h:13: error: '__NR_fchmodat' undeclared here (not in a function)
include/asm-generic/audit_change_attr.h:13: error: initializer element is not constant
include/asm-generic/audit_change_attr.h:13: error: (near initialization for 'chattr_class[12]')
lib/audit.c: In function 'audit_classify_syscall':
lib/audit.c:31: error: '__NR_openat' undeclared (first use in this function)
lib/audit.c:31: error: (Each undeclared identifier is reported only once
lib/audit.c:31: error: for each function it appears in.)
make[5]: *** [lib/audit.o] Error 1

-- 
Martin Michlmayr
http://www.cyrius.com/
