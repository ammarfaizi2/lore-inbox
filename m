Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262833AbVAFOFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262833AbVAFOFL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 09:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262831AbVAFOFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 09:05:11 -0500
Received: from mail.mellanox.co.il ([194.90.237.34]:34729 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S262834AbVAFOE6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 09:04:58 -0500
Date: Thu, 6 Jan 2005 16:06:36 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Andrew Morton <akpm@osdl.org>
Cc: Takashi Iwai <tiwai@suse.de>, ak@suse.de, mingo@elte.hu,
       rlrevell@joe-job.com, linux-kernel@vger.kernel.org, pavel@suse.cz,
       discuss@x86-64.org, gordon.jin@intel.com,
       alsa-devel@lists.sourceforge.net, greg@kroah.com, VANDROVE@vc.cvut.cz
Subject: [PATCH] macros to detect existance of unlocked_ioctl and ioctl_compat
Message-ID: <20050106140636.GE25629@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20041215065650.GM27225@wotan.suse.de> <20041217014345.GA11926@mellanox.co.il> <20050103011113.6f6c8f44.akpm@osdl.org> <20050105144043.GB19434@mellanox.co.il> <s5hd5wjybt8.wl@alsa2.suse.de> <20050105133448.59345b04.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050105133448.59345b04.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
Quoting r. Andrew Morton (akpm@osdl.org) "Re: [PATCH] deprecate (un)register_ioctl32_conversion":
> Takashi Iwai <tiwai@suse.de> wrote:
> >
> > At Wed, 5 Jan 2005 16:40:43 +0200,
> >  Michael S. Tsirkin wrote:
> >  > 
> >  > Hello, Andrew, all!
> >  > 
> >  > Since in -mm1 we now have a race-free replacement (that being ioctl_compat),
> >  > here is a patch to deprecate (un)register_ioctl32_conversion.
> > 
> >  Good to see that ioctl_native and ioctl_compat ops are already there!
> > 
> >  Will it be merged to 2.6.11?
> 
> It should be, unless there's some problem.  In maybe a week or so.

To make life bearable for out-of kernel modules, the following patch
adds 2 macros so that existance of unlocked_ioctl and ioctl_compat
can be easily detected.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

diff -puN include/linux/fs.h~ioctl-rework include/linux/fs.h
--- 25/include/linux/fs.h~ioctl-rework	Thu Dec 16 15:48:31 2004
+++ 25-akpm/include/linux/fs.h	Thu Dec 16 15:48:31 2004
@@ -907,6 +907,12 @@ typedef struct {
 
 typedef int (*read_actor_t)(read_descriptor_t *, struct page *, unsigned long, unsigned long);
 
+/* These macros are for out of kernel modules to test that
+ * the kernel supports the unlocked_ioctl and ioctl_compat
+ * fields in struct file_operations. */
+#define HAVE_IOCTL_COMPAT 1
+#define HAVE_UNLOCKED_IOCTL 1
+
 /*
  * NOTE:
  * read, write, poll, fsync, readv, writev can be called
