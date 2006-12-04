Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935412AbWLDKLB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935412AbWLDKLB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 05:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935457AbWLDKLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 05:11:01 -0500
Received: from mx1.redhat.com ([66.187.233.31]:10941 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S935412AbWLDKLA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 05:11:00 -0500
Subject: Re: [GFS2] Fix crc32 calculation in recovery.c [8/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0612020939460.1635@yvahk01.tjqt.qr>
References: <1164888829.3752.318.camel@quoit.chygwyn.com>
	 <Pine.LNX.4.61.0612020939460.1635@yvahk01.tjqt.qr>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Mon, 04 Dec 2006 10:13:12 +0000
Message-Id: <1165227192.3752.618.camel@quoit.chygwyn.com>
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

I've had a private email from someone pointing out the same thing. It
was not intended to emphasise the fact that it is static, I'm not sure
if thats the "right thing" or not, but either way, it doesn't actually
need to be static, so that I've agreed that I'll remove the static and
just leave it as const and fix the indenting at the same time,

Steve.


