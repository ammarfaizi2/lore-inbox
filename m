Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129231AbQLFWVW>; Wed, 6 Dec 2000 17:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129683AbQLFWVN>; Wed, 6 Dec 2000 17:21:13 -0500
Received: from mout1.freenet.de ([194.97.50.132]:44929 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S129231AbQLFWU6>;
	Wed, 6 Dec 2000 17:20:58 -0500
From: mkloppstech@freenet.de
Message-Id: <200012062150.WAA01033@john.epistle>
Subject: Ext2-fs error
To: linux-kernel@vger.kernel.org
Date: Wed, 6 Dec 2000 22:50:43 +0100 (CET)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The EXT2-fs errors I recently reported for test11 seem to be gone with
test12-pre5. At least I couldn't reproduce the error, neither with
overcommit_memory turned on nor off; maybe the error was due to
turning on write cache of my hard disk.

The error was a wrong reading of directory lengths and inode nnumbers:
The file system seemed to read the inode numbers not as supposed to do:
xxxx|xxxx|xxxx|xxxx|xxxx
     rrrr

but like this:
xxxx|xxxx|xxxx|xxxx|xxxx
 rrr_r
The message was:

Dec  4 13:04:19 john kernel: EXT2-fs error (device ide0(3,3)): ext2_readdir: bad entry in directory #280596: rec_len % 4 != 0 - offset=0, inode=68583844, rec_len=13758, name_len=0
Dec  4 15:38:07 john kernel: EXT2-fs error (device ide0(3,3)): ext2_readdir: bad entry in directory #280596: rec_len % 4 != 0 - offset=0, inode=33188, rec_len=3591, name_len=0
Dec  4 15:38:07 john kernel: EXT2-fs error (device ide0(3,3)): ext2_readdir: bad entry in directory #659481: directory entry across
blocks - offset=0, inode=33188, rec_len=2536, name_len=0
Dec  4 15:39:38 john kernel: EXT2-fs error (device ide0(3,3)): ext2_readdir: bad entry in directory #280596: rec_len % 4 != 0 - offset=0, inode=33188, rec_len=3591, name_len=0
Dec  4 15:39:38 john kernel: EXT2-fs error (device ide0(3,3)): ext2_readdir: bad entry in directory #659481: directory entry across
blocks - offset=0, inode=33188, rec_len=2536, name_len=0

Mirko Kloppstech
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
