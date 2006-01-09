Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbWAIVBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbWAIVBW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 16:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbWAIVBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 16:01:22 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:53007 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751342AbWAIVBV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 16:01:21 -0500
Date: Mon, 9 Jan 2006 22:01:05 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: xfs: Makefile-linux-2.6 => Makefile?
Message-ID: <20060109210105.GA13853@mars.ravnborg.org>
References: <20060109164214.GA10367@mars.ravnborg.org> <20060109164611.GA1382@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060109164611.GA1382@infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 04:46:11PM +0000, Christoph Hellwig wrote:
> On Mon, Jan 09, 2006 at 05:42:14PM +0100, Sam Ravnborg wrote:
> > Hi hch.
> > 
> > Any specific reason why xfs uses a indirection for the Makefile?
> > It is planned to drop export of VERSION, PATCHLEVEL etc. from
> > main makefile and it is OK except for xfs due to the funny
> > Makefile indirection.
> > 
> > I suggest:
> > git mv fs/xfs/Makefile-linux-2.6 fs/xfs/Makefile
> 
> I'd be all for it, but the SGI people like this layout to keep a common
> fs/xfs for both 2.4 and 2.6 (with linux-2.4 and linux-2.6 subdirs respectively)
> 
> p.s. and no, I'm not official xfs maintainer and never have been, so cc set
> to linux-xfs were all interested parties hang around.
Following is what I have committed in my tree to avod using the now
un-exported symbols.

	Sam

diff-tree a9aa1ffaac7c8d6f093bb8f7cdeea761a5e25f53 (from 0d20babd86b40fa5ac55d9ebf31d05f6f7082161)
Author: Sam Ravnborg <sam@mars.ravnborg.org>
Date:   Mon Jan 9 20:48:03 2006 +0100

    kbuild/xfs: introduce fs/xfs/Kbuild
    
    In kbuild the file named 'Kbuild' has precedence over the file named
    Makefile. Utilise a file named Kbuild to include the 2.6 Makefile for xfs
    - since the xfs people likes to keep their arch specific Makefiles separate.
    
    With this patch xfs does no longer rely on the KERNELRELEASE components to be global.
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

diff --git a/fs/xfs/Kbuild b/fs/xfs/Kbuild
new file mode 100644
index 0000000..2566e96
--- /dev/null
+++ b/fs/xfs/Kbuild
@@ -0,0 +1,6 @@
+#
+# The xfs people like to share Makefile with 2.6 and 2.4.
+# Utilise file named Kbuild file which has precedence over Makefile.
+#
+
+include $(srctree)/$(obj)/Makefile-linux-2.6
