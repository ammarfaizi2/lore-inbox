Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264232AbSIQOux>; Tue, 17 Sep 2002 10:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264210AbSIQOux>; Tue, 17 Sep 2002 10:50:53 -0400
Received: from maroon.csi.cam.ac.uk ([131.111.8.2]:59270 "EHLO
	maroon.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S264232AbSIQOuv>; Tue, 17 Sep 2002 10:50:51 -0400
Subject: [BK-PATCH-2.5] Export unmap_underlying_metadata() to modules.
To: torvalds@transmeta.com (Linus Torvalds)
Date: Tue, 17 Sep 2002 15:55:51 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17rJlX-0006Ch-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The below bk patch against your current bk repository adds an
export for fs/buffer.c::unmap_underlying_metadata() to modules.

It is required to make ntfs compile as a module in the current
kernel.

Note that NTFS doesn't currently dirty bufferheads of the underlying
blockdevice and as such could probably live without calling
unmap_underlying_metadata() but as soon as we enable writing to
compressed files it will do so and considering some of the
infrastructure code is already present I would rather not rip it
out now.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

This will update the following files:

 fs/buffer.c |    1 +
 1 files changed, 1 insertion(+)

through these ChangeSets:

<aia21@cantab.net> (02/09/07 1.497.59.1)
   Export unmap_underlying_metadata() to fix NTFS as a module.


diff -Nru a/fs/buffer.c b/fs/buffer.c
--- a/fs/buffer.c	Tue Sep 17 15:18:13 2002
+++ b/fs/buffer.c	Tue Sep 17 15:18:13 2002
@@ -1623,6 +1623,7 @@
 		__brelse(old_bh);
 	}
 }
+EXPORT_SYMBOL(unmap_underlying_metadata);
 
 /*
  * NOTE! All mapped/uptodate combinations are valid:

===================================================================

This BitKeeper patch contains the following changesets:
aia21@cantab.net|ChangeSet|20020917132817|59155
aia21@cantab.net|ChangeSet|20020907133546|04874
## Wrapped with gzip_uu ##


begin 664 bkpatch6574
M'XL(`*4YAST``]56:T_;,!3]7/\*2WP!H::^?B7.U*F\QM#HJ`I(VR?D)FX;
MT215'EU!^?%SP]0R"J.=V"22*%$<WVO?<\X]R@X^._8;19K-]"3,.[H83]+$
M*3*=Y+$IM!.D<74TULG(7)JBHH10>PIP&1&R`DFX6P40`F@.)B24>Y*C'7R=
MF\QOZ$A3L&^?T[SP&X%."CUP$E/8H7Z:VJ%6F6>M/`M:DR@IYTWJB.:@'"+[
MO:>+8(QG)LO]!CAL.5+<38W?Z)^<7I\?]!%JM_%R<[C=1F];QTPG89;.3&<6
M.,&L+)S@_FD.120!<$%5A'NN1,<8'*Y<1R@',*$MHEK$Q<!])GPN]PGXA.`:
ME\X*#[P/N$G0(7[;[1^A`)_,IVE6X#*)]?2F3$*33>ZB9'2S2!KJ0N_NV47Q
M,)KCKU>?+K'.L<9Q&I83XZ`OV);$46\%,6IN>2!$-$$?7RELF+<L[4.3.<'C
MTA3S*D*!0#48&,JE!C<(J!I(M8;@>@I%7&!,,&[182Z@E33&:6S^C*P"USXH
M4Y6P:5A-JO#4+SZAYI-Z/KC_G\^NR48&KY;RERTTN%TVD9T7)9;6YZ;]WFG1
M.I)K`J]QY+(6.+>B$`J$0-VM(]^ICFQS,^H!MRFX;?"%Y3R:]+KI;+TII&^G
M<><^FB["'5VN9_"852=7UG2`VERU/H'3IW[#^'OSFX=6O<#-[$=]6>)[C]'^
M"]V<@:0"`SKYUKOH7]U<?N\>7ISOOKB_O0\(;6\N#P2P-8-XF0#RKP@X*"V^
M\<(EPD5W+Z041B.3/J]%13Q0%*S3@6!*;AQA0RKF*7>C""MRS]ZA8HI*NGD$
M@XK8:C>+D$0((*22'(1GI50W:W?KP#?5WO*O)1B;X#8OXS9GW/6&,D0_`:)=
&.&AW"0``
`
end
