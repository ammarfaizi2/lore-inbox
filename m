Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129718AbQJaQqg>; Tue, 31 Oct 2000 11:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129713AbQJaQq0>; Tue, 31 Oct 2000 11:46:26 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:11275 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129718AbQJaQqO>; Tue, 31 Oct 2000 11:46:14 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14846.63285.212616.574188@wire.cadcamlab.org>
Date: Tue, 31 Oct 2000 10:45:41 -0600 (CST)
To: Vladislav Malyshkin <mal@gromco.com>
Cc: R.E.Wolff@BitWizard.nl, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: test10-pre7
In-Reply-To: <39FEF039.69FAFDB2@gromco.com>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Vladislav Malyshkin <mal@gromco.com>]
> You can easily remove duplicates in object files without sorting.
> You can just use a shell written function.

This is true.  That was something I forgot to mention.  I have looked
at that as well, and it strikes me as even more of a hack than the
solutions I mentioned: it is yet another external shell process for
each invocation of Rules.make (ie each directory).  As I said before,
though, one man's hack is another man's clean design, so whatever.

Your function is rather long; try this one instead (untested):

  remove_duplicates () {
    str='';
    for i; do
      case "$str " in *" $i "*) ;; *) str="$str $i" ;; esac
    done
    echo "$str"
  }

I still think anything outside the makefiles that's needed to organize
the build process is a hack.  That includes scripts/pathdown.sh (yes, I
do have a scheme to get rid of it) and 2.2.18 scripts/kwhich (yes, I
did propose a working alternative).  It doesn't include scripts/mkdep.c
(which must do a lot of work as efficiently as possible),
scripts/Configure et al (which are really standalone programs), or
scripts/split-include.c (which is really a continuation of Configure).

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
