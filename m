Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132418AbRDDHkO>; Wed, 4 Apr 2001 03:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132595AbRDDHkE>; Wed, 4 Apr 2001 03:40:04 -0400
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:18445 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S132418AbRDDHjv>; Wed, 4 Apr 2001 03:39:51 -0400
From: r1vamsi@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: jdelsign@etnus.com
cc: dprobes@oss.lotus.com, linux-kernel@vger.kernel.org
Message-ID: <CA256A24.0029FE1E.00@d73mta05.au.ibm.com>
Date: Wed, 4 Apr 2001 11:32:36 +0530
Subject: Re: [RFC][PATCH] Debug Register Allocation on x86
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jim,

We have modified ptrace() such that it first allocates the debug register
before it is used. So, yes, if a debugger is using ptrace() interface it
need not be concerned about this centralised debug register allocation
scheme, the debug register allocation actually happens behind the scenes
and it is guaranteed that other debug facilities don't overwrite your
settings. However, when you try to access a debug register for the first
time using ptrace, be sure to check the return value. It can return -EBUSY
if the debug register you are trying to use is already being used by other
tool.

You cannot rely on determining free debug registers by checking dr7: it is
possible that a debug register can be allocated from under you after you
have checked that it is free but before you have updated dr7 with new
settings.

Regards.. Vamsi.

Vamsi Krishna S.
Linux Technology Center, IBM India, Bangalore.
Ph: +91 80 5262355 Extn: 3672
Internet: r1vamsi@in.ibm.com

---------------------- Forwarded by Bharata B Rao/India/IBM on 04/04/2001
08:49 AM ---------------------------

James Cownie <jcownie@etnus.com> on 04/03/2001 09:53:22 PM

Please respond to James Cownie <jcownie@etnus.com>

To:   Bharata B Rao/India/IBM@IBMIN
cc:   John DelSignore <jdelsign@etnus.com>
Subject:  [RFC][PATCH] Debug Register Allocation on x86




Bharata,

If I understand your patch correctly, it does not require that code
using the debug registers via ptrace is changed, since you notice the
use of a debug register in the ptrace write request and then allocate
it ?

Is this right ?

Our TotalView debugger also uses the debug registers to implement data
watchpoints on Linux/x86, and we search for free watchpoint registers
by looking at the control register, and then update all of the
watchpoint registers (skipping dr4 and dr5). I'm not sure how this
will work with your code...

p.s. You can download a copy of Totalview and get a demo license from
the web if you want to play with it.

Reference :
http://boudicca.tux.org/hypermail/linux-kernel/this-week/0322.html

-- Jim

James Cownie   <jcownie@etnus.com>
Etnus, LLC.     +44 117 9071438
http://www.etnus.com





