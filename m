Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264723AbUFLKpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264723AbUFLKpb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 06:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264725AbUFLKpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 06:45:31 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:38210 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S264723AbUFLKp3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 06:45:29 -0400
Date: Sat, 12 Jun 2004 03:44:30 -0700
From: Paul Jackson <pj@sgi.com>
To: Clemens Schwaighofer <schwaigl@eunet.at>
Cc: gullevek@gullevek.org, linux-kernel@vger.kernel.org, cs@tequila.co.jp
Subject: Re: compile error with 2.6.7-rc3-mm1
Message-Id: <20040612034430.72a8207e.pj@sgi.com>
In-Reply-To: <40CA6835.2070405@eunet.at>
References: <40C9AF48.2040807@gullevek.org>
	<20040611062829.574db94f.pj@sgi.com>
	<40CA6835.2070405@eunet.at>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> nono, that part is already fixed in my patch (from mm-1).

But the error you report:

	drivers/perfctr/x86.c: In function `finalise_backpatching':
	drivers/perfctr/x86.c:1137: error: parse error before '{' token

is _exactly_ the error you reported before, and it occurs on a line that
assigns CPU_MASK_NONE (via a #define of perfctr_cpus_forbidden_mask) to
a local variable, and this is exactly the error one gets when assigning
the broken version of CPU_MASK_NONE, which was missing the (cpumask_t)
cast, to a local variable.

Somehow, something you are reporting is incorrect.  Or else I am more
mistaken than I am accustomed to being.

Please verify that the above error is indeed the one you are seeing,
and that doing the following command in this build tree:

	grep -1 define.CPU_MASK_NONE include/linux/cpumask.h

produces the following output, including the (cpumask_t) cast:


	#define CPU_MASK_NONE                                                   \
	((cpumask_t){ {                                                         \

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
