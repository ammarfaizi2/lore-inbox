Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317264AbSGXOQY>; Wed, 24 Jul 2002 10:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317258AbSGXOQY>; Wed, 24 Jul 2002 10:16:24 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:19667 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S317264AbSGXOQX>; Wed, 24 Jul 2002 10:16:23 -0400
Date: Wed, 24 Jul 2002 16:19:41 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Andrea Arcangeli <andrea@suse.de>
cc: Daniel McNeil <daniel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19rc2aa1 i_size atomic access
In-Reply-To: <20020723192052.GF1117@dualathlon.random>
Message-ID: <Pine.GSO.3.96.1020724160738.27732A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jul 2002, Andrea Arcangeli wrote:

> the problem with the feature flag check is that I don't want to make it
> conditional at runtime, if I start adding branches and checks on the

 No, no, no, that would be insane, no doubt.

> feature flag (or pointer to functions) I can as well use the ordered
> read/writes C version without reading/writing the 64bit atomically. So
> the check_config() will be the oops or the not-oops at the first i_size
> read/write :).

 I meant something explicit like that:

#ifdef CONFIG_X86_CMPXCHG8B
	if (!cpu_has_cx8)
		panic("Kernel compiled for Pentium+, requires CMPXCHG8B
		      feature!");
#endif

An oops would be quite an obscure response for a configuration error.  As
I stated, just look into check_config(), for how it's done in similar
cases. 

> As for the CONFIG_X86_CMPXCHG8B you're right it's needed, setting
> CONFIG_M486=y and CONFIG_SMP=y would generate a kernel that would oops
> on a 486 and I don't see any other way to get 486+SMP case right without
> checking for the X86_FEATURE_CX8 capability at runtime. Not that I think
> 486+SMP is high prio but yes, theoretically it's a bug.

 No need to break what works, either.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

