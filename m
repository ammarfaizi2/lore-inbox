Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269437AbRIJJaU>; Mon, 10 Sep 2001 05:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269779AbRIJJaK>; Mon, 10 Sep 2001 05:30:10 -0400
Received: from [195.66.192.167] ([195.66.192.167]:43019 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S269437AbRIJJ37>; Mon, 10 Sep 2001 05:29:59 -0400
Date: Mon, 10 Sep 2001 12:28:51 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <8015001541.20010910122851@port.imtp.ilyichevsk.odessa.ua>
To: John Ripley <jripley@riohome.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: COW fs (Re: Editing-in-place of a large file)
In-Reply-To: <3B9B80E2.C9D5B947@riohome.com>
In-Reply-To: <20010902152137.L23180@draal.physics.wisc.edu>
 <318476047.20010903002818@port.imtp.ilyichevsk.odessa.ua>
 <3B9B80E2.C9D5B947@riohome.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

JR> I've tried this idea. I did an MD5 of every block (4KB) in a partition
JR> and counted the number of blocks with the same hash. Only about 5-10% of
JR> blocks on several filesystem were actually duplicates. This might be
JR> better if you reduced the block size to 512 bytes, but there's a
JR> question of how much extra space filesystem structures would then take
JR> up.

JR> Basically, it didn't look like compressing duplicate blocks would
JR> actually be worth the extra structures or CPU.

JR> On the other hand, a COW fs would be excellent for making file copying
JR> much quicker. You can do things like copying the linux kernel tree using
JR> 'cp -lR', but the files do not act as if they are unique copies - and
JR> I've been bitten many times when I forgot this. If you had COW, you
JR> could just copy the entire tree and forget about the fact they're
JR> linked.

Yeah, I'm mostly thinking about this kind of COW fs usage. You may copy
gigabytes in the instant and don't bother about tracking duplicate
files ("zero blocks left??? where's the hell I copied that .mpg's???").

Now, sometimes we use hardlinks as "poor man's COW fs", but
I bet it's error prone. Every now and then you forget it's a
hardlinked kernel tree and start happily hacking in it... :-(

A "compressor" which hunts and merges duplicate blocks is a bonus,
not a primary tool.
-- 
Best regards,
VDA
mailto:VDA@port.imtp.ilyichevsk.odessa.ua
http://port.imtp.ilyichevsk.odessa.ua/vda/


