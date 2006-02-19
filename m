Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932433AbWBSNZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbWBSNZN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 08:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbWBSNZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 08:25:12 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:64519 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932433AbWBSNZL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 08:25:11 -0500
Date: Sun, 19 Feb 2006 14:24:59 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [kbuild,-mm] [PATCH] workaround a cscope bug (make cscope segfaults)
Message-ID: <20060219132459.GA9993@mars.ravnborg.org>
References: <20060219125037.GA29662@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060219125037.GA29662@inferi.kami.home>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2006 at 01:50:37PM +0100, Mattia Dongili wrote:
> 
> Workaround a cscope bug where a trailing ':' in VPATH makes it segfault
> and let it build the cross-reference succesfully.
> 
> VPATH=/home/mattia/devel/kernel/git/linux-2.6: cscope -b
> [1]    17555 segmentation fault VPATH=/home/mattia/devel/kernel/git/linux-2.6: cscope -b
> 
> Signed-off-by: Mattia Dongili <malattia@linux.it>
Hi Mattia.
I have added the following patch to my tree.
Thanks for the report.

	Sam

diff --git a/Makefile b/Makefile
index a55a1e4..7a95f4f 100644
--- a/Makefile
+++ b/Makefile
@@ -137,7 +137,7 @@ objtree		:= $(CURDIR)
 src		:= $(srctree)
 obj		:= $(objtree)
 
-VPATH		:= $(srctree):$(KBUILD_EXTMOD)
+VPATH		:= $(srctree)$(if $(KBUILD_EXTMOD),:$(KBUILD_EXTMOD))
 
 export srctree objtree VPATH TOPDIR
 
