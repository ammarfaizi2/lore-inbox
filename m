Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965271AbWIFXFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965271AbWIFXFz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965268AbWIFXFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:05:46 -0400
Received: from mail.kroah.org ([69.55.234.183]:31949 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965124AbWIFXDJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:03:09 -0400
Date: Wed, 6 Sep 2006 15:57:44 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, yingchao.zhou@gmail.com,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 30/37] Remove redundant up() in stop_machine()
Message-ID: <20060906225744.GE15922@kroah.com>
References: <20060906224631.999046890@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="remove-redundant-up-in-stop_machine.patch"
In-Reply-To: <20060906225444.GA15922@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: "Yingchao Zhou" <yingchao.zhou@gmail.com>

An up() is called in kernel/stop_machine.c on failure, and also in the
caller (unconditionally).

Signed-off-by: Zhou Yingchao <yingchao.zhou@gmail.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 kernel/stop_machine.c |    1 -
 1 file changed, 1 deletion(-)

--- linux-2.6.17.11.orig/kernel/stop_machine.c
+++ linux-2.6.17.11/kernel/stop_machine.c
@@ -111,7 +111,6 @@ static int stop_machine(void)
 	/* If some failed, kill them all. */
 	if (ret < 0) {
 		stopmachine_set_state(STOPMACHINE_EXIT);
-		up(&stopmachine_mutex);
 		return ret;
 	}
 

--
