Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130253AbRDAQ7W>; Sun, 1 Apr 2001 12:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130446AbRDAQ7M>; Sun, 1 Apr 2001 12:59:12 -0400
Received: from deliverator.sgi.com ([204.94.214.10]:22544 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S130253AbRDAQ67>; Sun, 1 Apr 2001 12:58:59 -0400
Message-ID: <3AC75DBF.31594195@sgi.com>
Date: Sun, 01 Apr 2001 09:56:31 -0700
From: LA Walsh <law@sgi.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, en-US, en-GB, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: unistd.h and 'extern's and 'syscall' "standard(?)"
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


        I have a question.  Some architectures have "system calls"
implemented as library calls (calls that are "system calls" on ia32)
For example, the expectation on 'arm', seems to be that sys_sync
is in a library.  On alpha, sys_open appears to be in a library.
Is this correct?

        Is it the expectation that the library that handles this
is the 'glibc' for that platform or is there a special "kernel.lib"
that goes with each platform?

	Is there 1 library that I need to link my apps with to
get the 'externs' referenced in "unistd.h"?

	The reason I ask is that in ia64 the 'syscall' call
isn't done with inline assembler but is itself an 'extern' call.
This implies that you can't do system calls directly w/o some 
support library.

	The implication of this is that developers working on
platform independent system calls and library functions, for
example, extended attributes, audit or MAC, can't provide
platform independent patches w/o also providing their own
syscall implementation for ia64.

	This came up as a problem when we wanted to provide a
a new piece of code but found it wouldn't link on some distributions.
In inquiry there seems to be some confusion regarding who is responsible
for providing this the code/library to satisfy this 'unistd.h' extern.

	Should something so basic as the 'syscall' interface be provided
in the kernel sources, perhaps as a kernel-provided 'lib', or is
it expected it will be provided by someone else or is it expected
that each developer should provide their own syscall implementation for
ia64?

Thanks,
-linda
-- 
The above thoughts and           | They may have nothing to do with
writings are my own.             | the opinions of my employer. :-)
L A Walsh                        | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice: (650) 933-5338
