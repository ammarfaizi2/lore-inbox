Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274791AbRIZCpO>; Tue, 25 Sep 2001 22:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274810AbRIZCpE>; Tue, 25 Sep 2001 22:45:04 -0400
Received: from smtp.networkusa.net ([216.162.106.18]:41733 "EHLO
	smtp.networkusa.net") by vger.kernel.org with ESMTP
	id <S274791AbRIZCos>; Tue, 25 Sep 2001 22:44:48 -0400
Subject: ReiserFS freeze and corruption
From: Ian Zink <zforce@networkusa.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13 (Preview Release)
Date: 25 Sep 2001 21:46:25 -0500
Message-Id: <1001472385.784.29.camel@zforce>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I am not subscribed to the list please CC me on any response]

About 15minutes ago now, I was merrily gzipping a 370 meg file. I was
checking the progress doing "du file." At about 260 megs I did a "du
file" and the du failed to respond. I tried to ctrl-c du and then gunzip
to no avail. I tried to open a new console to forcibly kill the process.
It wouldn't open. It seemed anything trying to touch the file system
would fail. I then switched to to the text console tried to login from
there, and it froze. Finally, I sucumbed to the fact my system was in
fact going down. I tried to sync the file system alt-sysrq-s. However, I
did not receive the tale-tell "sync" noise. I tried it again... no go. I
tried to flip back into my X session, where in everything just flat out
froze. Upon rebooting (alt-sysrq-b), I received the message reiserfs was
going to roll back its log:

Replay starting
Replay Failure
03:02 rw-1 want=1075572264 limit=6401902

Reiserfs: run fsck.

I managed to find a CD-rescue disk with reiserfs fsck. Upon running it,
it rolled back the journal ( which apparently the kernel couldn't do)
found errors and told me to rebuild the tree. Because I now fimiliar
with the rebuild tree behavior of fsck(that is, you lose random files),
I decided to not go that route... I ran reiserfsck again with the -x
parameter, and it said no errors found. So some how.. the errors
disappeared. Okay. Now everything _seems_ to be intact. However, as
another person pointed out, aparently with reiserfs when things fail you
can random file cross-tamination when reiserfs replays its logs. 

Now for a few details:
Kernel: 2.4.10
gcc version 2.95.4
IBM Deskstar IBM-DTTA-371440
hdparm -X66 -m16 -u1 -c1 -k1 -d1 /dev/hda
Chipset:  Intel Corporation 82371AB PIIX4 IDE
These messages right before the crash:

Sep 25 20:53:13 zforce kernel: attempt to access beyond end of device
Sep 25 20:53:13 zforce kernel: 03:02: rw=1, want=1077688052,
limit=6401902
Sep 25 20:53:22 zforce kernel: attempt to access beyond end of device
Sep 25 20:53:22 zforce kernel: 03:02: rw=1, want=1078220580,
limit=6401902
Sep 25 20:53:42 zforce kernel: attempt to access beyond end of device
Sep 25 20:53:42 zforce kernel: 03:02: rw=1, want=1078289876,
limit=6401902
Sep 25 20:55:04 zforce kernel: attempt to access beyond end of device
Sep 25 20:55:04 zforce kernel: 03:02: rw=1, want=1078444424,
limit=6401902
Sep 25 20:55:26 zforce kernel: attempt to access beyond end of device
Sep 25 20:55:26 zforce kernel: 03:02: rw=1, want=1078470640,
limit=6401902
Sep 25 20:56:20 zforce kernel: attempt to access beyond end of device
Sep 25 20:56:20 zforce kernel: 03:02: rw=1, want=1075572264,
limit=6401902

If you need any more information feel free to contact me.

Thanks,

Ian Zink

