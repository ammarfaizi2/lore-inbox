Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbWDREYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWDREYz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 00:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWDREYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 00:24:55 -0400
Received: from cantor.suse.de ([195.135.220.2]:59522 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932186AbWDREYy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 00:24:54 -0400
Date: Mon, 17 Apr 2006 21:23:45 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Subject: Re: Linux 2.6.16.7
Message-ID: <20060418042345.GB11061@kroah.com>
References: <20060418042300.GA11061@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060418042300.GA11061@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 7959505..06a8926 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 16
-EXTRAVERSION = .6
+EXTRAVERSION = .7
 NAME=Sliding Snow Leopard
 
 # *DOCUMENTATION*
diff --git a/mm/madvise.c b/mm/madvise.c
index af3d573..4e19615 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -168,6 +168,9 @@ static long madvise_remove(struct vm_are
 			return -EINVAL;
 	}
 
+	if ((vma->vm_flags & (VM_SHARED|VM_WRITE)) != (VM_SHARED|VM_WRITE))
+		return -EACCES;
+
 	mapping = vma->vm_file->f_mapping;
 
 	offset = (loff_t)(start - vma->vm_start)
