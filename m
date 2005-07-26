Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261995AbVGZSED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261995AbVGZSED (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 14:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbVGZSC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 14:02:29 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:44935 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261989AbVGZSAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 14:00:30 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 15/23] 68328serial: sysrq should use emergency_reboot
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
	<m1iryxeb4t.fsf@ebiederm.dsl.xmission.com>
	<m1ek9leb0h.fsf_-_@ebiederm.dsl.xmission.com>
	<m1ack9eaux.fsf_-_@ebiederm.dsl.xmission.com>
	<m164uxear0.fsf_-_@ebiederm.dsl.xmission.com>
	<m11x5leaml.fsf_-_@ebiederm.dsl.xmission.com>
	<m1wtndcvwe.fsf_-_@ebiederm.dsl.xmission.com>
	<m1sly1cvnd.fsf_-_@ebiederm.dsl.xmission.com>
	<m1oe8pcvii.fsf_-_@ebiederm.dsl.xmission.com>
	<m1k6jdcvgk.fsf_-_@ebiederm.dsl.xmission.com>
	<m1fyu1cvd7.fsf_-_@ebiederm.dsl.xmission.com>
	<m1br4pcva4.fsf_-_@ebiederm.dsl.xmission.com>
	<m17jfdcv79.fsf_-_@ebiederm.dsl.xmission.com>
	<m13bq1cv3k.fsf_-_@ebiederm.dsl.xmission.com>
	<m1y87tbgeo.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 26 Jul 2005 11:59:54 -0600
In-Reply-To: <m1y87tbgeo.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Tue, 26 Jul 2005 11:55:59 -0600")
Message-ID: <m1u0ihbg85.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The 68328serial.c driver has a weird local reimplementation of
magic sysrq.  The code is architecture specific enough that calling
machine_restart() is probably ok.  But there is no reason not to call
emergency_restart() so do so.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

 drivers/serial/68328serial.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

eaa1c799cd187691a28251a4e2db288cde518b13
diff --git a/drivers/serial/68328serial.c b/drivers/serial/68328serial.c
--- a/drivers/serial/68328serial.c
+++ b/drivers/serial/68328serial.c
@@ -316,7 +316,7 @@ static _INLINE_ void receive_chars(struc
 /*				show_net_buffers(); */
 				return;
 			} else if (ch == 0x12) { /* ^R */
-				machine_restart(NULL);
+				emergency_restart();
 				return;
 #endif /* CONFIG_MAGIC_SYSRQ */
 			}
