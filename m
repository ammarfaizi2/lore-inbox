Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262141AbTIZM2e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 08:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbTIZM2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 08:28:34 -0400
Received: from mx2.elte.hu ([157.181.151.9]:51379 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262141AbTIZM2b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 08:28:31 -0400
Date: Fri, 26 Sep 2003 14:28:54 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Subject: [patch] updated exec-shield patch, 2.4/2.6 -G3
Message-ID: <Pine.LNX.4.56.0309261410130.14571@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


in the recent boom of buffer-overflow bugs in various open-source packages
i got lots of requests for exec-shield being ported to various popular
kernel trees. Here's the latest update of exec-shield:

against vanilla 2.6.0-test5:

	redhat.com/~mingo/exec-shield/exec-shield-2.6.0-test5-G2

against vanilla 2.4.22:

	redhat.com/~mingo/exec-shield/exec-shield-2.4.22-G2

against 2.4.22-ac + NPTL:

	[ redhat.com/~mingo/nptl-patches/nptl-2.4.22-ac1-A2 ]

	redhat.com/~mingo/exec-shield/exec-shield-2.4.22-ac1-nptl-G2

Changes in this exec-shield version:

 - more refined support for PIE binaries (Position Independent Executables
   - a feature of latest binutils)

 - complete randomization of the whole address space [except the static 
   binary mappings for non-PIE binaries]. Randomized executable mappings,
   heap, data mappings, stack, env/argv/aux spaces. With PIE binaries
   there's not a single constant address left.

 - ability to turn off exec-shield without changing the binary.
   (try 'setarch i386 /bin/cat /proc/self/maps'.)

 - various compatibility features and fixes.

 - randomization can be turned off via /proc/sys/kernel/exec-shield-randomize.

valid /proc/sys/kernel/exec-shield levels are:

   = 0   exec-shield disabled
   = 1   exec-shield on PT_GNU_STACK executables [ie. binaries compiled 
                                                  with newest gcc]
   = 2   (default) exec-shield on all executables

value 1 is recommended with glibc and gcc versions that support
PT_GNU_STACK all across the spectrum. (Fedora Core test2 [released
yesterday] includes all of this and all applications were recompiled to
have valid PT_GNU_STACK settings.) On other systems the value of '2' is
recommended, use setarch for those binaries that cannot take exec-shield
[eg. Loki games].

reports, comments welcome. Enjoy it,

	Ingo
