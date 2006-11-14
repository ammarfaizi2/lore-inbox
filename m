Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966432AbWKNW4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966432AbWKNW4o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 17:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966435AbWKNW4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 17:56:44 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:40201 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S966434AbWKNW4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 17:56:35 -0500
Date: Tue, 14 Nov 2006 23:56:41 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Steven Whitehouse <swhiteho@redhat.com>,
       pcaulfie@redhat.com, teigland@redhat.com
Cc: linux-kernel@vger.kernel.org, cluster-devel@redhat.com
Subject: [-mm patch] fix the DLM dependencies, part 2
Message-ID: <20061114225641.GP22565@stusta.de>
References: <20061114014125.dd315fff.akpm@osdl.org> <20061114183324.GL22565@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114183324.GL22565@stusta.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2006 at 07:33:24PM +0100, Adrian Bunk wrote:
> On Tue, Nov 14, 2006 at 01:41:25AM -0800, Andrew Morton wrote:
> >...
> > - A nasty Kconfig warning comes out during the build.  It's due to
> >   git-gfs2-nmw.patch.
> >...
> 
> So let's fix it.  ;-)
>...

And let's also fix another bug...


<--  snip  -->


IPV6=m, DLM=m, DLM_SCTP=y mustn't result in IP_SCTP=y.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc5-mm2/fs/dlm/Kconfig.old	2006-11-14 22:25:01.000000000 +0100
+++ linux-2.6.19-rc5-mm2/fs/dlm/Kconfig	2006-11-14 22:25:19.000000000 +0100
@@ -5,6 +5,7 @@ config DLM
 	tristate "Distributed Lock Manager (DLM)"
 	depends on IPV6 || IPV6=n
 	select CONFIGFS_FS
+	select IP_SCTP if DLM_SCTP
 	help
 	A general purpose distributed lock manager for kernel or userspace
 	applications.
@@ -23,7 +24,6 @@ config DLM_TCP
 
 config DLM_SCTP
 	bool "SCTP"
-	select IP_SCTP
 
 endchoice
 

