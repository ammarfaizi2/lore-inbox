Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129350AbRB0At0>; Mon, 26 Feb 2001 19:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129354AbRB0AtQ>; Mon, 26 Feb 2001 19:49:16 -0500
Received: from itaipu.nitnet.com.br ([200.255.111.241]:784 "HELO
	itaipu.nitnet.com.br") by vger.kernel.org with SMTP
	id <S129350AbRB0AtE>; Mon, 26 Feb 2001 19:49:04 -0500
Date: Mon, 26 Feb 2001 21:49:00 -0300
To: linux-kernel@vger.kernel.org
Subject: CPU name for "pure" i386 missing
Message-ID: <20010226214900.A11142@flower.cesarb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
From: Cesar Eduardo Barros <cesarb@nitnet.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Looks like every time the CPU detection code is rewritten, the printing of the
CPU name for "pure" (i.e. "original") 386s suffer. Last time, the "\n" after
the "CPU: 386" line was missing.

This time it's worse. It's tripping the "unknown CPU" code path:

CPU: Before vendor init, caps: 00000000 00000000 00000000, vendor = 255
[...]
CPU: ff/00

and looking at /proc/cpuinfo:

processor       : 0
vendor_id       : unknown
cpu family      : 3
model           : 0
model name      : ff/00
stepping        : unknown
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : no
fpu_exception   : no
cpuid level     : -1
wp              : no
flags           :
bogomips        : 3.62


Shouldn't the code be supposed to figure that, since there is no cpuid, it
should be a 386 or an early 486?

I think that table_lookup_model in arch/i386/kernel/setup.c should code a
vendor of 255 as a special case and return "386" or something like that instead
of bailing out. If everybody agrees, I'll make a patch for Linus.

-- 
Cesar Eduardo Barros
cesarb@nitnet.com.br
cesarb@dcc.ufrj.br
