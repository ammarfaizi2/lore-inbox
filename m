Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbUCaXyX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 18:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262090AbUCaXyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 18:54:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:65202 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262071AbUCaXyU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 18:54:20 -0500
Date: Wed, 31 Mar 2004 15:56:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jesse Barnes <jbarnes@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-mm2
Message-Id: <20040331155626.3f196a18.akpm@osdl.org>
In-Reply-To: <200403311515.01289.jbarnes@sgi.com>
References: <20040317201454.5b2e8a3c.akpm@osdl.org>
	<200403311102.58136.jbarnes@sgi.com>
	<20040331120634.39c959fd.akpm@osdl.org>
	<200403311515.01289.jbarnes@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes <jbarnes@sgi.com> wrote:
>
> On Wednesday 31 March 2004 12:06 pm, Andrew Morton wrote:
> > So are we to assume that this is the offending process?  That the periodic
> > slab reaping code has screwed up?
> 
> It looks like it.  Disabling the slab cache reaping function allows it to boot 
> again.

I suspect that the reap timer is innocent and what we have is simply
scribbled-on slab metadata.  Which means it could be anything at all.

One last thing: could you please stick a

	printk(KERN_EMERG "destroying slab %s\n", cachep->name);

at the start of slab_destroy()?  That'll help narrow it down.

Could you also punt me over the .config?  If I can make it happen, the
binary search will find it.  But it probably won't happen here.
