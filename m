Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264638AbTFAOtG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 10:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264639AbTFAOtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 10:49:06 -0400
Received: from miranda.zianet.com ([216.234.192.169]:15624 "HELO
	miranda.zianet.com") by vger.kernel.org with SMTP id S264638AbTFAOtE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 10:49:04 -0400
Subject: Re: Question about style when converting from K&R to ANSI C.
From: Steven Cole <elenstev@mesatop.com>
To: Larry McVoy <lm@bitmover.com>
Cc: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20030601140602.GA3641@work.bitmover.com>
References: <1054446976.19557.23.camel@spc>
	 <20030601132626.GA3012@work.bitmover.com>
	 <20030601134942.GA10750@alpha.home.local>
	 <20030601140602.GA3641@work.bitmover.com>
Content-Type: text/plain
Organization: 
Message-Id: <1054479734.19552.51.camel@spc>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 01 Jun 2003 09:02:14 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-06-01 at 08:06, Larry McVoy wrote:
> > > Sometimes it is nice to be able to see function names with a 
> > > 
> > > 	grep '^[a-zA-Z].*(' *.c
> > 
> > This will return 'int foo(void)', what's the problem ?
> 
> You get a lot of other false hits, like globals.  I don't feel strongly
> about this, I'm more wondering why this style was choosen.  The way
> I showed is pretty common,  it's sort of the "Unix" way (it's how the
> original Unix guys did it, how BSD did it, and how the GNU guys do it), so
> it's a somewhat surprising difference.  I've never understood the logic.
> The more I think about it the less I understand it, doing it that way
> means you are more likely to have to wrap a function definition which
> is ugly:
> 
> static inline int cdrom_write_check_ireason(ide_drive_t *drive, int len, int ireason)
> {
> }
> 
> vs
> 
> static inline int
> cdrom_write_check_ireason(ide_drive_t *drive, int len, int ireason)
> {
> }
> 
> It may be just what you are used to but I also find that when reading lots
> of code it is nice to have it look like
> 
> return type
> function_name(args)
> 
> because the function_name() stands out more, it's always at the left side so
> I tend to parse it a little more quickly.
> 
> Don't get me wrong, I'm not arguing that you should go reformat all your
> code (I tend to agree with Linus, if it's not your code, don't stick your
> fingers in there just because you want to reformat it).  All I'm doing
> is trying to understand why in this instance did Linux diverage from 
> common practice.  

OK, here is a little more divergence from common practice, but please
don't throw too many stones (at least not large ones).  The following
style was invoked by Linus recently in the first of the zlib
conversions. 

Here is a snippet of a patch from arch/ppc/xmon/ppc-opc.c:

@@ -420,19 +420,19 @@
    same.  */

/*ARGSUSED*/
-static unsigned long
-insert_bba (insn, value, errmsg)
-     unsigned long insn;
-     long value;
-     const char **errmsg;
+static unsigned long insert_bba(
+       unsigned long insn,
+       long value,
+       const char **errmsg
+)
{
   return insn | (((insn >> 16) & 0x1f) << 11);
}


One added bonus of the above style is that it leaves the line count
unchanged. ;)

Steven


