Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261985AbULLCLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbULLCLU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 21:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbULLCLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 21:11:19 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:31749 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261985AbULLCLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 21:11:04 -0500
Date: Sun, 12 Dec 2004 03:10:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] efs: make a struct static
Message-ID: <20041212021054.GK22324@stusta.de>
References: <20041030175636.GP4374@stusta.de> <200410310041.25152.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410310041.25152.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 31, 2004 at 12:41:25AM +0300, Denis Vlasenko wrote:
> On Saturday 30 October 2004 20:56, Adrian Bunk wrote:
> > The patch below makes a struct in the efs code static.
> > 
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > 
> > --- linux-2.6.10-rc1-mm2-full/include/linux/efs_vh.h.old	2004-10-30 14:03:58.000000000 +0200
> > +++ linux-2.6.10-rc1-mm2-full/include/linux/efs_vh.h	2004-10-30 14:04:13.000000000 +0200
> > @@ -44,7 +44,7 @@
> >  #define SGI_EFS		0x07
> >  #define IS_EFS(x)	(((x) == SGI_EFS) || ((x) == SGI_SYSV))
> >  
> > -struct pt_types {
> > +static struct pt_types {
> >  	int	pt_type;
> >  	char	*pt_name;
> >  } sgi_pt_types[] = {
> 
> You made a variable in .h file static. This is a no-no.

Not that the previous code was much better...

> Only fs/efs/super.c includes linux/efs_vh.h now, but if
> it will be ever included into another files, you
> will get silent data duplication.
> 
> Unless I miss something, you really wanted to do:
>...

Sounds good, updated patch below.


The patch below makes a needessly global struct in the efs code static.


diffstat output:
 fs/efs/super.c         |   20 ++++++++++++++++++++
 include/linux/efs_vh.h |   17 -----------------
 2 files changed, 20 insertions(+), 17 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/include/linux/efs_vh.h.old	2004-12-12 00:28:23.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/include/linux/efs_vh.h	2004-12-12 00:30:45.000000000 +0100
@@ -47,23 +47,6 @@
 struct pt_types {
 	int	pt_type;
 	char	*pt_name;
-} sgi_pt_types[] = {
-	{0x00,		"SGI vh"},
-	{0x01,		"SGI trkrepl"},
-	{0x02,		"SGI secrepl"},
-	{0x03,		"SGI raw"},
-	{0x04,		"SGI bsd"},
-	{SGI_SYSV,	"SGI sysv"},
-	{0x06,		"SGI vol"},
-	{SGI_EFS,	"SGI efs"},
-	{0x08,		"SGI lv"},
-	{0x09,		"SGI rlv"},
-	{0x0A,		"SGI xfs"},
-	{0x0B,		"SGI xfslog"},
-	{0x0C,		"SGI xlv"},
-	{0x82,		"Linux swap"},
-	{0x83,		"Linux native"},
-	{0,		NULL}
 };
 
 #endif /* __EFS_VH_H__ */
--- linux-2.6.10-rc2-mm4-full/fs/efs/super.c.old	2004-12-12 00:29:46.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/fs/efs/super.c	2004-12-12 00:30:32.000000000 +0100
@@ -32,6 +32,26 @@
 	.fs_flags	= FS_REQUIRES_DEV,
 };
 
+static struct pt_types sgi_pt_types[] = {
+	{0x00,		"SGI vh"},
+	{0x01,		"SGI trkrepl"},
+	{0x02,		"SGI secrepl"},
+	{0x03,		"SGI raw"},
+	{0x04,		"SGI bsd"},
+	{SGI_SYSV,	"SGI sysv"},
+	{0x06,		"SGI vol"},
+	{SGI_EFS,	"SGI efs"},
+	{0x08,		"SGI lv"},
+	{0x09,		"SGI rlv"},
+	{0x0A,		"SGI xfs"},
+	{0x0B,		"SGI xfslog"},
+	{0x0C,		"SGI xlv"},
+	{0x82,		"Linux swap"},
+	{0x83,		"Linux native"},
+	{0,		NULL}
+};
+
+
 static kmem_cache_t * efs_inode_cachep;
 
 static struct inode *efs_alloc_inode(struct super_block *sb)

