Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129028AbRBGHpM>; Wed, 7 Feb 2001 02:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129135AbRBGHpC>; Wed, 7 Feb 2001 02:45:02 -0500
Received: from pizda.ninka.net ([216.101.162.242]:12416 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129028AbRBGHo6>;
	Wed, 7 Feb 2001 02:44:58 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14976.64684.579919.558725@pizda.ninka.net>
Date: Tue, 6 Feb 2001 23:43:40 -0800 (PST)
To: linux-kernel@vger.kernel.org
CC: netdev@oss.sgi.com
Subject: [UPDATE] New zerocopy patch.
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Against 2.4.2-pre1:

ftp://ftp.kernel.org/pub/linux/kernel/people/davem/zerocopy-2.4.2p1-2.diff.gz

Only one notable change since the last installment, but
an important one:

1) When doing paged SKB sendmsg(), use csum_and_copy_from_user
   instead of copy_from_user.

   The problem is that there appears to be some performance bug
   with some x86 processors when doing non-8-byte aligned memcpy
   operations via rep/movsl (P-II Mendocino is one known chip with
   the problem).

   So this change aims to remove this x86 anomaly from the zerocopy
   performance characteristics so we can see if there are some real
   implementation issues compared to running without the zerocopy
   patch applied.

   This is not to say that the x86 memcpy performance thing is being
   ignored, Linus and others are working on what to do about that
   seperately.

Please test, thanks.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
