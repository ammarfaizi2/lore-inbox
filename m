Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271374AbTHDCD6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 22:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271375AbTHDCD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 22:03:58 -0400
Received: from hera.cwi.nl ([192.16.191.8]:3544 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S271374AbTHDCD5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 22:03:57 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 4 Aug 2003 04:03:53 +0200 (MEST)
Message-Id: <UTC200308040203.h7423rv14876.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: do_div considered harmful
Cc: torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Writing this ide capacity patch an hour ago or so
I split off a helper sectors_to_MB() since Erik's recent
patch uses this also.
Now that I compare, he wrote
	nativeMb = do_div(nativeMb, 1000000);
to divide nativeMb by 1000000.
Similarly, I find in fs/cifs/inode.c
	inode->i_blocks = do_div(findData.NumOfBytes, inode->i_blksize);

So, it seems natural to expect that do_div() gives the quotient.
But it gives the remainder.
(Strange, Erik showed correct output.)

Since the semantics of this object are very unlike that of a C function,
I wonder whether we should write DO_DIV instead, or DO_DIV_AND_REM
to show that a remainder is returned.

Andries
