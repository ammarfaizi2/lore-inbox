Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262631AbVFLPls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262631AbVFLPls (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 11:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262630AbVFLPlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 11:41:47 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:59789 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262626AbVFLPle convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 11:41:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G0+bHMUJNLtNfyDUFu8nB2DnBvN0UYZhIHN1FciRnH+oV6u7BnXhr9dg1zvgGUnKl1UYxcC5rX8qK9ZrTkOAKvw0XqGSsTV9jTicIjhEhrCthE2HeZOqmHmYa4Cq44oPU8p5DNcOLO+SxPdljuX1GvhiJ6B4x+79gL6Y8rlC/qc=
Message-ID: <9e47339105061208417f7097b9@mail.gmail.com>
Date: Sun, 12 Jun 2005 11:41:32 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: Re: off by one in sysfs
In-Reply-To: <9e47339105061120007061d7b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e47339105061120007061d7b1@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to fix the off by one.

signed-off-by: jonsmirl@gmail.com <Jon Smirl>
diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -182,7 +182,7 @@ fill_write_buffer(struct sysfs_buffer * 
 		return -ENOMEM;
 
 	if (count >= PAGE_SIZE)
-		count = PAGE_SIZE - 1;
+		count = PAGE_SIZE;
 	error = copy_from_user(buffer->page,buf,count);
 	buffer->needs_read_fill = 1;
 	return error ? -EFAULT : count;
