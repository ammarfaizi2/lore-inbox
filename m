Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279382AbRKAROo>; Thu, 1 Nov 2001 12:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279389AbRKAROf>; Thu, 1 Nov 2001 12:14:35 -0500
Received: from mustard.heime.net ([194.234.65.222]:30115 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S279382AbRKAROW>; Thu, 1 Nov 2001 12:14:22 -0500
Date: Thu, 1 Nov 2001 18:14:11 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: <reiser@namesys.com>, <linux-kernel@vger.kernel.org>
Subject: writing a plugin for reiserfs compression
Message-ID: <Pine.LNX.4.30.0111011754580.2106-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

I got this idea the other day...

Novell NetWare has a feature I really like. It's a file compression
feature they've been having since version 4.0 (or 4.10) of the OS.

- Once a day, a job is run to compress all files that havent been touched
within <n> days - default 14, that have not been flagged CAN'T COMPRESS
or DON'T COMPRESS (see below).

- After the file is compressed, it's checked against the compression
gain. If this is less than <n> per cent (default 30), the compressed
version is being deleted and the file is flagged CAN'T COMPRESS. If the
file is compressed, the uncompressed version is being deleted and the file
is flagged COMPRESSED.

- When a compressed file is accessed, it'll be decompressed on the fly and
flagged ACCESSED AFTER COMPRESSION. The next time it's accessed within the
given <n> days (above), it's decompressed and the compressed file
discarded. The flag COMPRESSED is cleared.

Files can be flagged 'DON'T COMPRESS' and 'FORCE COMPRESS' manually by the
user or admin. 'FORCE COMPRESS' is dominant over 'CAN'T COMPRESS'.

The result is that you're saving loads of space (typically 50-70% on a
netware file server) and, since the compression job is batched up
(typically by night), the performance penalty is minimal. File
decompression will happen quite rarely, as only the least-accessed files
are compressed.

TODO:
New attributes must be added somehow. 'ls' and 'find' and perhaps other
files must be modified to take advantage of this. The compression job can
be a simple script with something like

	find . -type f ! --compressed ! --dont-compress / -exec fcomp {} \;

(and check can't compress and force compression).

There must be a way to access the compressed files directly to make
backups more efficient - backing up already compressed files's a good
thing.

COMMENT:
And yes - I know a lot of people are saying this is something we don't
need, as diskspace doesn't cost anything today compared to what it used
to. The first time I heard that, was in '92. We're always using too much
diskspace!

Please cc: to me as I'm not on the list

roy
---
Praktiserende dyslektiker.
La ikke ortografiske krumspring skygge for
intensjonen bak denne fremstilling.

