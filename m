Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422732AbWF0XpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422732AbWF0XpR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 19:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422733AbWF0XpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 19:45:17 -0400
Received: from mail.gmx.net ([213.165.64.21]:14000 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1422736AbWF0XpQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 19:45:16 -0400
X-Authenticated: #704063
Subject: [Patch] Missing statement in drivers/media/dvb/frontends/cx22700.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: holger@convergence.de
Content-Type: text/plain
Date: Wed, 28 Jun 2006 01:45:12 +0200
Message-Id: <1151451913.16996.2.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

stumbled over this because of coverity (id #492),
seems like we are missing a return statement here and fail
to do proper bounds checking. If this assumption is false
we should at least change the identation to make it clear

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.17-git11/drivers/media/dvb/frontends/cx22700.c.orig	2006-06-28 01:40:49.000000000 +0200
+++ linux-2.6.17-git11/drivers/media/dvb/frontends/cx22700.c	2006-06-28 01:41:04.000000000 +0200
@@ -134,6 +134,7 @@ static int cx22700_set_tps (struct cx227
 		return -EINVAL;
 
 	if (p->code_rate_LP < FEC_1_2 || p->code_rate_LP > FEC_7_8)
+		return -EINVAL;
 
 	if (p->code_rate_HP == FEC_4_5 || p->code_rate_LP == FEC_4_5)
 		return -EINVAL;


