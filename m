Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129522AbQJaMP4>; Tue, 31 Oct 2000 07:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129694AbQJaMPp>; Tue, 31 Oct 2000 07:15:45 -0500
Received: from smtp2.Mountain.Net ([198.77.1.5]:50629 "EHLO
	nabiki.mountain.net") by vger.kernel.org with ESMTP
	id <S129522AbQJaMPf>; Tue, 31 Oct 2000 07:15:35 -0500
Message-ID: <39FEB5CB.C9AE37E6@mountain.net>
Date: Tue, 31 Oct 2000 07:06:35 -0500
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18pre13 i486)
X-Accept-Language: en-US,en-GB,en,fr,es,it,de,ru
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Fencepost error in ipv4/tulip?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Sometimes it almost works. I sent test10-pre6 to another
local machine (stock rh6.2). The problem box was running
vanilla test10-pre5, i486, gcc-2.95.2. The ether setup is
pnic2/tulip. mru is 1500.

Here's what came out the other end:

$ md5sum test10-pre6.bz2
d8453f77b50b48e7dafd683199cd132e  test10-pre6.bz2
$ ls -l test10-pre6.bz2
-rw-r--r--    1 tleete   tleete     333190 Oct 28 04:44
test10-pre6.bz2
$ cp test10-pre6.bz2 test10-pre6.bz2.bad
$ cp /mnt/floppy/test10-pre6.bz2 test10-pre6.bz2.good
$ md5sum test10-pre6.bz2.good
f71f05ce094e5c7cfabcb88a54e03e91  test10-pre6.bz2.good
$ cmp -l test10-pre6.bz2.bad test10-pre6.bz2.good
>bad-good.cmp

The md5sum of *.good agrees on both machines.

[Summary of bad-good.cmp]

bad[28814-29694] = {\367,..good[n+2]..,\232,\167}
good[28814-29694] = {\345,\125,\052,...}

bad[108003-110590] = {\070,\363,..good[n+2]..,\153,\344}
good[108003-110590] = {\234,\003,\012,\152,...}

bad[307121-314366] = {\170,\363,..good[n+2]..,\201,\355}
good[307121-314366] = {\101,\027,\351,\174,...}

bad[330977-331744] = {\270,\363,..good[n+2]..,\321,\125}
good[330977-331744] = {\235,\223,\045,\132,...}


I'd expect the error always to be present if it were from
miscompiling structs or bad userspace ftp. If it were
simple, the first block of errors would have the same
structure as the others.

I am puzzled.

Tom
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
