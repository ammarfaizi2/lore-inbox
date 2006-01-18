Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932583AbWARWxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583AbWARWxG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 17:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932585AbWARWxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 17:53:06 -0500
Received: from baikonur.stro.at ([213.239.196.228]:21929 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S932583AbWARWxF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 17:53:05 -0500
Date: Wed, 18 Jan 2006 23:52:48 +0100
From: maximilian attems <maks@sternwelten.at>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Bastian Blank <waldi@debian.org>
Subject: Re: [patch] kbuild: add automatic updateconfig target
Message-ID: <20060118225248.GB6217@nancy>
References: <20060118194056.GA26532@nancy> <20060118204234.GC14340@mars.ravnborg.org> <20060118204750.GD14340@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060118204750.GD14340@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


add an automated target for linux-2.6 daily builds,
sets the new options to their default without manual intervention.

based on a patch by Bastian Blank <waldi@debian.org>

Signed-off-by: maximilian attems <maks@sternwelten.at>

--
thanks for your suggestions Sam,
the patch is much shorter than previous.

i'm not yet shure why one would introduce an update.config file?
please explain :)

diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index 5760e05..487e75f 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -23,6 +23,9 @@ oldconfig: $(obj)/conf
 silentoldconfig: $(obj)/conf
 	$< -s arch/$(ARCH)/Kconfig
 
+updateconfig: $(obj)/conf
+	$< -u arch/$(ARCH)/Kconfig
+
 update-po-config: $(obj)/kxgettext
 	xgettext --default-domain=linux \
           --add-comments --keyword=_ --keyword=N_ \
@@ -74,6 +77,7 @@ help:
 	@echo  '  xconfig	  - Update current config utilising a QT based front-end'
 	@echo  '  gconfig	  - Update current config utilising a GTK based front-end'
 	@echo  '  oldconfig	  - Update current config utilising a provided .config as base'
+	@echo  '  updateconfig	  - Update current config in an automated way'
 	@echo  '  randconfig	  - New config with random answer to all options'
 	@echo  '  defconfig	  - New config with default answer to all options'
 	@echo  '  allmodconfig	  - New config selecting modules when possible'
diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
index 10eeae5..88c2738 100644
--- a/scripts/kconfig/conf.c
+++ b/scripts/kconfig/conf.c
@@ -544,6 +544,9 @@ int main(int ac, char **av)
 			input_mode = set_random;
 			srandom(time(NULL));
 			break;
+		case 'u':
+			input_mode = set_default;
+			break;
 		case 'h':
 		case '?':
 			printf("%s [-o|-s] config\n", av[0]);
