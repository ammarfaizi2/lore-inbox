Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315370AbSFJOZH>; Mon, 10 Jun 2002 10:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315414AbSFJOZH>; Mon, 10 Jun 2002 10:25:07 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:29102 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S315370AbSFJOZE>; Mon, 10 Jun 2002 10:25:04 -0400
Date: Mon, 10 Jun 2002 09:25:04 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Jurriaan on Alpha <thunder7@xs4all.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.21: fixdep starts spitting out 'unaligned traps'
In-Reply-To: <20020610072331.GA12676@alpha.of.nowhere>
Message-ID: <Pine.LNX.4.44.0206100918380.20438-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jun 2002, Jurriaan on Alpha wrote:

> Program received signal SIGBUS, Bus error.
> 0x120001d48 in traps () at scripts/fixdep.c:364
> 364             if (*(int *)test != INT_CONF) {
> (gdb) bt
> #0  0x120001d48 in traps () at scripts/fixdep.c:364
> #1  0x120001de8 in main (argc=10, argv=0x11ffffc58) at scripts/fixdep.c:375
> (gdb)

Yeah, makes sense, that's a bug trap to test if we guessed endianness 
right. Could you try to just comment out the call to traps() in main()?

The rest of the code should be safe. If commenting out fixes the problem, 
could you try to replace

-	char *test = "CONF";
+	static char __attribute__((aligned(8))) test[] = "CONF";

Thanks,

--Kai

