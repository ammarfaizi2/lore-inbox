Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265073AbUFRJrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265073AbUFRJrp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 05:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265082AbUFRJrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 05:47:45 -0400
Received: from disk.smurf.noris.de ([192.109.102.53]:59117 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S265073AbUFRJp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 05:45:58 -0400
From: "Matthias Urlichs" <smurf@smurf.noris.de>
Date: Fri, 18 Jun 2004 11:43:00 +0200
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [PATCH] kbuild: Allow HOSTLOADLIBES_foo for single-object foo
Message-ID: <20040618094300.GA29540@kiste>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
X-Smurf-Spam-Score: -2.6 (--)
X-Smurf-Spam-Report: Spam detection software, running on the system "server.smurf.noris.de", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Self-explanatory (I hope ;-) and tested. NB: Thanks to
	whoever convinced off-source-tree and separate-binary Make runs just
	work. Magic. You can import this changeset into BK by piping this whole
	message to: '| bk receive [path to repository]' or apply the patch as
	usual. [...] 
	Content analysis details:   (-2.6 points, 10.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	2.7 OBSCURED_EMAIL         BODY: Message seems to contain rot13ed address
	-4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.0 UPPERCASE_25_50        message body is 25-50% uppercase
	-0.4 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Self-explanatory (I hope ;-) and tested.

NB: Thanks to whoever convinced off-source-tree and separate-binary Make
    runs just work. Magic.


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.1785, 2004-06-18 11:13:27+02:00, smurf@smurf.noris.de
  The HOSTLOADLIBES_target variable did not work for single-object host binaries.
  
  Signed-Off-By: Matthias Urlichs <smurf@smurf.noris.de>


 Makefile.build |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)


diff -Nru a/scripts/Makefile.build b/scripts/Makefile.build
--- a/scripts/Makefile.build	2004-06-18 11:38:49 +02:00
+++ b/scripts/Makefile.build	2004-06-18 11:38:49 +02:00
@@ -305,7 +305,8 @@
 # Create executable from a single .c file
 # host-csingle -> Executable
 quiet_cmd_host-csingle 	= HOSTCC  $@
-      cmd_host-csingle	= $(HOSTCC) $(hostc_flags) $(HOST_LOADLIBES) -o $@ $<
+      cmd_host-csingle	= $(HOSTCC) $(hostc_flags) -o $@ $< \
+			  $(HOST_LOADLIBES) $(HOSTLOADLIBES_$(@F))
 $(host-csingle): %: %.c FORCE
 	$(call if_changed_dep,host-csingle)
 

===================================================================


This BitKeeper patch contains the following changesets:
1.1785
## Wrapped with gzip_uu ##


makepatch: ChangeSet 
makepatch: scripts/Makefile.build 
makepatch: patch contains 2 revisions from 2 files
M'XL( "FXTD   [64;4_;,!#'7]>?XB3Z@@HEL1,G32.*"H4--% 1A5?;5#FV
MVV1-X\IV04CY\'/+0X7HD#8-QU*<\_ER=_]?L@=W1NJL918K/45[<*Z,?7[R
M:Z5+XPOIS#=*.7,@F)5U8#0/YE+7L@I"/_&[R#E<,\L+N)?:9"WB1Z\6^[B4
M6>OF[.O=Y?$-0OT^# M6S^186NCWD57ZGE7"#)@M*E7[5K/:+*1E/E>+YM6U
M"3$.W163;H3CI"$)IMV&$T$(HT0*'-(TH=MHRR7O=;&OC*A\I6=O U&<N/,N
ME M!HAX.T2D0GW33&# -<!*0% C)2)2%W0,<9AC#IA^#MUV! P(>1B?P?VL8
M(@ZWA83ST?CV<G1\>GEQ<C:>6*9GKF/W3)<LKR2(4D"M+#PH/8>ITF#*>E9)
M3^6_)+=0.!4A+VOG+HWO(KHY+F>U%-YH.O5.'C.X8M86)3-PIZN2%P8.=Q5Y
MA+X!B>*XAZZWPB'O+P="F&%T!'-6#NR2^'I5:&]5EUZN>+%:N/<TANMR:4UP
MQ>9R6E;2SU=E)38](ZXS3K40DX9@2J)&3'M)+*(DS-,DC]AN>3Z(N 8@Q3T2
MA;BA48R3#9>[_=>0?E+:B,V7B\$+H]]?,/KY8>8124A,:-QK*$EIO$&7TG?@
MX@_!#<$CGP+N<56IA]WHOH?T:<,XPIY$&(&G'S;3$7/]!SW^@;W3"+N^H(OU
M+42P&7PA)NN/Q.-/.;7ZT-Y?YST<=MQJO<4GTXK-3 <\!>T!M _A!VJU6O#L
G.'FML/-LV9;<WA]\Z72VOT5>2#XWJT6_2P5-(\G1;S-X615W!0  
 
-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
