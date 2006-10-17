Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWJQV1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWJQV1b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 17:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbWJQV1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 17:27:31 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:33403 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750760AbWJQV1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 17:27:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=cz4gV6KJwIYHDP+/Yuy76SF37EhKi1MtnWVUK21Fhx01+3ttfmpeSQq19+n9xQiNGquS7Vb+MF2ySiEYkxLyPXlYmZawRB6zQl5ux774MZg/U+cwi34+zlD44GLumvZnJxsqw9r+vO9cczvQdLKo9BOAvfvDmv2pL7yLdFyPyXo=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 10/10] uml: mmapper - remove just added but wrong "const" attribute
Date: Tue, 17 Oct 2006 23:27:23 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20061017212723.26445.57342.stgit@americanbeauty.home.lan>
In-Reply-To: <20061017211943.26445.75719.stgit@americanbeauty.home.lan>
References: <20061017211943.26445.75719.stgit@americanbeauty.home.lan>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

When enabling the mmapper driver I got warnings because this "const" miscdevice
structure is passed to function as non-const pointer; unlike struct
tty_operations, however, I verified that misc_{de,}register _do_ modify their
parameter, so this const attribute must be removed.

Since the purpose of the change was to guarantee that no lock was needed, add a
comment to prove this differently.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/mmapper_kern.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/um/drivers/mmapper_kern.c b/arch/um/drivers/mmapper_kern.c
index 9a3b5da..df3516e 100644
--- a/arch/um/drivers/mmapper_kern.c
+++ b/arch/um/drivers/mmapper_kern.c
@@ -95,7 +95,8 @@ static const struct file_operations mmap
 	.release	= mmapper_release,
 };
 
-static const struct miscdevice mmapper_dev = {
+/* No locking needed - only used (and modified) by below initcall and exitcall. */
+static struct miscdevice mmapper_dev = {
 	.minor		= MISC_DYNAMIC_MINOR,
 	.name		= "mmapper",
 	.fops		= &mmapper_fops
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
