Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946250AbWKAAlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946250AbWKAAlH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 19:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946259AbWKAAlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 19:41:07 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:15513 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1946250AbWKAAlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 19:41:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=D/8WGyzi+RW9WOV1Zl2zAqIi3xDQcwC2EScC1ejMtcKGRvPca6ebeSHTcfXjNbpIn663gqsE1cdMHlO7MsSQLIgtx3TFKbI1TdAOPQ9SSgQya6x9JXd42d0l1ttatmVzxzdQwbNpEs+6XGrjY+p6ZtppqjzX1Xd63nqmW+wpGzg=
Date: Wed, 1 Nov 2006 01:40:57 +0000
From: Miguel Ojeda Sandonis <maxextreme@gmail.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH update6] drivers: add LCD support
Message-Id: <20061101014057.454c4f43.maxextreme@gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, here it is the coding style fixes. Thanks you.

I think the driver is getting ready for freeze until
2.6.20-rc1 (if anyone sees something wrong), so I will
try to send just minor fixes like this.

After that, in the future, I will work on the Paulo Marques'
idea to reduce CPU waste even more if possible.
---

 - Minor coding style fixes

 Documentation/auxdisplay/cfag12864b-example.c |    4 ++--
 drivers/auxdisplay/cfag12864b.c               |    4 ++--
 drivers/auxdisplay/cfag12864bfb.c             |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

miguelojeda-drivers-add-LCD-support-6-minor-coding-style-fixes
Signed-off-by: Miguel Ojeda Sandonis <maxextreme@gmail.com>
---
diff -uprN -X dontdiff linux-2.6.19-rc1-mod3/Documentation/auxdisplay/cfag12864b-example.c linux/Documentation/auxdisplay/cfag12864b-example.c
--- linux-2.6.19-rc1-mod3/Documentation/auxdisplay/cfag12864b-example.c	2006-11-01 00:39:39.000000000 +0000
+++ linux/Documentation/auxdisplay/cfag12864b-example.c	2006-11-01 01:27:55.000000000 +0000
@@ -203,7 +203,7 @@ void example(unsigned char n)
 	unsigned short i, j;
 	unsigned char matrix[CFAG12864B_WIDTH * CFAG12864B_HEIGHT];
 
-	if(n > EXAMPLES)
+	if (n > EXAMPLES)
 		return;
 
 	printf("Example %i/%i - ", n, EXAMPLES);
@@ -273,7 +273,7 @@ int main(int argc, char *argv[])
 	for (n = 1; n <= EXAMPLES; n++) {
 		example(n);
 		cfag12864b_blit();
-		while(getchar() != '\n');
+		while (getchar() != '\n');
 	}
 
 	cfag12864b_exit();
diff -uprN -X dontdiff linux-2.6.19-rc1-mod3/drivers/auxdisplay/cfag12864b.c linux/drivers/auxdisplay/cfag12864b.c
--- linux-2.6.19-rc1-mod3/drivers/auxdisplay/cfag12864b.c	2006-11-01 00:40:59.000000000 +0000
+++ linux/drivers/auxdisplay/cfag12864b.c	2006-11-01 01:25:12.000000000 +0000
@@ -237,7 +237,7 @@ unsigned char cfag12864b_enable(void)
 
 	mutex_lock(&cfag12864b_mutex);
 
-	if(!cfag12864b_updating) {
+	if (!cfag12864b_updating) {
 		cfag12864b_updating = 1;
 		cfag12864b_queue();
 		ret = 0;
@@ -254,7 +254,7 @@ void cfag12864b_disable(void)
 {
 	mutex_lock(&cfag12864b_mutex);
 
-	if(cfag12864b_updating) {
+	if (cfag12864b_updating) {
 		cfag12864b_updating = 0;
 		cancel_delayed_work(&cfag12864b_work);
 		flush_workqueue(cfag12864b_workqueue);
diff -uprN -X dontdiff linux-2.6.19-rc1-mod3/drivers/auxdisplay/cfag12864bfb.c linux/drivers/auxdisplay/cfag12864bfb.c
--- linux-2.6.19-rc1-mod3/drivers/auxdisplay/cfag12864bfb.c	2006-11-01 00:40:59.000000000 +0000
+++ linux/drivers/auxdisplay/cfag12864bfb.c	2006-11-01 01:26:10.000000000 +0000
@@ -71,7 +71,7 @@ static struct page *cfag12864bfb_vma_nop
 	struct page *page = virt_to_page(cfag12864b_buffer);
 	get_page(page);
 
-	if(type)
+	if (type)
 		*type = VM_FAULT_MINOR;
 
 	return page;
@@ -156,7 +156,7 @@ static int __init cfag12864bfb_init(void
 {
 	int ret;
 
-	if(cfag12864b_enable()) {
+	if (cfag12864b_enable()) {
 		printk(KERN_ERR CFAG12864BFB_NAME ": ERROR: "
 			"can't enable cfag12864b refreshing (being used)\n");
 		return -ENODEV;
