Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261766AbVGROYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbVGROYA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 10:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbVGROX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 10:23:59 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:43464 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261766AbVGROWR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 10:22:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=nkE0nGdLgJIAoEd1dSb9lzVJITFua/D12R6gdO9b9lqzVcPUk5X0Lu/HPbt0ChGal44ZkZvkGi1/O1KkMQ8WbEZWIHS79c4HbgMkhHVQGLXKZdhSwjaA1sOhh/Qb5ViI+KFfrNgLNpfDXSk7BOhbYLbhYVEZXAJfpz0Hh/OUE5k=
Date: Mon, 18 Jul 2005 10:21:54 -0400
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm1
Message-ID: <20050718142154.GA11815@nineveh.rivenstone.net>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050715013653.36006990.akpm@osdl.org> <20050717013248.GA10673@nineveh.rivenstone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050717013248.GA10673@nineveh.rivenstone.net>
User-Agent: Mutt/1.5.6+20040907i
From: jfannin@gmail.com (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2005 at 09:32:49PM -0400,  wrote:
> On Fri, Jul 15, 2005 at 01:36:53AM -0700, Andrew Morton wrote:
> > 
>  ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc3/2.6.13-rc3-mm1/
>  
> > +suspend-update-documentation.patch
> > +swsusp-fix-printks-and-cleanups.patch
> > +swsusp-fix-remaining-u32-vs-pm_message_t-confusion.patch
> > +swsusp-switch-pm_message_t-to-struct.patch
> > +swsusp-switch-pm_message_t-to-struct-pmac_zilog-fix.patch
> > +swsusp-switch-pm_message_t-to-struct-ppc32-fixes.patch
> > +fix-pm_message_t-stuff-in-mm-tree-netdev.patch
> 

    I needed this little patch too.  It's boot-tested; I have a MESH
controller.

    Thanks!

-

diff -aurN linux-2.6.13-rc3-mm1/drivers/scsi/mesh.c linux-2.6.13-rc3-mm1_changed/drivers/scsi/mesh.c
--- linux-2.6.13-rc3-mm1/drivers/scsi/mesh.c	2005-07-16 01:46:44.000000000 -0400
+++ linux-2.6.13-rc3-mm1_changed/drivers/scsi/mesh.c	2005-07-18 07:52:04.000000000 -0400
@@ -1766,7 +1766,7 @@
 	struct mesh_state *ms = (struct mesh_state *)macio_get_drvdata(mdev);
 	unsigned long flags;
 
-	if (state == mdev->ofdev.dev.power.power_state || state < 2)
+	if (state.event == mdev->ofdev.dev.power.power_state.event || state.event < 2)
 		return 0;
 
 	scsi_block_requests(ms->host);
@@ -1781,7 +1781,7 @@
 	disable_irq(ms->meshintr);
 	set_mesh_power(ms, 0);
 
-	mdev->ofdev.dev.power.power_state = state;
+	mdev->ofdev.dev.power.power_state.event = state.event;
 
 	return 0;
 }
@@ -1791,7 +1791,7 @@
 	struct mesh_state *ms = (struct mesh_state *)macio_get_drvdata(mdev);
 	unsigned long flags;
 
-	if (mdev->ofdev.dev.power.power_state == 0)
+	if (mdev->ofdev.dev.power.power_state.event == 0)
 		return 0;
 
 	set_mesh_power(ms, 1);
@@ -1802,7 +1802,7 @@
 	enable_irq(ms->meshintr);
 	scsi_unblock_requests(ms->host);
 
-	mdev->ofdev.dev.power.power_state = 0;
+	mdev->ofdev.dev.power.power_state.event = 0;
 
 	return 0;
 }


-- 
Joseph Fannin
jfannin@gmail.com

"That's all I have to say about that." -- Forrest Gump.
