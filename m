Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964848AbWJJRTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbWJJRTk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 13:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWJJRTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 13:19:33 -0400
Received: from mail.kroah.org ([69.55.234.183]:2186 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964825AbWJJRQC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 13:16:02 -0400
Date: Tue, 10 Oct 2006 10:15:27 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, bunk@stusta.de,
       Kim Nordlund <kim.nordlund@nokia.com>, Thomas Graf <tgraf@suug.ch>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 14/19] PKT_SCHED: cls_basic: Use unsigned int when generating handle
Message-ID: <20061010171527.GO6339@kroah.com>
References: <20061010165621.394703368@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="pkt_sched-cls_basic-use-unsigned-int-when-generating-handle.patch"
In-Reply-To: <20061010171350.GA6339@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: David Miller <davem@davemloft.net>

Prevents filters from being added if the first generated
handle already exists.

Signed-off-by: Kim Nordlund <kim.nordlund@nokia.com>
Signed-off-by: Thomas Graf <tgraf@suug.ch>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 net/sched/cls_basic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.17.13.orig/net/sched/cls_basic.c
+++ linux-2.6.17.13/net/sched/cls_basic.c
@@ -197,7 +197,7 @@ static int basic_change(struct tcf_proto
 	if (handle)
 		f->handle = handle;
 	else {
-		int i = 0x80000000;
+		unsigned int i = 0x80000000;
 		do {
 			if (++head->hgenerator == 0x7FFFFFFF)
 				head->hgenerator = 1;

--
