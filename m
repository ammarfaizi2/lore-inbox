Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVCXXFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVCXXFQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 18:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVCXXFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 18:05:16 -0500
Received: from fire.osdl.org ([65.172.181.4]:3734 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261198AbVCXXFJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 18:05:09 -0500
Date: Thu, 24 Mar 2005 15:04:50 -0800
From: cliff white <cliffw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: airlied@linux.ie, davej@redhat.com, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net
Subject: Re: drm bugs hopefully fixed but there might still be one..
Message-ID: <20050324150450.01fbf17f@es175>
In-Reply-To: <20050324142131.2646c4fd.akpm@osdl.org>
References: <Pine.LNX.4.58.0503241015190.7647@skynet>
	<20050324135851.388d1b4e@es175>
	<20050324142131.2646c4fd.akpm@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed-Claws 1.0.1 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Mar 2005 14:21:31 -0800
Andrew Morton <akpm@osdl.org> wrote:

> cliff white <cliffw@osdl.org> wrote:
> >
> > Okay, i have a iBook G4, with radeon, with 2.6.12-rc1-mm2, i'm getting the following OOPS
> > on boot. 
> 
> Please try reverting agp-make-some-code-static.patch (Dunno why that would
> fix an oops, but apparently it does).
> 
It does the same thing Brice's fix does. Need to put the 
one extern struct definition back in agp_backend.h and that is the badness:

diff -puN include/linux/agp_backend.h~agp-make-some-code-static include/linux/agp_backend.h
--- 25/include/linux/agp_backend.h~agp-make-some-code-static    2005-03-21 21:53:17.000000000 -0800
+++ 25-akpm/include/linux/agp_backend.h 2005-03-21 21:53:17.000000000 -0800
@@ -94,8 +94,6 @@ struct agp_memory {
 extern struct agp_bridge_data *agp_bridge;
 extern struct list_head agp_bridges;

-extern struct agp_bridge_data *(*agp_find_bridge)(struct pci_dev *);
-
 extern void agp_free_memory(struct agp_memory *);
 extern struct agp_memory *agp_allocate_memory(struct agp_bridge_data *, size_t, u32);
 extern int agp_copy_info(struct agp_bridge_data *, struct agp_kern_info *);
_
----------
cliffw

-- 
"Ive always gone through periods where I bolt upright at four in the morning; 
now at least theres a reason." -Michael Feldman
