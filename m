Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135640AbRAHKmk>; Mon, 8 Jan 2001 05:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136499AbRAHKma>; Mon, 8 Jan 2001 05:42:30 -0500
Received: from frontier.axistangent.net ([63.101.14.200]:24309 "EHLO
	foozle.turbogeek.org") by vger.kernel.org with ESMTP
	id <S135640AbRAHKmS>; Mon, 8 Jan 2001 05:42:18 -0500
Date: Mon, 8 Jan 2001 04:42:18 -0600
From: "Jeremy M. Dolan" <jmd@foozle.turbogeek.org>
To: linux-kernel@vger.kernel.org
Subject: Extraneous whitespace removal?
Message-ID: <20010108044218.A9610@foozle.turbogeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I'll let the number speak:

$ cp -R linux-2.4.0 linux-2.4.0-trimed
$ find linux-2.4.0-trimed -type f | xargs perl -wi -pe 's/\s+$/\n/'
$ du -s linux-2.4.0 linux-2.4.0-trimed
119360  linux-2.4.0              # NOTE: 4k blocks, just an estimate
119160  linux-2.4.0-trimed

$ diff -ru linux-2.4.0 linux-2.4.0-trimed > trimed.diff
$ ls -l trimed.diff*
-rw-r--r--   1 jmd      users    19131225 Jan  8 01:49 trimed.diff
-rw-r--r--   1 jmd      users     4732306 Jan  8 01:50 trimed.diff.gz
-rw-r--r--   1 jmd      users     3819235 Jan  8 01:52 trimed.diff.bz2

Pluses:
 - clean up messy whitespace
 - cut precious picoseconds off compile time
 - cut kernel tree by 200k (+/- alot)

Minuses:
 - adds 3.8M bzip2 or 4.7M gzip to next diff

Notes:
 - Don't actually use the above perl s// command. Instead, use
   [<tab><space>] in place of the \s. The problem with \s is it
   includes page breaks. I only included this one since the one with
   tab isn't cut&paste-able.
 - I'm not yet positive there are no other places in the tree that
   aren't safe to s/[<tab><space>]+$//. C can, if formated poorly
   enough, be affected by it (multiline strings not ending with \).
   Can anyone very familiar with Makefile/DocBook/TeX/asm syntax
   comment if they could also be potentially affected?
 - Another place to save space is extraneous \n's before EOF. I think
   that saves an aditional 15k or so, based on rough estimates with
   grep.
 - Yes, I am pretty pedantic to propose a 19M patch that doesn't *DO*
   anything.
 
-- 
Jeremy M. Dolan <jmd@turbogeek.org>
OpenPGP key = http://turbogeek.org/openpgp-key
OpenPGP fingerprint = 494C 7A6E 19FB 026A 1F52  E0D5 5C5D 6228 DC43 3DEE
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
