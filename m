Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbWIEKaa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbWIEKaa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 06:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbWIEKaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 06:30:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3783 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751295AbWIEKa3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 06:30:29 -0400
Subject: Re: [PATCH 08/16] GFS2: Resource group code
From: Steven Whitehouse <swhiteho@redhat.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org, Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
In-Reply-To: <Pine.LNX.4.61.0609041637500.17279@yvahk01.tjqt.qr>
References: <1157031351.3384.799.camel@quoit.chygwyn.com>
	 <Pine.LNX.4.61.0609041637500.17279@yvahk01.tjqt.qr>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Tue, 05 Sep 2006 11:36:13 +0100
Message-Id: <1157452573.3384.984.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2006-09-04 at 16:50 +0200, Jan Engelhardt wrote:
> >+#define BFITNOENT 0xFFFFFFFF
> 
> See previous mail, (uint32_t)-1 / (uint32_t)~0 or leave it.
> 
ok.

> >+static inline int rgrp_contains_block(struct gfs2_rindex *ri, uint64_t block)
> >+{
> >+	uint64_t first = ri->ri_data0;
> >+	uint64_t last = first + ri->ri_data;
> >+	return !!(first <= block && block < last);
> >+}
> 
> No need for the !!, the expression !! is operating on is already a boolean.
> IOW,
> 
> 	return first <= block && block < last;
> 
Now fixed in:

http://www.kernel.org/git/?p=linux/kernel/git/steve/gfs2-2.6.git;a=commitdiff;h=16910427e1eb2a8069708ee24406d2d465381ebd

> 
> >+/**
> >+ * gfs2_alloc_put - throw away the struct gfs2_alloc for an inode
> >+ * @ip: the inode
> >+ *
> >+ */
> >+
> >+void gfs2_alloc_put(struct gfs2_inode *ip)
> >+{
> >+	return;
> >+}
> 
> Missing some code? Code that comes later?
> 
> 
> Jan Engelhardt

Well the allocation structure used to be kmalloc'ed and free'd by this
function and gfs2_alloc_get. I changed that to put it inline in the
struct gfs2_inode since there didn't seem a lot of point in having it
dynamically allocated. I had left this function though since it was
useful to have some demarcation points in the code which showed where
the structure was in use. My plan was to later add some debugging to
detect any use outside of those points, hence, I'd left in this
function.

It could be removed now, but I'd prefer to give it a stay of execution
for a little while at least if nobody has any strong objections to that,

Steve.


