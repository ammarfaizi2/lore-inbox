Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267083AbTAMHtp>; Mon, 13 Jan 2003 02:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261836AbTAMHtp>; Mon, 13 Jan 2003 02:49:45 -0500
Received: from anor.ics.muni.cz ([147.251.4.35]:59055 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S261523AbTAMHtn>;
	Mon, 13 Jan 2003 02:49:43 -0500
Date: Mon, 13 Jan 2003 08:55:18 +0100
From: Jan Yenya Kasprzak <kas@informatics.muni.cz>
To: Adrian Bunk <bunk@fs.tum.de>, torvalds@transmeta.com
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.56: Two global symbols "io"
Message-ID: <20030113085518.D3702@fi.muni.cz>
References: <20030112131244.GW21826@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030112131244.GW21826@fs.tum.de>; from bunk@fs.tum.de on Sun, Jan 12, 2003 at 02:12:44PM +0100
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
: I got the following compile error in 2.5.56:
: 
[...]
: sound/built-in.o(.data+0x7b30): multiple definition of `io'
: drivers/built-in.o(.data+0x738a0):
: ...
: ld: Warning: size of symbol `io' changed from 68 to 4 in sound/built-in.o
: ...
: make: *** [.tmp_vmlinux1] Error 1
[...]
: The offending files are:
:   sound/oss/awe_wave.c
:   drivers/net/wan/cosa.c

	Just change it to "static". This has been reported before
by Arnd Bergmann from the Kernel Janitors Project. However: cosa.c
can be built as a module only. Linus, please apply this.

From:  Arnd Bergmann <arnd@bergmann-dalldorf.de>
--- trivial-2.5-bk/drivers/net/wan/cosa.c.orig	2003-01-06 14:08:20.000000000 +1100
+++ trivial-2.5-bk/drivers/net/wan/cosa.c	2003-01-06 14:08:20.000000000 +1100
@@ -227,8 +227,8 @@
 /* NOTE: DMA is not autoprobed!!! */
 static int dma[MAX_CARDS+1] = { 1, 7, 1, 7, 1, 7, 1, 7, 0, };
 #else
-int io[MAX_CARDS+1]  = { 0, };
-int dma[MAX_CARDS+1] = { 0, };
+static int io[MAX_CARDS+1];
+static int dma[MAX_CARDS+1];
 #endif
 /* IRQ can be safely autoprobed */
 static int irq[MAX_CARDS+1] = { -1, -1, -1, -1, -1, -1, 0, };

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
|-- If you start doing things because you hate others and want to screw  --|
|-- them over the end result is bad.   --Linus Torvalds to the BBC News  --|
