Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbVELIyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVELIyx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 04:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVELIyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 04:54:44 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:50464
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S261363AbVELIvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 04:51:25 -0400
Message-Id: <s283271a.003@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 6.5.4 
Date: Thu, 12 May 2005 10:51:50 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <sam@ravnborg.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] apply quotation handling to Makefile.build
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part86A54A36.1__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part86A54A36.1__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

Adding quotation handling to rule_cc_o_c in scripts/Makefile.build as
used elsewhere.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru linux-2.6.12-rc4.base/scripts/Makefile.build linux-2.6.12-rc4/sc=
ripts/Makefile.build
--- linux-2.6.12-rc4.base/scripts/Makefile.build	2005-03-02 =
08:38:19.000000000 +0100
+++ linux-2.6.12-rc4/scripts/Makefile.build	2005-03-15 14:43:04.0000000=
00 +0100
@@ -176,10 +176,10 @@ endif
 define rule_cc_o_c
 	$(if $($(quiet)cmd_checksrc),echo '  $($(quiet)cmd_checksrc)';)   =
\
 	$(cmd_checksrc)							  =
\
-	$(if $($(quiet)cmd_cc_o_c),echo '  $($(quiet)cmd_cc_o_c)';)	  =
\
+	$(if $($(quiet)cmd_cc_o_c),echo '  $(subst ','\'',$($(quiet)cmd_cc_=
o_c))';)  \
 	$(cmd_cc_o_c);							  =
\
 	$(cmd_modversions)						  =
\
-	scripts/basic/fixdep $(depfile) $@ '$(cmd_cc_o_c)' > $(@D)/.$(@F).t=
mp;  \
+	scripts/basic/fixdep $(depfile) $@ '$(subst ','\'',$(cmd_cc_o_c))' =
> $(@D)/.$(@F).tmp;  \
 	rm -f $(depfile);						  =
\
 	mv -f $(@D)/.$(@F).tmp $(@D)/.$(@F).cmd=20
 endef



--=__Part86A54A36.1__=
Content-Type: text/plain; name="linux-2.6.12-rc4-make-quoting.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="linux-2.6.12-rc4-make-quoting.patch"

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

Adding quotation handling to rule_cc_o_c in scripts/Makefile.build as
used elsewhere.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru linux-2.6.12-rc4.base/scripts/Makefile.build linux-2.6.12-rc4/scripts/Makefile.build
--- linux-2.6.12-rc4.base/scripts/Makefile.build	2005-03-02 08:38:19.000000000 +0100
+++ linux-2.6.12-rc4/scripts/Makefile.build	2005-03-15 14:43:04.000000000 +0100
@@ -176,10 +176,10 @@ endif
 define rule_cc_o_c
 	$(if $($(quiet)cmd_checksrc),echo '  $($(quiet)cmd_checksrc)';)   \
 	$(cmd_checksrc)							  \
-	$(if $($(quiet)cmd_cc_o_c),echo '  $($(quiet)cmd_cc_o_c)';)	  \
+	$(if $($(quiet)cmd_cc_o_c),echo '  $(subst ','\'',$($(quiet)cmd_cc_o_c))';)  \
 	$(cmd_cc_o_c);							  \
 	$(cmd_modversions)						  \
-	scripts/basic/fixdep $(depfile) $@ '$(cmd_cc_o_c)' > $(@D)/.$(@F).tmp;  \
+	scripts/basic/fixdep $(depfile) $@ '$(subst ','\'',$(cmd_cc_o_c))' > $(@D)/.$(@F).tmp;  \
 	rm -f $(depfile);						  \
 	mv -f $(@D)/.$(@F).tmp $(@D)/.$(@F).cmd
 endef

--=__Part86A54A36.1__=--
