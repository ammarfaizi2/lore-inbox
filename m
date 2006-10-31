Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751476AbWJaFfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbWJaFfA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 00:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbWJaFfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 00:35:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7378 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751476AbWJaFe7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 00:34:59 -0500
Date: Mon, 30 Oct 2006 21:34:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Subject: Re: Linux 2.6.19-rc4
Message-Id: <20061030213454.8266fcb6.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2006 20:27:17 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> Jun'ichi Nomura (2):
>       fix bd_claim_by_kobject error handling
>       clean up add_bd_holder()

That didn't go so well.  I guess the below was intended, but I wonder if
we actually merged the correct patch?


From: Andrew Morton <akpm@osdl.org>

fs/block_dev.c: In function 'find_bd_holder':
fs/block_dev.c:666: warning: return makes integer from pointer without a cast
fs/block_dev.c:669: warning: return makes integer from pointer without a cast
fs/block_dev.c: In function 'add_bd_holder':
fs/block_dev.c:685: warning: unused variable 'tmp'
fs/block_dev.c: In function 'bd_claim_by_kobject':
fs/block_dev.c:773: warning: assignment makes pointer from integer without a cast

Cc: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 fs/block_dev.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN fs/block_dev.c~find_bd_holder-fix fs/block_dev.c
--- a/fs/block_dev.c~find_bd_holder-fix
+++ a/fs/block_dev.c
@@ -656,7 +656,8 @@ static void free_bd_holder(struct bd_hol
  * If found, increment the reference count and return the pointer.
  * If not found, returns NULL.
  */
-static int find_bd_holder(struct block_device *bdev, struct bd_holder *bo)
+static struct bd_holder *find_bd_holder(struct block_device *bdev,
+					struct bd_holder *bo)
 {
 	struct bd_holder *tmp;
 
@@ -682,7 +683,6 @@ static int find_bd_holder(struct block_d
  */
 static int add_bd_holder(struct block_device *bdev, struct bd_holder *bo)
 {
-	struct bd_holder *tmp;
 	int ret;
 
 	if (!bo)
_

