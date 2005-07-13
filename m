Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261896AbVGMReN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbVGMReN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 13:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbVGMRch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 13:32:37 -0400
Received: from mta01.mail.t-online.hu ([195.228.240.50]:17859 "EHLO
	mta01.mail.t-online.hu") by vger.kernel.org with ESMTP
	id S261704AbVGMRaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 13:30:39 -0400
Subject: [PATCH 16/19] Kconfig I18n: xconfig: answering
From: Egry =?ISO-8859-1?Q?G=E1bor?= <gaboregry@t-online.hu>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Massimo Maiurana <maiurana@inwind.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       KernelFR <kernelfr@traduc.org>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>
In-Reply-To: <1121273456.2975.3.camel@spirit>
References: <1121273456.2975.3.camel@spirit>
Content-Type: text/plain
Date: Wed, 13 Jul 2005 19:30:01 +0200
Message-Id: <1121275801.2975.45.camel@spirit>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I18N support for answering in xconfig. This patch useful for non-latin based languages.

Signed-off-by: Egry Gabor <gaboregry@t-online.hu>

---

 scripts/kconfig/qconf.cc |   40 +++++++++++++++++++---------------------
 1 files changed, 19 insertions(+), 21 deletions(-)

diff -puN scripts/kconfig/qconf.cc~kconfig-i18n-16-qconfig-key-i18n scripts/kconfig/qconf.cc
--- linux-2.6.13-rc3-i18n-kconfig/scripts/kconfig/qconf.cc~kconfig-i18n-16-qconfig-key-i18n	2005-07-13 18:32:19.000000000 +0200
+++ linux-2.6.13-rc3-i18n-kconfig-gabaman/scripts/kconfig/qconf.cc	2005-07-13 18:36:39.000000000 +0200
@@ -224,7 +224,7 @@ void ConfigItem::updateMenu(void)
 	switch (type) {
 	case S_BOOLEAN:
 	case S_TRISTATE:
-		char ch;
+		const char *ch;
 
 		if (!sym_is_changable(sym) && !list->showAll) {
 			setPixmap(promptColIdx, 0);
@@ -240,21 +240,21 @@ void ConfigItem::updateMenu(void)
 				setPixmap(promptColIdx, list->choiceYesPix);
 			else
 				setPixmap(promptColIdx, list->symbolYesPix);
-			setText(yesColIdx, "Y");
-			ch = 'Y';
+			setText(yesColIdx, _("Y"));
+			ch = _("Y");
 			break;
 		case mod:
 			setPixmap(promptColIdx, list->symbolModPix);
-			setText(modColIdx, "M");
-			ch = 'M';
+			setText(modColIdx, _("M"));
+			ch = _("M");
 			break;
 		default:
 			if (sym_is_choice_value(sym) && type == S_BOOLEAN)
 				setPixmap(promptColIdx, list->choiceNoPix);
 			else
 				setPixmap(promptColIdx, list->symbolNoPix);
-			setText(noColIdx, "N");
-			ch = 'N';
+			setText(noColIdx, _("N"));
+			ch = _("N");
 			break;
 		}
 		if (expr != no)
@@ -264,7 +264,7 @@ void ConfigItem::updateMenu(void)
 		if (expr != yes)
 			setText(yesColIdx, sym_tristate_within_range(sym, yes) ? "_" : 0);
 
-		setText(dataColIdx, QChar(ch));
+		setText(dataColIdx, ch);
 		break;
 	case S_INT:
 	case S_HEX:
@@ -431,9 +431,9 @@ void ConfigList::reinit(void)
 	if (showName)
 		addColumn(nameColIdx, _("Name"));
 	if (showRange) {
-		addColumn(noColIdx, "N");
-		addColumn(modColIdx, "M");
-		addColumn(yesColIdx, "Y");
+		addColumn(noColIdx, _("N"));
+		addColumn(modColIdx, _("M"));
+		addColumn(yesColIdx, _("Y"));
 	}
 	if (showData)
 		addColumn(dataColIdx, _("Value"));
@@ -641,17 +641,15 @@ void ConfigList::keyPressEvent(QKeyEvent
 	case Key_Space:
 		changeValue(item);
 		break;
-	case Key_N:
-		setValue(item, no);
-		break;
-	case Key_M:
-		setValue(item, mod);
-		break;
-	case Key_Y:
-		setValue(item, yes);
-		break;
 	default:
-		Parent::keyPressEvent(ev);
+		if ((ev->text() == _("y")) || (ev->text() == _("Y")))
+			setValue(item, yes);
+		else if ((ev->text() == _("m")) || (ev->text() == _("M")))
+			setValue(item, mod);
+		else if ((ev->text() == _("n")) || (ev->text() == _("N")))
+			setValue(item, no);
+		else
+			Parent::keyPressEvent(ev);
 		return;
 	}
 	ev->accept();
_


