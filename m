Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbVLVGKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbVLVGKz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 01:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbVLVGKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 01:10:55 -0500
Received: from smtp104.sbc.mail.re2.yahoo.com ([68.142.229.101]:61818 "HELO
	smtp104.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932420AbVLVGKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 01:10:54 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: usb: replace __setup("nousb") with __module_param_call
Date: Thu, 22 Dec 2005 01:10:52 -0500
User-Agent: KMail/1.8.3
Cc: greg@kroah.com, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
References: <20051220141504.31441a41.zaitcev@redhat.com>
In-Reply-To: <20051220141504.31441a41.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512220110.52466.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 December 2005 17:15, Pete Zaitcev wrote:
> Fedora users complain that passing "nousbstorage" to the installer causes
> the rest of the USB support to disappear. The installer uses kernel command
> line as a way to pass options through Syslinux. The problem stems from the
> use of strncmp() in obsolete_checksetup().
>

I wonder if that strncmp() should be changed into something like
this (untested):

--- work.orig/init/main.c
+++ work/init/main.c
@@ -167,7 +167,7 @@ static int __init obsolete_checksetup(ch
 	p = __setup_start;
 	do {
 		int n = strlen(p->str);
-		if (!strncmp(line, p->str, n)) {
+		if (!strncmp(line, p->str, n) && !isalnum(line[n])) {
 			if (p->early) {
 				/* Already done in parse_early_param?  (Needs
 				 * exact match on param part) */


-- 
Dmitry
