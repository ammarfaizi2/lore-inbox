Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317286AbSGODFN>; Sun, 14 Jul 2002 23:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317298AbSGODFM>; Sun, 14 Jul 2002 23:05:12 -0400
Received: from purple.csi.cam.ac.uk ([131.111.8.4]:55953 "EHLO
	purple.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S317286AbSGODFL>; Sun, 14 Jul 2002 23:05:11 -0400
Subject: [BK-PATCH-2.5] Fix debugging check in async i/o completion handlers
To: torvalds@transmeta.com (Linus Torvalds)
Date: Mon, 15 Jul 2002 04:08:05 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17TwDV-0001Zr-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The buffer_mapped(bh) checks in the async io completion handlers should
actually be buffer_mapped(tmp).

However, since buffers marked async_read or async_write must be locked,
execution should always "goto still_busy;" and hence why the conditional
BUG() can and should be made uncoditional.

Andrew Morton acked that the change for the async_read case makes sense.

I later noticed the async_write case is identical hence why I change both
here.

Patch is both compile, boot, and run tested. As expected, no problems.

Please apply.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

This will update the following files:

 fs/buffer.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (02/07/15 1.632)
   Fix&improve debugging checks in async io completion handlers.
   Beffers marked for async io must be locked!


diff -Nru a/fs/buffer.c b/fs/buffer.c
--- a/fs/buffer.c	Mon Jul 15 03:58:04 2002
+++ b/fs/buffer.c	Mon Jul 15 03:58:04 2002
@@ -519,8 +519,7 @@
 		if (buffer_async_read(tmp)) {
 			if (buffer_locked(tmp))
 				goto still_busy;
-			if (!buffer_mapped(bh))
-				BUG();
+			BUG();
 		}
 		tmp = tmp->b_this_page;
 	} while (tmp != bh);
@@ -570,8 +569,7 @@
 		if (buffer_async_write(tmp)) {
 			if (buffer_locked(tmp))
 				goto still_busy;
-			if (!buffer_mapped(bh))
-				BUG();
+			BUG();
 		}
 		tmp = tmp->b_this_page;
 	}

===================================================================

This BitKeeper patch contains the following changesets:
aia21@cantab.net|ChangeSet|20020715025751|04609
## Wrapped with gzip_uu ##


begin 664 bkpatch2788
M'XL(`#TZ,CT``]V486^;,!"&/^-?<5.E:545\!D;`E.F+,W659VT*%-^@#%.
M@@(X`I.N$S]^;BHEV;JMZM1/`S[`:]_Y[KU'G,'U-/6L:7:RS-NQM.O2U+YM
M9-U6VDI?F:J_7,MZI;]JVS-*F;L%QB$548\1Y7&O,$>4''5.&1]&G)S!HM5-
MZLE",G1?GTQK4T_)VLK,K[5UTMP8)P5=VP1MHX*2B4'6+8E;F4FKUK#339MZ
MZ(<'Q=YM=>K-/UPM/K^?$S(:P:$L&(W(RW9PR+8VE?Y[KA@%1>0LZBD724*F
M@'X4,J`LH'&``FB8BC@5>$$QI13VIHR/9L`%PH"2";QL!Y=$P<?BV^NBVC9F
MIR'76;=:%?4*U%JK30M%#;*]JQ44!MP!VU+;PM3@CLE+9[[OXB=ZN72O4,EF
MHW-8FN884G6MA4Q#:91;>T5N@$<T(;/C5,C@F1<A5%+R[@DCEFW@2'%U^>K4
MBB0<]I0AQ3[+-..1Q%@IEF11\LCQQRGN9\A$S%D?T9#%>[I.-CW-U[.+(G*S
MK<;?B^U]N"^[W]=$6132/N(<<<\5AO@K5YS]D2L&`_X?</4PDB\P:&[WCP-E
M=CJ=?^!L*A@#1JX%"P&)YWF3Q=6;\[=.C\.]'O.?],-/Z*''KAIAS)08RIS\
)`.F!-H=`!0``
`
end
