Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbUCDUmU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 15:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbUCDUmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 15:42:19 -0500
Received: from mail5.speakeasy.net ([216.254.0.205]:39894 "EHLO
	mail5.speakeasy.net") by vger.kernel.org with ESMTP id S262134AbUCDUmS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 15:42:18 -0500
Date: Thu, 4 Mar 2004 14:42:16 -0600 (CST)
From: quadong@users.sourceforge.net
X-X-Sender: straitm@dsl093-017-216.msp1.dsl.speakeasy.net
To: netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ipt_helper.c
Message-ID: <Pine.LNX.4.60.0403041439110.10634@dsl093-017-216.msp1.dsl.speakeasy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, if you tell iptables to match "-m helper ! --helper ftp" it
will match any packet from any helper other than FTP.  What it should do
is match any packet that is not from an FTP helper, included packets that
are not from any helper (packets from master connections).  Here's the
fix:

--- ipt_helper.c.old    2004-03-03 21:34:05.000000000 -0600
+++ ipt_helper.c        2004-03-04 14:34:17.709903456 -0600
@@ -48,7 +48,7 @@

        if (!ct->master) {
                DEBUGP("ipt_helper: conntrack %p has no master\n", ct);
-               return 0;
+               return info->invert;
        }

        exp = ct->master;

