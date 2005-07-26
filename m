Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262004AbVGZR7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbVGZR7t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 13:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbVGZR5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 13:57:50 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:41863 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261992AbVGZR4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 13:56:35 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 14/23] In hangcheck-timer.c call emergency_restart()
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
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 26 Jul 2005 11:55:59 -0600
In-Reply-To: <m13bq1cv3k.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Tue, 26 Jul 2005 11:53:19 -0600")
Message-ID: <m1y87tbgeo.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If we've hung a clean reboot does not sound like a real
option.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

 drivers/char/hangcheck-timer.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

8d6217cc6e8fa4832c84fb918848ba0eb2e0fb0e
diff --git a/drivers/char/hangcheck-timer.c b/drivers/char/hangcheck-timer.c
--- a/drivers/char/hangcheck-timer.c
+++ b/drivers/char/hangcheck-timer.c
@@ -173,7 +173,7 @@ static void hangcheck_fire(unsigned long
 		}
 		if (hangcheck_reboot) {
 			printk(KERN_CRIT "Hangcheck: hangcheck is restarting the machine.\n");
-			machine_restart(NULL);
+			emergency_restart();
 		} else {
 			printk(KERN_CRIT "Hangcheck: hangcheck value past margin!\n");
 		}
