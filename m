Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbTLPULW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 15:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbTLPULW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 15:11:22 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:65008 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262074AbTLPULS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 15:11:18 -0500
Message-ID: <3FDF67ED.1070605@us.ltcfwd.linux.ibm.com>
Date: Tue, 16 Dec 2003 14:15:41 -0600
From: Linda Xie <lxiep@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Greg KH <gregkh@us.ibm.com>
CC: scheel@us.ibm.com, wortman@us.ibm.com
Subject: PATCH -- kobject_set_name() doesn't allocate enough space
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

The sapce allocated in kobject_set_name() is 1 byte less than it should 
be. The Attached patch fixes this bug.


Comments are welcome.

Thanks,



Linda Xie
IBM Linux Technology Center



diff -Nru a/lib/kobject.c b/lib/kobject.c
--- a/lib/kobject.c	Sun Dec 14 21:19:29 2003
+++ b/lib/kobject.c	Sun Dec 14 21:19:29 2003
@@ -344,12 +344,12 @@
  		/*
  		 * Need more space? Allocate it and try again
  		 */
-		name = kmalloc(need,GFP_KERNEL);
+		limit = need + 1;
+		name = kmalloc(limit,GFP_KERNEL);
  		if (!name) {
  			error = -ENOMEM;
  			goto Done;
  		}
-		limit = need;
  		need = vsnprintf(name,limit,fmt,args);

  		/* Still? Give up. */

