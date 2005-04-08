Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262871AbVDHQdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262871AbVDHQdc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 12:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262872AbVDHQdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 12:33:32 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:23089 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262871AbVDHQdR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 12:33:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=V8LcH3n0pHZ7TdpMFT2K8JsBSIi4nzGmV/OOUPj0b6A60WOUPIQRPk5kvCBj7sDAwt+ifFWCH0sd4p+bvHU9ciWHByIrkkcYrr4/SRc1vH+789Fw5zxYEEdf9D2KlFi4lLbYYH5nQfottImqmJI51RLb9c7EpRBQSNxjMxfHJjs=
Message-ID: <ecb4efd1050408093378a376d4@mail.gmail.com>
Date: Fri, 8 Apr 2005 12:33:15 -0400
From: Clem Taylor <clem.taylor@gmail.com>
Reply-To: Clem Taylor <clem.taylor@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: re: x86-64 bad pmds in 2.6.11.6
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones reported seeing bad pmd messages in 2.6.11.6. I've been
seeing them with 2.6.11 and today with 2.6.11.6. When I first saw the
problem I ran memtest86 and it didn't catch anything after ~3hours.
However, I don't see them when X starts. They tend to happen after a
program segfaults:

2.6.11:
Apr  3 23:23:33 klaatu kernel: sh[16361]: segfault at 0000000000000000
rip 0000000000000000 rsp 00007ffffffff020 error 14
Apr  3 23:23:33 klaatu kernel: mm/memory.c:97: bad pmd
ffff810027171010(00000000006b68b9).
.. many more ...

2.6.11.6:
Apr  8 12:03:17 klaatu kernel: grep[20971]: segfault at
0000000000000000 rip 0000000000000000 rsp 00007ffffffff090 error 14
Apr  8 12:03:17 klaatu kernel: mm/memory.c:97: bad pmd
ffff810095929010(0000000000000015).
.... many more ...
Apr  8 12:03:18 klaatu kernel: mm/memory.c:97: bad pmd
ffff8100959299d0(000034365f363878).
Apr  8 12:03:18 klaatu kernel: grep[21116]: segfault at
0000000000000000 rip 0000000000000000 rsp 00007ffffffff0a0 error 14
Apr  8 12:03:18 klaatu kernel: mm/memory.c:97: bad pmd
ffff810095f5b000(000000000000000f).
...

At the time I was doing a
find ... -exec grep -H ...
over a linux kernel tree.

I repeated the find and I didn't see segfaults the second run.

                                --Clem
