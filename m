Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbTIVR5X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 13:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbTIVR5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 13:57:17 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:45264 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261555AbTIVR5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 13:57:15 -0400
Subject: Re: 2.6.0-test5-mm4: BeFS compile error
From: Will Dyson <will_dyson@pobox.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20030922114958.GR6325@fs.tum.de>
References: <20030922013548.6e5a5dcf.akpm@osdl.org>
	 <20030922114958.GR6325@fs.tum.de>
Content-Type: text/plain
Message-Id: <1064253433.346.11.camel@thalience>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 22 Sep 2003 13:57:13 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-09-22 at 07:49, Adrian Bunk wrote:
> On Mon, Sep 22, 2003 at 01:35:48AM -0700, Andrew Morton wrote:
> >...
> > befs-use-parser.patch
> >   BEFS: Use table-driven option parsing
> >...
> 
> It seems this patch broke the compilation of BeFS:
> 
> <--  snip  -->
> 
> ...
>   CC      fs/befs/linuxvfs.o
> fs/befs/linuxvfs.c: In function `parse_options':
> fs/befs/linuxvfs.c:712: too few arguments to function `match_int'
> fs/befs/linuxvfs.c:724: too few arguments to function `match_int'
> make[2]: *** [fs/befs/linuxvfs.o] Error 1

Seems Andrew merged a different version of the options patch than the
one that was posted to the list. I can make a fixup tonight.

Also, from looking at the test5-mm4 patch, I think that match_number()
from lib/parser.c is ignoring the base argument and using a hardcoded
value of zero for the simple_strtol() call. This should result in
match_octal() and match_hex() being broken (well, being the same as
match_int).

-- 
Will Dyson
"Back off man, I'm a scientist!" -Dr. Peter Venkman

