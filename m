Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265394AbTLHN0d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 08:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265395AbTLHN0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 08:26:33 -0500
Received: from relay.inway.cz ([212.24.128.3]:6619 "EHLO relay.inway.cz")
	by vger.kernel.org with ESMTP id S265394AbTLHN0a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 08:26:30 -0500
Message-ID: <3FD47BFC.9020008@scssoft.com>
Date: Mon, 08 Dec 2003 14:26:20 +0100
From: Petr Sebor <petr@scssoft.com>
Organization: SCS Software
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6b) Gecko/20031125
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: incorrect inode count on reiserfs
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have noticed this behavior when moving the inn2 news server to 
2.6.0-test11 kernel
from 2.4.23
(inn2 refuses to start because if free inode shortage)

2.6.0-test11:
df -i:

Filesystem            Inodes   IUsed   IFree IUse% Mounted on
/dev/sda1                  0       0       0    -  /
/dev/sdb1                  0       0       0    -  /mnt/sdb1

while df shows:
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/sda1            243208608  11069612 232138996   5% /
/dev/sdb1             36150172     32840  36117332   1% /mnt/sdb1

different reiserfs based machine with 2.4.23; this is where the inn2
used to work before, but the inode test was not failing because of the
'always-nonzero' inode count:

df -i
Filesystem            Inodes   IUsed   IFree IUse% Mounted on
/dev/hde1            4294967295       0 4294967295    0% /
/dev/hdg1            4294967295       0 4294967295    0% /mnt/d2

df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/hde1             77634256  77092844    541412 100% /
/dev/hdg1             38586912  19156508  19430404  50% /mnt/d2

another 2.6.0-test11 machine with ext2 reports inode counts correctly. 
my assumption is
that the problem is somehow reiserfs related, but my knowledge ends here.
all reiser fs's are of version 3.6

any ideas?

Petr

