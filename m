Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285634AbRL0DMw>; Wed, 26 Dec 2001 22:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286196AbRL0DMm>; Wed, 26 Dec 2001 22:12:42 -0500
Received: from sproxy.gmx.de ([213.165.64.20]:20025 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S285634AbRL0DM2>;
	Wed, 26 Dec 2001 22:12:28 -0500
Date: Thu, 27 Dec 2001 04:09:46 +0100
From: Christian Ohm <chr.ohm@gmx.net>
To: Oleg Drokin <green@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: file corruption in 2.4.16/17
Message-ID: <20011227030946.GA472@moongate.thevoid.net>
In-Reply-To: <20011222220223.GA537@moongate.thevoid.net> <3C26F2AC.1050809@namesys.com> <20011225004459.GB3752@moongate.thevoid.net> <3C285384.3020302@namesys.com> <20011226005327.GA3970@moongate.thevoid.net> <20011226092024.A871@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011226092024.A871@namesys.com>
User-Agent: Mutt/1.3.24i
Organization: theVoid
X-Operating-System: Linux moongate 2.4.17 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > i'll just copy some files from the old to the new drive and diff them to see
> > if they get corrupted with a plain 2.4.17 kernel. if they do, any ideas how

well, tried that. got corrupted files.

> > to track it down further?
> Perhaps several samples of corrupted files (and their original versions),

i examined some of those files. results: it seems like some parts of the
files i copied get written to the wrong destination on the disk, since i
discovered something that looked like kernel source (one of the things i
copied) in one of those files. sometimes there's some of the original
content still at the end of the file.

> also make sure that while this corruption occurs with reserfs on the new drive, it
> does not occurs with non-reiserfs filesystem on the new drive.

as i said, i copied about 15gb to a fat32 partition and about 3gb to a
reiserfs partition. i diffed the fat32 and found not a single error. on the
reiserfs partition some of the present files got corrupted, and some of the
copied files, too. though i don't know if they got corrupted because of
other files that were copied or because some of their blocks ended up in
other files.

that was /var. on /usr (my second reiserfs partition), otoh, i haven't found
corrupted files yet. 

> Also try to copy your files and see if you get random corrupted files or is the corrupted
> filelist is the same all the time.

i copied the same files again, and got the same files (or at least files in
the same dir) corrupted again.

> Look into your log for any strange messages. (you might even recompile your
> kernel with CONFIG_REISERFS_CHECK enabled to allow for more checks to be made)

after some copying, i discovered this nice message:
---
vs-4080: reiserfs_free_block: free_block (0306:801711)[dev:blocknr]: bit
already cleared
---

then i copied the same files again, overwriting the old copy. after a while,
the system hang with 100% cpu used, and i got lots of those on the console:
---
vs-3050: wait_buffer_until_released: nobody releases buffer (dev 03:06, size
4096 blocknr 688128, count 3, list 0, state 0x10019, page c17a0540,
(UPTODATE, CLEAN, UNLOCKED)). still waiting (-150000000)  JDIRTY !JWAIT
---

after a reboot, i tried it again. similar result, though i didn't see any
messages anymore. another reboot, and the file system seemed to be garbage
(wouldn't mount), yet after yet another reboot, i could mount it again, but
with lots of errors when accessing it. then i scrapped another partition,
created a new reiserfs one and copied the files over.

i think i'll create a fat32 partition where the old reiserfs one was, to see
if i get some errors there. if i do, this could be a hardware issue after
all...

bye
christian ohm
