Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265928AbUFDRhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265928AbUFDRhQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 13:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265887AbUFDRd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 13:33:29 -0400
Received: from mx2.elte.hu ([157.181.151.9]:9405 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265902AbUFDRbK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 13:31:10 -0400
Date: Fri, 4 Jun 2004 19:32:16 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andy Lutomirski <luto@myrealbox.com>, Andi Kleen <ak@suse.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, arjanv@redhat.com,
       suresh.b.siddha@intel.com, jun.nakajima@intel.com
Subject: Re: [announce] [patch] NX (No eXecute) support for x86,   2.6.7-rc2-bk2
Message-ID: <20040604173216.GA6646@elte.hu>
References: <20040602205025.GA21555@elte.hu> <20040603230834.GF868@wotan.suse.de> <20040604092552.GA11034@elte.hu> <200406040826.15427.luto@myrealbox.com> <Pine.LNX.4.58.0406040830200.7010@ppc970.osdl.org> <20040604160628.GA32375@elte.hu> <20040604172008.GA4993@elte.hu> <20040604172227.GA5175@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040604172227.GA5175@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this is how the maps look like on distributions that dont have the 
PT_GNU_STACK:

 08048000-0804c000 r-xp 00000000 03:01 495264     /bin/cat
 0804c000-0804d000 rwxp 00003000 03:01 495264     /bin/cat
 0804d000-0806e000 rwxp 0804d000 00:00 0
 40000000-40014000 r-xp 00000000 03:01 319552     /lib/ld-2.3.3.so
 40014000-40015000 r--p 00014000 03:01 319552     /lib/ld-2.3.3.so
 40015000-40016000 rwxp 00015000 03:01 319552     /lib/ld-2.3.3.so
 40029000-4015d000 r-xp 00000000 03:01 176042     /lib/tls/libc-2.3.3.so
 4015d000-4015f000 r--p 00134000 03:01 176042     /lib/tls/libc-2.3.3.so
 4015f000-40161000 rwxp 00136000 03:01 176042     /lib/tls/libc-2.3.3.so
 40161000-40164000 rwxp 40161000 00:00 0
 40164000-40364000 r-xp 00000000 03:01 465837     /usr/lib/locale/locale-archive
 40364000-4036a000 r-xp 00902000 03:01 465837     /usr/lib/locale/locale-archive
 4036a000-40397000 r-xp 0090c000 03:01 465837     /usr/lib/locale/locale-archive
 40397000-40398000 r-xp 00942000 03:01 465837     /usr/lib/locale/locale-archive
 bfffe000-c0000000 rwxp bfffe000 00:00 0
 ffffe000-fffff000 ---p 00000000 00:00 0

so we can turn on NX safely - all but the library/binary .data areas are
executable. (and if any code assumes executability there then it
deserves that SEGFAULT ...)

	Ingo
