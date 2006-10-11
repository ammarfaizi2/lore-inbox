Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161439AbWJKVKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161439AbWJKVKh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161452AbWJKVKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:10:19 -0400
Received: from mail.kroah.org ([69.55.234.183]:20131 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161443AbWJKVJF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:09:05 -0400
Date: Wed, 11 Oct 2006 14:08:20 -0700
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
Subject: [patch 54/67] PKT_SCHED: cls_basic: Use unsigned int when generating handle
Message-ID: <20061011210820.GC16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="pkt_sched-cls_basic-use-unsigned-int-when-generating-handle.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: David Miller <davem@davemloft.net>

gcc-4.1 and later take advantage of the fact that in the
C language certain types of overflow/underflow are undefined,
and this is completely legitimate.

Prevents filters from being added if the first generated
handle already exists.

Signed-off-by: Kim Nordlund <kim.nordlund@nokia.com>
Signed-off-by: Thomas Graf <tgraf@suug.ch>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 net/sched/cls_basic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.18.orig/net/sched/cls_basic.c
+++ linux-2.6.18/net/sched/cls_basic.c
@@ -194,7 +194,7 @@ static int basic_change(struct tcf_proto
 	if (handle)
 		f->handle = handle;
 	else {
-		int i = 0x80000000;
+		unsigned int i = 0x80000000;
 		do {
 			if (++head->hgenerator == 0x7FFFFFFF)
 				head->hgenerator = 1;

--
