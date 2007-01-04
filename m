Return-Path: <linux-kernel-owner+w=401wt.eu-S965033AbXADRPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965033AbXADRPb (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 12:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965039AbXADRPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 12:15:30 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:36929 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965033AbXADRPa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 12:15:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:reply-to:to:subject:date:user-agent:references:in-reply-to:cc:disposition-notification-to:mime-version:content-type:message-id;
        b=g70i9NK70B9sgU145xwPGK5P/+Yd3sSbveIcZquYQROXw2i5SKKmQAqZqYbSGGaK+FtGXBT5vcarQsCsUe/xGBxmwhbmfUW8J/ehmg8nJIFAJhciHjCmDnw0vGvbh9RwdefLo1KXVz1kzVVorHB/LL2TVffvB92XSck8UN98OjY=
From: "Cyrill V. Gorcunov" <gorcunov@gmail.com>
Reply-To: gorcunov@gmail.com
To: bjdouma@xs4all.nl
Subject: Re: qconf: reproducible segfault
Date: Thu, 4 Jan 2007 20:14:11 +0300
User-Agent: KMail/1.9.5
References: <459C1966.7040209@xs4all.nl>
In-Reply-To: <459C1966.7040209@xs4all.nl>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Randy Dunlap <randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_kXTnF27jy+nILiq"
Message-Id: <200701042014.12473.gorcunov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_kXTnF27jy+nILiq
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Please try patch I've enveloped. And write me does it fix your problem?

-- 
	- Cyrill

--Boundary-00=_kXTnF27jy+nILiq
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="patch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patch.diff"

diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index 0b2fcc4..0694d1d 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -925,6 +925,8 @@ ConfigInfoView::ConfigInfoView(QWidget* parent, const char *name)
 		configSettings->endGroup();
 		connect(configApp, SIGNAL(aboutToQuit()), SLOT(saveSettings()));
 	}
+
+	has_dbg_info = 0;
 }
 
 void ConfigInfoView::saveSettings(void)
@@ -953,10 +955,13 @@ void ConfigInfoView::setInfo(struct menu *m)
 	if (menu == m)
 		return;
 	menu = m;
-	if (!menu)
+	if (!menu) {
+		has_dbg_info = 0;
 		clear();
-	else
+	} else {
+		has_dbg_info = 1;
 		menuInfo();
+	}
 }
 
 void ConfigInfoView::setSource(const QString& name)
@@ -991,6 +996,9 @@ void ConfigInfoView::symbolInfo(void)
 {
 	QString str;
 
+	if (!has_dbg_info)
+		return;
+
 	str += "<big>Symbol: <b>";
 	str += print_filter(sym->name);
 	str += "</b></big><br><br>value: ";
diff --git a/scripts/kconfig/qconf.h b/scripts/kconfig/qconf.h
index 6fc1c5f..a397edb 100644
--- a/scripts/kconfig/qconf.h
+++ b/scripts/kconfig/qconf.h
@@ -273,6 +273,8 @@ protected:
 	struct symbol *sym;
 	struct menu *menu;
 	bool _showDebug;
+
+	int has_dbg_info;
 };
 
 class ConfigSearchWindow : public QDialog {

--Boundary-00=_kXTnF27jy+nILiq--
