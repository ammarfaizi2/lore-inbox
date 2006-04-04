Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750964AbWDEAAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbWDEAAw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 20:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbWDEAAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 20:00:42 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:912 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1750954AbWDEAAa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 20:00:30 -0400
Date: Tue, 4 Apr 2006 16:59:47 -0700
From: gregkh@suse.de
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 03/26] sysfs: zero terminate sysfs write buffers (CVE-2006-1055)
Message-ID: <20060404235947.GD27049@kroah.com>
References: <20060404235634.696852000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="sysfs-off-by-one.patch"
In-Reply-To: <20060404235927.GA27049@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No one should be writing a PAGE_SIZE worth of data to a normal sysfs
file, so properly terminate the buffer.

Thanks to Al Viro for pointing out my stupidity here.

CVE-2006-1055 has been assigned for this.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 fs/sysfs/file.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.16.1.orig/fs/sysfs/file.c
+++ linux-2.6.16.1/fs/sysfs/file.c
@@ -183,7 +183,7 @@ fill_write_buffer(struct sysfs_buffer * 
 		return -ENOMEM;
 
 	if (count >= PAGE_SIZE)
-		count = PAGE_SIZE;
+		count = PAGE_SIZE - 1;
 	error = copy_from_user(buffer->page,buf,count);
 	buffer->needs_read_fill = 1;
 	return error ? -EFAULT : count;

--
