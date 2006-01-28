Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422803AbWA1CWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422803AbWA1CWN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 21:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422801AbWA1CWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 21:22:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:20154 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422798AbWA1CWL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 21:22:11 -0500
Date: Fri, 27 Jan 2006 18:21:02 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       76306.1226@compuserve.com, nickpiggin@yahoo.com.au, axboe@suse.de
Subject: [patch 06/12] elevator=as back-compatibility
Message-ID: <20060128022102.GG17001@kroah.com>
References: <20060128020629.908825000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="elevator-as-back-compatibility.patch"
In-Reply-To: <20060128022023.GA17001@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.15.2 -stable review patch.  If anyone has any objections, please let 
us know.

------------------

From: Chuck Ebbert <76306.1226@compuserve.com>

As of 2.6.15 you need to use "anticipatory" instead of "as".  Fix that up
so that `elevator=as' still works.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Jens Axboe <axboe@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 block/elevator.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- linux-2.6.15.1.orig/block/elevator.c
+++ linux-2.6.15.1/block/elevator.c
@@ -150,6 +150,13 @@ static void elevator_setup_default(void)
 	if (!chosen_elevator[0])
 		strcpy(chosen_elevator, CONFIG_DEFAULT_IOSCHED);
 
+	/*
+	 * Be backwards-compatible with previous kernels, so users
+	 * won't get the wrong elevator.
+	 */
+	if (!strcmp(chosen_elevator, "as"))
+		strcpy(chosen_elevator, "anticipatory");
+
  	/*
  	 * If the given scheduler is not available, fall back to no-op.
  	 */

--
