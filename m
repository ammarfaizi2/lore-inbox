Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135304AbQL3SXv>; Sat, 30 Dec 2000 13:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135248AbQL3SXm>; Sat, 30 Dec 2000 13:23:42 -0500
Received: from p3EE3C958.dip.t-dialin.net ([62.227.201.88]:10756 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S132865AbQL3SX3>; Sat, 30 Dec 2000 13:23:29 -0500
Date: Sat, 30 Dec 2000 18:30:38 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: How to write patches
Message-ID: <20001230183038.B1950@emma1.emma.line.org>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOL.3.96.1001229234454.12681A-100000@kohinoor.csa.iisc.ernet.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.SOL.3.96.1001229234454.12681A-100000@kohinoor.csa.iisc.ernet.in>; from sourav@csa.iisc.ernet.in on Fri, Dec 29, 2000 at 23:52:05 +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Dec 2000, Sourav Sen wrote:

> 
> Hi,
> 
> This question may seem naive, but can anyone tell me if there is any
> structured way of writing patches? 

1. get a base tree, e. g. 2.2.18, and unpack it into /usr/src 
   (rename your old /usr/src/linux first)
2. rename linux you got in 1. to linux-2.2.18 or whatever is appropriate
3. cp -a -l linux-2.2.18 linux-2.2.18-ss1 (your initials and a number)
   that makes hard links which speeds up diff a lot
   WARNING: IF YOU HAVE AN EDITOR THAT DOES NOT RENAME THE ORIGINAL TO A
   BACKUP FILE NAME, YOU MUST NOT USE -l HERE! (You'd end up editing the
   copy AND the original and your diff would be empty.)
   (break link and copy on write would be a cool feature for the fs...)
4. ln -sfn linux-2.2.18-ss1 linux
5. go edit your ss1 tree with an editor that makes backups by renaming
   before it writes out its files (emacs does in default configuration,
   vi does not!)
6. if your -ss1 kernel is ready for release, save your .config from
   /usr/src/linux somewhere you'll find it (for convenience).
7. cd /usr/src/linux ; make distclean
8. cd /usr/src
9. diff -Nur linux-2.2.18 linux-2.2.18-ss1 | gzip -9c >patch-2.2.18-ss1.gz

With diff, that's OLD NEW (or FROM TO), nothing really difficult since
it's the same way as in mv or cp.

-- 
Matthias Andree
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
