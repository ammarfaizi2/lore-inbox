Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265395AbUH3Xlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265395AbUH3Xlu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 19:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265462AbUH3Xlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 19:41:50 -0400
Received: from web52302.mail.yahoo.com ([206.190.39.97]:13657 "HELO
	web52302.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265395AbUH3Xlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 19:41:44 -0400
Message-ID: <20040830234143.64800.qmail@web52302.mail.yahoo.com>
Date: Tue, 31 Aug 2004 01:41:43 +0200 (CEST)
From: =?iso-8859-1?q?Albert=20Herranz?= <albert_herranz@yahoo.es>
Subject: 2.6.9-rc1-mm1 ppc build broken
To: roland@redhat.com, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It seems that the waitid-system-call.patch in
2.6.9-rc1-mm1 introduced a circular include dependency
problem in the ppc arch.

The problem seems to be related to the addition of the
linux/resource.h header file in
include/asm-generic/siginfo.h for the new _rusage
field.

  CC      arch/ppc/kernel/asm-offsets.s
In file included from include/linux/mm.h:4,
                 from include/asm/io.h:7,
                 from include/linux/timex.h:61,
                 from include/linux/time.h:29,
                 from include/linux/resource.h:4,
                 from include/asm-generic/siginfo.h:6,
                 from include/asm/siginfo.h:4,
                 from include/linux/signal.h:7,
                 from
arch/ppc/kernel/asm-offsets.c:12:
include/linux/sched.h:276: error: field
`shared_pending' has incomplete type
include/linux/sched.h:379: error: parse error before
"sigval_t"
include/linux/sched.h:379: warning: no semicolon at
end of struct or union
include/linux/sched.h:386: error: parse error before
'}' token
include/linux/sched.h:534: error: `RLIM_NLIMITS'
undeclared here (not in a function)
include/linux/sched.h:554: error: field `pending' has
incomplete type
include/linux/sched.h:587: error: parse error before
"siginfo_t"
include/linux/sched.h:587: warning: no semicolon at
end of struct or union
include/linux/sched.h:607: error: parse error before
'}' token
include/linux/sched.h: In function `process_group':
include/linux/sched.h:611: error: dereferencing
pointer to incomplete type

Using gcc 3.3.2.
2.6.9-rc1, which does not include that patch, builds
fine for me.

Any others saw this?

Cheers,
Albert



		
______________________________________________
Renovamos el Correo Yahoo!: ¡100 MB GRATIS!
Nuevos servicios, más seguridad
http://correo.yahoo.es
