Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264603AbSIQVng>; Tue, 17 Sep 2002 17:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264605AbSIQVng>; Tue, 17 Sep 2002 17:43:36 -0400
Received: from [63.205.85.133] ([63.205.85.133]:64017 "EHLO schmee.sfgoth.com")
	by vger.kernel.org with ESMTP id <S264603AbSIQVnf>;
	Tue, 17 Sep 2002 17:43:35 -0400
Date: Tue, 17 Sep 2002 14:47:10 -0700
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Adrian Bunk <bunk@fs.tum.de>, torvalds@transmeta.com
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.35 drivers/atm/firestream.c __FUNCTION__ fix
Message-ID: <20020917144710.C94419@sfgoth.com>
References: <20020916212331.B70462@sfgoth.com> <Pine.NEB.4.44.0209171033460.26796-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.NEB.4.44.0209171033460.26796-100000@mimas.fachschaften.tu-muenchen.de>; from bunk@fs.tum.de on Tue, Sep 17, 2002 at 10:37:30AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> Thanks for this patch, the next compile error is that compilation of
> firestream.c fails at all occurences of func_enter:

This is just the breakage that newer gcc's provoke when you try to use
__FUNCTION__ as a string constant.  Easy fix (included at end of message,
Linus please apply)

> > -Mitch  (deadbeat ATM maintainer)
> 
> I didn't Cc you because you are only listed as PPP OVER ATM (RFC 2364)
> maintainer in MAINTAINERS. Do you now maintain the complete ATM subsystem?

I'm sort of the maintainer, if there is one at all.  Werner handed me the
torch a year and a half ago since he has other projects and I was one of
the few people still hacking on the core ATM code.  At the time I was doing
some related work so it fit naturally.  Unfortunately, I'm not working
in that field at the moment and my other commitments are taking about 110%
of my time.  I've been trying to keep it sort of maintained in the meantime
(keeping it compiling, basic mailing list admin) but sadly that's been about
it from me lately.  :-(

-Mitch

--- linux-2.5.35-VIRGIN/drivers/atm/firestream.c	2002-08-24 00:08:21.000000000 -0700
+++ linux-2.5.35/drivers/atm/firestream.c	2002-09-17 14:34:57.000000000 -0700
@@ -330,8 +330,8 @@
 #define FS_DEBUG_QSIZE   0x00001000
 
 
-#define func_enter() fs_dprintk (FS_DEBUG_FLOW, "fs: enter " __FUNCTION__ "\n")-#define func_exit()  fs_dprintk (FS_DEBUG_FLOW, "fs: exit  " __FUNCTION__ "\n")+#define func_enter() fs_dprintk (FS_DEBUG_FLOW, "fs: enter %s\n", __FUNCTION__)+#define func_exit()  fs_dprintk (FS_DEBUG_FLOW, "fs: exit  %s\n", __FUNCTION__) 
 
 struct fs_dev *fs_boards = NULL;
