Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262589AbTEAAkK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 20:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbTEAAkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 20:40:10 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:25317 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S262589AbTEAAkI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 20:40:08 -0400
Date: Wed, 30 Apr 2003 17:52:24 -0700
From: Larry McVoy <lm@bitmover.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: rmoser <mlmoser@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: Kernel source tree splitting
Message-ID: <20030501005224.GA8676@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Randy.Dunlap" <rddunlap@osdl.org>, rmoser <mlmoser@comcast.net>,
	linux-kernel@vger.kernel.org
References: <200304301946130000.01139CC8@smtp.comcast.net> <20030430172102.69e13ce9.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030430172102.69e13ce9.rddunlap@osdl.org>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=0.5, required 4.5,
	DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It would be *really* cool if the Makefile dependencies actually worked.
It's a very little known fact but if you are in an RCS or SCCS (and BK
looks like SCCS to make) source tree and the files are not checked out,
you can just say

	make

and make will look for a makefile, if there isn't one but there is a 
SCCS/s.[Mm]akefile it will check it out, look at the dependencies and start
checking those out and keep doing it to satisfy the target.

It's a really pleasant way to work, the "make clobber" target "cleans"
all the source so it isn't checked out, the directory is nice and empty.
This makes it easy to see stuff you still need to check in or think about.
It's definitely an old timer way of working, I'm pretty sure that the
original Unix was done this way but just because it is old doesn't mean
it is bad.  Opinions differ on that :)

Here's a make in a cleaned BK source tree:

$ lf
Notes/  gnu/  ide/   port/  tmp/       utils/  win32/
SCCS/   gui/  mdbm/  t/     tomcrypt/  web/    zlib/
$ make p
get   SCCS/s.Makefile
Makefile 1.326: 684 lines
make CFLAGS="-g -O2 -Wall -Wno-parentheses -Wno-char-subscripts -Wno-format-y2k -Wstrict-prototypes " all
get   SCCS/s.abort.c
abort.c 1.11: 157 lines
get   SCCS/s.unix.h
unix.h 1.48: 79 lines
get   SCCS/s.bkd.h
bkd.h 1.68: 157 lines
get   SCCS/s.lib_tcp.h
lib_tcp.h 1.12: 21 lines
get   SCCS/s.logging.h
logging.h 1.10: 80 lines
get   mdbm/SCCS/s.common.h
mdbm/common.h 1.6: 111 lines
get   mdbm/SCCS/s.mdbm.h
mdbm/mdbm.h 1.11: 426 lines
get   mdbm/SCCS/s.tune.h
mdbm/tune.h 1.3: 66 lines
get   SCCS/s.mmap.h
mmap.h 1.5: 30 lines
get   SCCS/s.purify.h
purify.h 1.31: 114 lines
get   SCCS/s.range.h
range.h 1.18: 42 lines
get   SCCS/s.rcs.h
rcs.h 1.6: 60 lines
get   SCCS/s.liblines.h
liblines.h 1.5: 81 lines
get   SCCS/s.resolve.h
resolve.h 1.36: 178 lines
get   SCCS/s.sccs.h
sccs.h 1.497: 1171 lines
get   SCCS/s.system.h
system.h 1.55: 157 lines
get   tomcrypt/SCCS/s.mpi-config.h
tomcrypt/mpi-config.h 1.1: 87 lines
get   tomcrypt/SCCS/s.mpi.h
tomcrypt/mpi.h 1.1: 225 lines
get   tomcrypt/SCCS/s.mycrypt_cfg.h
tomcrypt/mycrypt_cfg.h 1.4: 174 lines
get   tomcrypt/SCCS/s.mpi-types.h
tomcrypt/mpi-types.h 1.1: 19 lines
get   tomcrypt/SCCS/s.mycrypt.h
tomcrypt/mycrypt.h 1.2: 913 lines
get   SCCS/s.zgets.h
zgets.h 1.5: 23 lines
get   zlib/SCCS/s.deflate.h
zlib/deflate.h 1.4: 318 lines
get   zlib/SCCS/s.infblock.h
zlib/infblock.h 1.4: 39 lines
get   zlib/SCCS/s.infcodes.h
zlib/infcodes.h 1.4: 27 lines
get   zlib/SCCS/s.inffast.h
zlib/inffast.h 1.4: 17 lines
get   zlib/SCCS/s.inffixed.h
zlib/inffixed.h 1.2: 151 lines
get   zlib/SCCS/s.inftrees.h
zlib/inftrees.h 1.4: 58 lines
get   zlib/SCCS/s.infutil.h
zlib/infutil.h 1.4: 98 lines
get   zlib/SCCS/s.trees.h
zlib/trees.h 1.2: 128 lines
get   zlib/SCCS/s.zconf.h
zlib/zconf.h 1.4: 279 lines
get   zlib/SCCS/s.zlib.h
zlib/zlib.h 1.4: 893 lines
get   zlib/SCCS/s.zutil.h
zlib/zutil.h 1.3: 220 lines
cc -g -O2 -Wall -Wno-parentheses -Wno-char-subscripts -Wno-format-y2k -Wstrict-prototypes  -Izlib -Imdbm -c abort.c -o abort.o
get   SCCS/s.adler32.c
adler32.c 1.15: 144 lines
cc -g -O2 -Wall -Wno-parentheses -Wno-char-subscripts -Wno-format-y2k -Wstrict-prototypes  -Izlib -Imdbm -c adler32.c -o adler32.o
get   SCCS/s.admin.c
admin.c 1.122: 453 lines
cc -g -O2 -Wall -Wno-parentheses -Wno-char-subscripts -Wno-format-y2k -Wstrict-prototypes  -Izlib -Imdbm -c admin.c -o admin.o
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
