Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271937AbTGYG5B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 02:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271940AbTGYG5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 02:57:01 -0400
Received: from ns.suse.de ([213.95.15.193]:13574 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S271937AbTGYGzH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 02:55:07 -0400
From: Andreas Gruenbacher <agruen@suse.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Linux 2.4.22-pre8
Date: Fri, 25 Jul 2003 09:10:38 +0200
User-Agent: KMail/1.5.1
Cc: lkml <linux-kernel@vger.kernel.org>
References: <Pine.GSO.4.21.0307250301030.28325-100000@vervain.sonytel.be>
In-Reply-To: <Pine.GSO.4.21.0307250301030.28325-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ufNI/hUM3+utY3c"
Message-Id: <200307250910.38758.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_ufNI/hUM3+utY3c
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Geert and Marcelo,

it turns oout that the warning is bogus, and trivially fixed. Marcelo, you may 
want to apply the attached patch.

Cheers,
Andreas.

On Friday 25 July 2003 03:05, Geert Uytterhoeven wrote:
> On Thu, 24 Jul 2003, Marcelo Tosatti wrote:
> > Andreas Gruenbacher:
> >   o unshare-files fix breaks file locks
>
> Which adds one more warning (the third one below) to my build log:
> | ide.c:175: warning: `ide_scan_direction' defined but not used
> | ide-lib.c:174: warning: comparison of distinct pointer types lacks a cast
> | binfmt_elf.c:446: warning: `files' might be used uninitialized in this
> | function
>
> Seems to be harmless, though.

--Boundary-00=_ufNI/hUM3+utY3c
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="binfmt_elf-warning.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="binfmt_elf-warning.diff"

--- linux-2.4.22-pre8.orig/fs/binfmt_elf.c	2003-07-25 08:58:59.000000000 +0200
+++ linux-2.4.22-pre8/fs/binfmt_elf.c	2003-07-25 08:59:07.000000000 +0200
@@ -797,10 +797,8 @@
 	if (current->ptrace & PT_PTRACED)
 		send_sig(SIGTRAP, current, 0);
 	retval = 0;
+	steal_locks(files, current->files);
 out:
-	if (!retval)
-		steal_locks(files, current->files);
-
 	return retval;
 
 	/* error cleanup */

--Boundary-00=_ufNI/hUM3+utY3c--

