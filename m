Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031875AbWLGJKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031875AbWLGJKu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 04:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031876AbWLGJKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 04:10:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48579 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031875AbWLGJKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 04:10:48 -0500
Subject: Re: [GFS2] Fix crc32 calculation in recovery.c [8/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: Andrew Morton <akpm@osdl.org>, Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0612020939460.1635@yvahk01.tjqt.qr>
References: <1164888829.3752.318.camel@quoit.chygwyn.com>
	 <Pine.LNX.4.61.0612020939460.1635@yvahk01.tjqt.qr>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 07 Dec 2006 09:14:05 +0000
Message-Id: <1165482845.3752.820.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 2006-12-02 at 09:40 +0100, Jan Engelhardt wrote:
> >Commit "[GFS2] split and annotate gfs2_log_head" resulted in an incorrect
> >checksum calculation for log headers. This patch corrects the
> >problem without resorting to copying the whole log header as
> >the previous code used to.
> >
> >Cc: Al Viro <viro@zeniv.linux.org.uk>
> >Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
> >---
> > fs/gfs2/recovery.c |    9 +++++----
> > 1 files changed, 5 insertions(+), 4 deletions(-)
> >
> >diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
> >index 4478162..4acf238 100644
> >--- a/fs/gfs2/recovery.c
> >+++ b/fs/gfs2/recovery.c
> >@@ -136,6 +136,7 @@ static int get_log_header(struct gfs2_jd
> > {
> > 	struct buffer_head *bh;
> > 	struct gfs2_log_header_host lh;
> >+static const u32 nothing = 0;
> > 	u32 hash;
> > 	int error;
> > 
> 
> At least indent it.
> 

As per your comment and also Andrew Morton's similar remark, here is the
patch I'm just about to add to the tree,

Steve.

---------------------------------------------------------------------------------------
>From 887bc5d00c02b32763845247024e8db5243ef857 Mon Sep 17 00:00:00 2001
From: Steven Whitehouse <swhiteho@redhat.com>
Date: Tue, 5 Dec 2006 13:34:17 -0500
Subject: [PATCH] [GFS2] Fix indent in recovery.c

As per comments from Andrew Morton and Jan Engelhardt, this fixes the
indent and removes the "static" from a variable declaration since its
not needed in this case (now allocated on the stack of the function
in question).

Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Andrew Morton <akpm@osdl.org>
---
 fs/gfs2/recovery.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
index 4acf238..d0c806b 100644
--- a/fs/gfs2/recovery.c
+++ b/fs/gfs2/recovery.c
@@ -136,7 +136,7 @@ static int get_log_header(struct gfs2_jd
 {
 	struct buffer_head *bh;
 	struct gfs2_log_header_host lh;
-static const u32 nothing = 0;
+	const u32 nothing = 0;
 	u32 hash;
 	int error;
 
-- 
1.4.1



