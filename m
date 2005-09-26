Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbVIZDiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbVIZDiK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 23:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbVIZDiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 23:38:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9188 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932364AbVIZDiI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 23:38:08 -0400
Date: Sun, 25 Sep 2005 23:38:05 -0400
From: Dave Jones <davej@redhat.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb-snd-audio breakage
Message-ID: <20050926033805.GB22376@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jon Smirl <jonsmirl@gmail.com>, linux-kernel@vger.kernel.org
References: <9e4733910509251927484a70c7@mail.gmail.com> <9e4733910509251943277f077a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910509251943277f077a@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 25, 2005 at 10:43:11PM -0400, Jon Smirl wrote:
 > The Redhat FC4 installer is adds index=0 in modprobe.conf. The index
 > parameter appears to have been removed fron snd-usb-audio.
 > 
 > There are two issues:
 > 1) should index have been left as a non-functioning param so that
 > existing installs won't break.
 > 2) Why didn't I get a decent error message about index being the
 > problem instead of the message about `'

This patch really should have been merged for 2.6.13
but somehow fell through the cracks. I don't think it
even landed in -mm

		Dave



Name: Ignore trailing whitespace on kernel parameters correctly: Fixed version
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Dave Jones says:

... if the modprobe.conf has trailing whitespace, modules fail to load
with the following helpful message..

	snd_intel8x0: Unknown parameter `'

Previous version truncated last argument.

Index: linux-2.6.13-rc6-git7-Module/kernel/params.c
===================================================================
--- linux-2.6.13-rc6-git7-Module.orig/kernel/params.c	2005-08-10 16:12:45.000000000 +1000
+++ linux-2.6.13-rc6-git7-Module/kernel/params.c	2005-08-16 14:31:16.000000000 +1000
@@ -80,8 +80,6 @@
 	int in_quote = 0, quoted = 0;
 	char *next;
 
-	/* Chew any extra spaces */
-	while (*args == ' ') args++;
 	if (*args == '"') {
 		args++;
 		in_quote = 1;
@@ -121,6 +119,9 @@
 		next = args + i + 1;
 	} else
 		next = args + i;
+
+	/* Chew up trailing spaces. */
+	while (*next == ' ') next++;
 	return next;
 }
 
@@ -134,6 +135,9 @@
 	char *param, *val;
 
 	DEBUGP("Parsing ARGS: %s\n", args);
+	
+	/* Chew leading spaces */
+	while (*args == ' ') args++;
 
 	while (*args) {
 		int ret;


