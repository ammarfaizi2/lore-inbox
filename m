Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753154AbVHHAmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154AbVHHAmp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 20:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753155AbVHHAmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 20:42:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9694 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1753154AbVHHAmo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 20:42:44 -0400
Date: Sun, 7 Aug 2005 17:41:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: chrisw@osdl.org, linux-kernel@vger.kernel.org,
       Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH] abstract out bits of ldt.c
Message-Id: <20050807174129.20c7202f.akpm@osdl.org>
In-Reply-To: <374910000.1123459025@[10.10.2.4]>
References: <372830000.1123456808@[10.10.2.4]>
	<20050807234411.GE7991@shell0.pdx.osdl.net>
	<374910000.1123459025@[10.10.2.4]>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@mbligh.org> wrote:
>
> 
> 
> --Chris Wright <chrisw@osdl.org> wrote (on Sunday, August 07, 2005 16:44:11 -0700):
> 
> > * Martin J. Bligh (mbligh@mbligh.org) wrote:
> >> Starting on the work to merge xen cleanly as a subarch.
> >> Introduce make_pages_readonly and make_pages_writable where appropriate 
> >> for Xen, defined as a no-op on other subarches. Same for 
> > 
> > Maybe this is a bad name, since make_pages_readonly/writable has
> > intutitive meaning, and then is non-inutitively a no-op (for default).
> 
> You're welcome to suggest something else if you want, though it would
> have been easier if you'd done it the first time you saw this patch,
> not now. Going through this stuff multiple times is going to get very
> boring very fast.
> 
> xen_make_pages_readonly / xen_make_pages_writable ?
> 

Well we don't want to assume "xen" at this stage.  We're faced with a
choice at present: to make the linux->hypervisor interface be some
xen-specific and xen-controlled thing, or to make it a more formal and
controlled kernel interface which talks to a generic hypervisor rather than
assuming it's Xen down there.

As long as it doesn't hamper performance or general code sanity, I think it
would be better to make this a well-defined and controlled Linux interface.
Some of the code to do that is starting to accumulate in -mm.  Everyone
needs to sit down, take a look at the patches and the proposal and work out
if this is the way to proceed.

