Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbVG1D7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbVG1D7P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 23:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVG1D7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 23:59:15 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:59355 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261293AbVG1D7N convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 23:59:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uJU7OSivojaEN+KEf+ec/G6r6wzGazI72WfFfZBSkKeUsY0K5niKsAFTg9s6IziiVfP2JAox5kKY1t/5MwikYLwTW8DTLobnPguA08QNJfzo7VNWYSu+gx/aS5oEe+bvyiULAeWohXUEt/U9xeF5pGI93oRnYKjgySLJvtQwI20=
Message-ID: <9e473391050727205971b0aee@mail.gmail.com>
Date: Wed, 27 Jul 2005 23:59:11 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] driver core: Add the ability to unbind drivers to devices from userspace
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org
In-Reply-To: <20050728034610.GA12123@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e4733910507250728a7882d4@mail.gmail.com>
	 <9e47339105072509307386818b@mail.gmail.com>
	 <20050726000024.GA23858@kroah.com>
	 <9e473391050725172833617aca@mail.gmail.com>
	 <20050726003018.GA24089@kroah.com>
	 <9e47339105072517561f53b2f9@mail.gmail.com>
	 <20050726015401.GA25015@kroah.com>
	 <9e473391050725201553f3e8be@mail.gmail.com>
	 <9e47339105072719057c833e62@mail.gmail.com>
	 <20050728034610.GA12123@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

New patch with fixed whitespace.

-- 
Jon Smirl
jonsmirl@gmail.com


diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -6,6 +6,7 @@
 #include <linux/fsnotify.h>
 #include <linux/kobject.h>
 #include <linux/namei.h>
+#include <linux/ctype.h>
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
 
@@ -207,6 +208,28 @@ flush_write_buffer(struct dentry * dentr
 	struct attribute * attr = to_attr(dentry);
 	struct kobject * kobj = to_kobj(dentry->d_parent);
 	struct sysfs_ops * ops = buffer->ops;
+	char *x, *y, *z;
+
+	/* locate leading white space */
+	x = buffer->page;
+	while (isspace(*x) && (x - buffer->page < count))
+		x++;
+
+	/* locate trailng white space */
+	z = y = x;
+	while (y - buffer->page < count) {
+		y++;
+		z = y;
+		while (isspace(*y) && (y - buffer->page < count)) {
+			y++;
+		}
+	}
+	count = z - x;
+
+	/* strip the white space */
+	if (buffer->page != x)
+		memmove(buffer->page, x, count);
+	buffer->page[count] = '\0';
 
 	return ops->store(kobj,attr,buffer->page,count);
 }
