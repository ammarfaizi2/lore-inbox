Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264186AbTFPSlV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 14:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264178AbTFPSlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 14:41:00 -0400
Received: from aibn55.astro.uni-bonn.de ([131.220.96.55]:23238 "EHLO
	aibn55.astro.uni-bonn.de") by vger.kernel.org with ESMTP
	id S264201AbTFPShw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 14:37:52 -0400
Date: Mon, 16 Jun 2003 20:51:42 +0200 (CEST)
From: Ole Marggraf <marggraf@astro.uni-bonn.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [BUG] 2.4.21: NFS copy produces I/O errors
Message-ID: <Pine.LNX.4.55.0306162047140.6775@aibn99.astro.uni-bonn.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all.

As it seems (to me), there is some serious problem in the NFS code of
2.4.21 (and also of 2.4.20), causing I/O errors quite immediately.

Symptoms are as follows:

    Setup:

    Machine A, running 2.4.21 with NFSv3 client/server
    Machine B, running 2.4.19 with NFSv3 client/server
    (CONFIG_NFS_FS=y
     CONFIG_NFS_V3=y
     CONFIG_NFSD=y
     CONFIG_NFSD_V3=y
    )

    Both machines run the Kernel Automounter v4 (CONFIG_AUTOFS4_FS=y)

    (this should not matter: both machines are running debian testing,
     both have 3c905B ethernet cards)

We copy a file of ca. 100 MB size.

- logged in on machine A:
    cp /A_dir/file /B_dir: I/O error (after 1056768 bytes are written)

- logged in on machine B:
    cp /A_dir/file /B_dir: ok

No error messages are written to the logfiles (client and server), and the
same problem also occurs if we run 2.4.20 instead of 2.4.21.

If _both_ machines run 2.4.21, we get the same problem, i.e. pulling a
file via NFS to a local disk works, pushing to a remote disk fails.


Since we do not get any error messages in the logs, only the plain
"Input/output error" from cp, tracking down the problem is, from our side,
a bit difficult. The size of the file written until the error occurs could
help, it seems to be constant also for different files.

I am curious that this problem never had been observed before, since it
also seems to exist in 2.4.20. At least I did not find any previous
description in the archives.

If I can be of any further help, providing more information or do some
testing, just contact me. If you have any solution, please also give me a
hint ;-) This problem is a bit annoying...


Best regards,

Ole


-- 
+------------------------------------------------------------------------------+
 Ole Marggraf                     email: marggraf@gmx.net
 Sternwarte, Universitaet Bonn           marggraf@astro.uni-bonn.de
 Auf dem Huegel 71
 D-53121 Bonn, Germany            WWW:   http://www.astro.uni-bonn.de/~marggraf
+------------------------------------------------------------------------------+
