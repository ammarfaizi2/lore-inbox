Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266285AbTAOMQs>; Wed, 15 Jan 2003 07:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266286AbTAOMQs>; Wed, 15 Jan 2003 07:16:48 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:64149 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266285AbTAOMQr>;
	Wed, 15 Jan 2003 07:16:47 -0500
Date: Wed, 15 Jan 2003 12:23:24 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Miklos Szeredi <Miklos.Szeredi@eth.ericsson.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VIA C3 and random SIGTRAP or segfault
Message-ID: <20030115122324.GC32694@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Miklos Szeredi <Miklos.Szeredi@eth.ericsson.se>,
	linux-kernel@vger.kernel.org
References: <200301150929.h0F9T1I10444@duna48.eth.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301150929.h0F9T1I10444@duna48.eth.ericsson.se>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2003 at 10:29:01AM +0100, Miklos Szeredi wrote:
 > 
 > I just bought a VIA C3 866 processor, and under very special
 > circumstances some programs (e.g. mplayer, xmms) randomly crash with
 > trace/breakpoint trap or segmentation fault.  Otherwise the system
 > seems stable even under high load.

Be sure that those programs aren't compiled for 686. The C3 lacks
cmov, so it'll segfault when it hits that opcode. You can confirm
this by running it under gdb, and disassembling where it segv's to.
This is still a common problem thats biting some people. The debian
folks had a broken libssl for months up until recently.

Note to userspace developers: If you're compiling something as
a 686 binary, you *NEED* to check the feature flags (in an i386
compiled program) to see if the CPU has cmov before you load 686
optimised parts of your app.  This is *NOT* a kernel problem,
it is *NOT* a CPU bug. The cmov extension is optional.
VIA chose to save silicon space by not implementing it. 
Gcc unfortunatly always uses cmov when compiling for 686.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
