Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265024AbUE0TBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265024AbUE0TBu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 15:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265033AbUE0TBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 15:01:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:1435 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265024AbUE0TBt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 15:01:49 -0400
Date: Thu, 27 May 2004 12:01:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: FabF <fabian.frederick@skynet.be>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [2.6.7-rc1-mm1] lp int copy_to_user replaced
Message-Id: <20040527120107.2d61a9f5.akpm@osdl.org>
In-Reply-To: <1085681215.2070.27.camel@localhost.localdomain>
References: <1085679127.2070.21.camel@localhost.localdomain>
	<20040527180118.GQ12308@parcelfarce.linux.theplanet.co.uk>
	<1085681215.2070.27.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FabF <fabian.frederick@skynet.be> wrote:
>
>  On Thu, 2004-05-27 at 20:01, viro@parcelfarce.linux.theplanet.co.uk
>  wrote:
>  > On Thu, May 27, 2004 at 07:32:08PM +0200, FabF wrote:
>  > > Andrew,
>  > > 
>  > > 	Here's a patch to have standard __put_user for integer transfers in lp
>  > > driver.Is it correct ?
>  > 
>  > What the hell for?  copy_to_user()/copy_from_user() is perfectly OK here.
>  > 
>  And why the hell use generic functions when we have neat small type
>  exchange macros ?

copy_*_user() has special-case code to handle 1, 2 and 4-byte copies, so
your patch should make no difference on x86.  Other architectures do not
have that optimisation.

So the patch is a tiny optimisation for some architectures.  However, it's
of very small benefit - we could make a million such changes.  Would prefer
more substantial things at this time, please.
