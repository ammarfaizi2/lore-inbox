Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262708AbTIVBPM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 21:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262712AbTIVBPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 21:15:12 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:4826 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S262708AbTIVBPI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 21:15:08 -0400
Date: Mon, 22 Sep 2003 11:12:41 +1000
From: Nathan Scott <nathans@sgi.com>
To: Walt H <waltabbyh@comcast.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux XFS Mailing List <linux-xfs@oss.sgi.com>
Subject: Re: 2.6.0-test5-mm3 & XFS FS Corruption (or not?)
Message-ID: <20030922011241.GA1043@frodo>
References: <3F6DC819.8060003@comcast.net> <3F6DE929.4040904@comcast.net> <1064173697.2285.4.camel@laptop.americas.sgi.com> <3F6E49D2.8060901@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F6E49D2.8060901@comcast.net>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 21, 2003 at 06:01:06PM -0700, Walt H wrote:
> Steve Lord wrote:
> > 
> > If I am correct, test5-mm3 contains a bad version of the xfs code, there
> > was a bug where the i_flags field was setup from an uninitialized stack
> > variable. mm3 came out during the two days this was in Linus's tree.
> > I had some very odd behavior with this code base, rm -r -f would try and
> > cd into files and other bizzare things, files could appear to be
> > immutable or append only or things they were not. This sounds like
> > similar behavior you that you saw. It is fixed in the latest code Linus
> > has.
> 
> Thanks for the reply Steve. I'm guessing that this code hasn't hit CVS
> yet, as I can still reproduce it with a current CVS @ 9/21/03 ~ 17:30
> PST  Sounds like this is a known issue, so I'll just go back to the xfs
> code from -mm2 for now.
> 

The fix is below, I'd be interested in whether or not you still have
problems after applying this.

thanks.

-- 
Nathan


--- /usr/tmp/TmpDir.2990917-0/linux/fs/xfs/linux/xfs_vnode.c_1.117	Mon Sep 22 11:10:21 2003
+++ linux/fs/xfs/linux/xfs_vnode.c	Fri Sep 19 13:17:14 2003
@@ -200,7 +200,7 @@
 	vn_trace_entry(vp, "vn_revalidate", (inst_t *)__return_address);
 	ASSERT(vp->v_fbhv != NULL);
 
-	va.va_mask = XFS_AT_STAT;
+	va.va_mask = XFS_AT_STAT|XFS_AT_GENCOUNT;
 	VOP_GETATTR(vp, &va, 0, NULL, error);
 	if (!error) {
 		inode = LINVFS_GET_IP(vp);
