Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264857AbUGBTnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264857AbUGBTnV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 15:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264886AbUGBTnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 15:43:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:60307 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264857AbUGBTnU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 15:43:20 -0400
Date: Fri, 2 Jul 2004 12:42:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kevin Corry <kevcorry@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, dm-devel@redhat.com, torvalds@osdl.org,
       agk@redhat.com, Jim Houston <jim.houston@comcast.net>
Subject: Re: [PATCH] 1/1: Device-Mapper: Remove 1024 devices limitation
Message-Id: <20040702124218.0ad27a85.akpm@osdl.org>
In-Reply-To: <200407021233.09610.kevcorry@us.ibm.com>
References: <200407011035.13283.kevcorry@us.ibm.com>
	<200407012154.16312.kevcorry@us.ibm.com>
	<20040701203043.08226a0c.akpm@osdl.org>
	<200407021233.09610.kevcorry@us.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Corry <kevcorry@us.ibm.com> wrote:
>
> > Yes, idr is the one to use.  That linear search you have in there becomes
>  > logarithmic.  Will speed up the registration of 100,000 minors no end ;)
> 
>  I've got a patch that switches from a bit-set to an IDR structure. The only
>  thing I'm slightly uncertain about is the case where we're trying to create
>  a device with a specific minor number (when creating a DM device, you have
>  the choice to specify a minor number or have DM find the first available
>  one). To do this, I call idr_find() with the desired minor. If that returns
>  NULL (meaning it's not already in use), then I call idr_get_new_above() with
>  that same desired minor. In the cases I've tested, this always chooses the
>  desired minor, but can we depend on that behavior?

Yes, that has to work - you're holding the lock throughout.

It would be sensible to make that a part of the idr API though.  

