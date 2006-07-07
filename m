Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbWGGRfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWGGRfA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 13:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWGGRfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 13:35:00 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:17312 "EHLO
	palinux.external.hp.com") by vger.kernel.org with ESMTP
	id S932188AbWGGRfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 13:35:00 -0400
Date: Fri, 7 Jul 2006 11:34:58 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: wookey@debian.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Support DOS line endings
Message-ID: <20060707173458.GB1605@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kconfig doesn't currently handle config files with DOS line endings.
While these are, of course, an abomination, etc, etc, it can be handy
to not have to convert them first.  It's also a tiny patch and even adds
support for lines ending in just \r or even \n\r.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>

Index: ./scripts/kconfig/confdata.c
===================================================================
RCS file: /var/cvs/linux-2.6/scripts/kconfig/confdata.c,v
retrieving revision 1.11
diff -u -p -r1.11 confdata.c
--- ./scripts/kconfig/confdata.c	19 Apr 2006 04:56:29 -0000	1.11
+++ ./scripts/kconfig/confdata.c	7 Jul 2006 17:29:16 -0000
@@ -177,6 +177,9 @@ int conf_read_simple(const char *name)
 			p2 = strchr(p, '\n');
 			if (p2)
 				*p2 = 0;
+			p2 = strchr(p, '\r');
+			if (p2)
+				*p2 = 0;
 			sym = sym_find(line + 7);
 			if (!sym) {
 				conf_warning("trying to assign nonexistent symbol %s", line + 7);
@@ -234,6 +237,7 @@ int conf_read_simple(const char *name)
 			}
 			break;
 		case '\n':
+		case '\r':
 			break;
 		default:
 			conf_warning("unexpected data");
