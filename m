Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbVCXXMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVCXXMp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 18:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVCXXMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 18:12:45 -0500
Received: from fire.osdl.org ([65.172.181.4]:42903 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261231AbVCXXMk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 18:12:40 -0500
Date: Thu, 24 Mar 2005 15:12:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: cliff white <cliffw@osdl.org>
Cc: airlied@linux.ie, davej@redhat.com, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net
Subject: Re: drm bugs hopefully fixed but there might still be one..
Message-Id: <20050324151220.5e5f3d5f.akpm@osdl.org>
In-Reply-To: <20050324150450.01fbf17f@es175>
References: <Pine.LNX.4.58.0503241015190.7647@skynet>
	<20050324135851.388d1b4e@es175>
	<20050324142131.2646c4fd.akpm@osdl.org>
	<20050324150450.01fbf17f@es175>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cliff white <cliffw@osdl.org> wrote:
>
> -extern struct agp_bridge_data *(*agp_find_bridge)(struct pci_dev *);
> -

Oh crap, so the compiler decided that agp_find_bridge() was a function and
decided to jump to it, rather than reading from it and doing an indirect
jump.  Yup, that'll crash it.  Sorry about that.

This is another reason why doing the old-style

	(*agp_find_bridge)(...);

is better than doing the new-style

	agp_find_bridge(...);

The former case won't even compile, and is more readable.
