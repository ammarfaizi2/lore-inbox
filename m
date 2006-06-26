Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933226AbWFZXJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933226AbWFZXJF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933261AbWFZWjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:39:04 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:416 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933244AbWFZWie
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:38:34 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 24/32] [Suspend2] Set extra page forward flag.
Date: Tue, 27 Jun 2006 08:38:32 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223830.4376.62700.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
References: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Set the flag that says the next forward_one_page should actually go forward
to pages. This is used at resume time when we get the first page of the
header from the page pointed to by resume2= (bootstrapping), and then
actually want the second page at the point where we do need to get another
page.

We can't just go forward one page right away because we haven't yet
loaded the extent chain that contains the block data. But loading the
extent chain that contains the block data might need the extra page (if
badly fragmented). Catch 22, hence this flag.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_block_io.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_block_io.c b/kernel/power/suspend_block_io.c
index fdbbe4b..ffc2e16 100644
--- a/kernel/power/suspend_block_io.c
+++ b/kernel/power/suspend_block_io.c
@@ -815,3 +815,9 @@ static int forward_one_page(void)
 
 	return 0;
 }
+
+static void set_extra_page_forward(void)
+{
+	extra_page_forward = 1;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
