Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932772AbWAHU7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932772AbWAHU7I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 15:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932773AbWAHU7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 15:59:08 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:27346 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932772AbWAHU7H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 15:59:07 -0500
Date: Sun, 8 Jan 2006 21:59:07 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
To: Ben Collins <ben.collins@ubuntu.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/15] kconf: Check for eof from input stream.
In-Reply-To: <1136746381.1043.10.camel@grayson>
Message-ID: <Pine.LNX.4.61.0601082158310.8860@spit.home>
References: <0ISL003ZI97GCY@a34-mta01.direcway.com> <200601081734.30349.zippel@linux-m68k.org>
 <1136746381.1043.10.camel@grayson>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 8 Jan 2006, Ben Collins wrote:

> Anyway, the problem is that if there is no terminal (e.g. stdout is
> redirected to a file, and stdin is closed), then kconf loops forever
> trying to get an answer (NULL is not the same as "").

Then let's fix the real problem.

bye, Roman

     scripts/kconfig/conf.c |    3 +--
     1 file changed, 1 insertion(+), 2 deletions(-)

Index: linux-2.6.14/scripts/kconfig/conf.c
===================================================================
--- linux-2.6.14.orig/scripts/kconfig/conf.c	2006-01-08 21:52:54.000000000 +0100
+++ linux-2.6.14/scripts/kconfig/conf.c	2006-01-08 21:54:02.000000000 +0100
@@ -314,8 +314,7 @@ static int conf_choice(struct menu *menu
     		printf("%*s%s\n", indent - 1, "", menu_get_prompt(menu));
     		def_sym = sym_get_choice_value(sym);
     		cnt = def = 0;
-		line[0] = '0';
-		line[1] = 0;
+		line[0] = 0;
     		for (child = menu->list; child; child = child->next) {
     			if (!menu_is_visible(child))
     				continue;
