Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265247AbSL0Wyp>; Fri, 27 Dec 2002 17:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265246AbSL0Wyp>; Fri, 27 Dec 2002 17:54:45 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:12819 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S265243AbSL0Wyj>;
	Fri, 27 Dec 2002 17:54:39 -0500
Date: Sat, 28 Dec 2002 00:02:55 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>, sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: kbuild/sparc64: archhelp update
Message-ID: <20021227230255.GB24310@mars.ravnborg.org>
Mail-Followup-To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moved archhelp to arch/sparc64/Makefile
Introduced usage of $(build)
Removed superflous targets archclean and archmrproper
Dependent on other kbuild changes already posted

Please apply,
	Sam


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.961, 2002-12-27 23:40:13+01:00, sam@mars.ravnborg.org
  kbuild/sparc64: archhelp and $(build)
  
  Moved archhelp to arch/sparc64/Makefile
  introduced usage of $(build)
  Removed superflous targets archclean and archmrproper


 Makefile      |   12 ++++++------
 boot/Makefile |    4 ----
 2 files changed, 6 insertions(+), 10 deletions(-)


diff -Nru a/arch/sparc64/Makefile b/arch/sparc64/Makefile
--- a/arch/sparc64/Makefile	Fri Dec 27 23:56:06 2002
+++ b/arch/sparc64/Makefile	Fri Dec 27 23:56:06 2002
@@ -71,11 +71,11 @@
 # FIXME: is drivers- right?
 drivers-$(CONFIG_OPROFILE)	+= arch/sparc64/oprofile/
 
-makeboot =$(Q)$(MAKE) -f scripts/Makefile.build obj=arch/sparc64/boot $(1)
-
 tftpboot.img vmlinux.aout:
-	$(call makeboot,arch/sparc64/boot/$@)
-
-archmrproper:
-archclean:
+	$(Q)$(MAKE) $(build)=arch/sparc64/boot arch/sparc64/boot/$@
 
+define archhelp
+  echo  '* vmlinux       - Standard sparc64 kernel'
+  echo  '  vmlinux.aout  - a.out kernel for sparc64'
+  echo  '  tftpboot.img  - Image prepared for tftp'
+endef
diff -Nru a/arch/sparc64/boot/Makefile b/arch/sparc64/boot/Makefile
--- a/arch/sparc64/boot/Makefile	Fri Dec 27 23:56:06 2002
+++ b/arch/sparc64/boot/Makefile	Fri Dec 27 23:56:06 2002
@@ -24,7 +24,3 @@
 	$(call if_changed,elftoaout)
 	@echo '  kernel: $@ is ready'
 
-archhelp:
-	@echo  '* vmlinux       - Standard sparc64 kernel'
-	@echo  '  vmlinux.aout  - a.out kernel for sparc64'
-	@echo  '  tftpboot.img  - Image prepared for tftp'

===================================================================


This BitKeeper patch contains the following changesets:
1.961
## Wrapped with gzip_uu ##


begin 664 bkpatch24269
M'XL(`(;:##X``[V6;6_:,!#'7^-/<5*1VJXBL1V3!"2F=EVU55VUCJH?P"2&
M(!(;V0[;I'SX.6&%4N@#W4,(),'_.^[.][,Y@#LC=+]E>($.X+,RMM\JN#:>
MY@LY4GKBN;<;&2KE1OQ,%<)W6M_HQ,^GLOSASX26(O=',W\V*J=YBISZAMLD
M@X70IM\B7K#ZQOZ<BWYK>/'I[LO9$*'!`,XS+B?B5E@8#)!5>L'SU)QRF^5*
M>E9S:0IAN9>HHEI)*XHQ=:\NB0+<#2L28A95"4D)X8R(%%,6APRY,$^W4GGD
MA5`:41K0+JDP<X_H(Q"O%Q+`U"?4IQ'0H,]PGP0GF/0QAIU.X81"!Z,/\'<3
M.$<)+&OJFSG72<CZX"Y9)O(Y<)E"^Z@9/78Z=UZKA4C7`JN:^WM3_YK/Q'B:
M"Z><2JM56B9.7AH^$:#&#WT-1=&X,N5<Z'&N2@.6ZXFPIO&8Y(++YO?KIT+/
MM7(Z=`4L9!3=K*<4=?8\$,(<H_<OE'$CJY'KRU5J#^KJ)K-7A;@;DVJ,HQ$7
M)$IQPNFHSFMG8[S@=MDI#..X"BF->_N%N3O"N*(QZ\75..($AV0D!`Y('/'7
M1/A4<#B,@UZ#UD[YRYC]0=PHY0M1G,K2&D].Y8Q[TC7[<V%CU_DD9*P*6<R6
M]%'\&#X</P]?")WPG\"W393-I@;J^#TW?/DZC$HI1>JN]PR-E88U0P_X:6;N
M*W3T]^9T/-P\@?#^8'V,&%#W&0%#ES$&@EKMHV_'[:/KLZN+XU78@RT*8)N+
M]JES0:"+4A>-%*L"(0"19`K@\!TLBF9W@.71@5OKDN7:P;?T!,MMXW!M`_<V
M'E>EK6VX5]\LA4W5?MMN&-FQG==1>=-B4AM=%O5,S+5P6E?TVJR6'"(A7;C;
M8&R0OB<=;UA\FEUIKW7'08*[C-"@(I@&0<,(VQ<1#!WVGQ#9W;&NNYM5\[GV
BWDC^+3U.Z^Y>_=E(,I',3%D,(I9V>Q&/T"]'9YL,[0@`````
`
end
