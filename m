Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265137AbUAYSJJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 13:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265140AbUAYSJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 13:09:09 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:43513 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265137AbUAYSI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 13:08:59 -0500
Date: Sun, 25 Jan 2004 19:08:51 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Sid Boyce <sboyce@blueyonder.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc1-mm2 kernel oops
Message-ID: <20040125180851.GM513@fs.tum.de>
References: <4013DD6B.1030606@blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4013DD6B.1030606@blueyonder.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 25, 2004 at 03:14:51PM +0000, Sid Boyce wrote:
> Linus Torvalds wrote:
> > Problems with the exception table sorting?
> >
> > Does plain 2.6.2-rc1 work?
> 2.6.2-rc1 works fine.

Could you back out ("patch -p1 -R < ..." or manually remove the lines) 
the patch below and retry 2.6.2-rc1-mm2?

> Regards
> Sid.

TIA
Adrian


--- 25/Makefile~use-funit-at-a-time	2004-01-14 00:56:05.000000000 -0800
+++ 25-akpm/Makefile	2004-01-14 00:56:05.000000000 -0800
@@ -445,6 +445,10 @@ ifdef CONFIG_DEBUG_INFO
 CFLAGS		+= -g
 endif
 
+# Enable unit-at-a-time mode when possible. It shrinks the
+# kernel considerably.
+CFLAGS += $(call check_gcc,-funit-at-a-time,)
+
 # warn about C99 declaration after statement
 CFLAGS += $(call check_gcc,-Wdeclaration-after-statement,)
 

_
