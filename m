Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261978AbSJNQcd>; Mon, 14 Oct 2002 12:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262006AbSJNQcd>; Mon, 14 Oct 2002 12:32:33 -0400
Received: from pop.gmx.de ([213.165.64.20]:49083 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261978AbSJNQcc>;
	Mon, 14 Oct 2002 12:32:32 -0400
Message-ID: <3DAAF2DF.9010809@gmx.net>
Date: Mon, 14 Oct 2002 18:37:51 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2002-Q4@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.1) Gecko/20020826
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Loop on top of NFS hangs kernel
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I have a small problem with my configuration which results in a deadlock
after ~1 minute. As soon as the copying hangs, I can still switch to another
console but not execute any command or write anything to any disk. SysRq-S
and SysRq-U both never complete and the output of SysRq-P or SysRq-T never
hits the disk.

Steps to reproduce:
mount -t nfs server:/two /mnt/server/
losetup -e twofish /dev/loop0 /mnt/server/file.dat
mount -t ext2 /dev/loop0 /mnt/cryptfs/
cp -a /usr/bin/* /mnt/cryptfs/
<hang>

Kernel is 2.4.18-SuSE. I'm willing to try any 2.4 (or for that matter, 2.5) 
kernel or additional patches if this helps.

_This hang could also be reproduced without any encryption._

The Encryption Howto says the above was not possible with 2.2 kernels back
in 2000. However, I was unable to find anything more recent with google. If
(crypto)loop is still impossible over NFS, can I do something to fix it?
Even a quick hack would be perfect for me.

If the problem is in allocating memory for the loop device, preallocating a
certain amount of memory and limiting request size for above layers to that
amount (or a fraction on it, depending on how much memory for encryption is
needed) should cure the problem, right?
If the problem is in allocating memory for the NFS client, the preallocation
trick should work too. Or am I missing something here?

If fixing this problem is impossible, can we at least disallow the setup of 
loop devices on top of NFS so nobody gets bitten by this one?

Thanks for your help.

Regards,

Carl-Daniel

-- 
Random quote:
That one can't ever actually happen -- it's effectively a default case in a
switch statement which can't ever be reached because we'd never get that far
unless one of the real cases is going to be taken. I think I'll replace the
return statement with panic("The world is broken");
-- David Woodhouse


