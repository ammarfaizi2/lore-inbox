Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbUKGKjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbUKGKjG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 05:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbUKGKjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 05:39:06 -0500
Received: from coderock.org ([193.77.147.115]:42422 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261162AbUKGKjD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 05:39:03 -0500
Date: Sun, 7 Nov 2004 11:38:25 +0100
From: Domen Puncer <domen@coderock.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] lib/parser: fix %% parsing
Message-ID: <20041107103824.GA3726@masina.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Code looks like it intended to parse "%%" in pattern string as "%".
Fix it, so it really does that.

Compile and run tested.


Signed-off-by: Domen Puncer <domen@coderock.org>

--- c/lib/parser.c	2004-11-07 11:31:05.000000000 +0100
+++ a/lib/parser.c	2004-11-07 11:31:23.000000000 +0100
@@ -47,6 +47,7 @@ static int match_one(char *s, char *p, s
 		else if (*p == '%') {
 			if (*s++ != '%')
 				return 0;
+			p++;
 			continue;
 		}
 
