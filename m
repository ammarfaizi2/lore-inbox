Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753175AbVHHA74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175AbVHHA74 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 20:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753176AbVHHA7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 20:59:55 -0400
Received: from dvhart.com ([64.146.134.43]:1921 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1753175AbVHHA7z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 20:59:55 -0400
Date: Sun, 07 Aug 2005 17:59:59 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>
Cc: chrisw@osdl.org, linux-kernel@vger.kernel.org,
       Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH] abstract out bits of ldt.c
Message-ID: <380250000.1123462799@[10.10.2.4]>
In-Reply-To: <20050807174129.20c7202f.akpm@osdl.org>
References: <372830000.1123456808@[10.10.2.4]><20050807234411.GE7991@shell0.pdx.osdl.net><374910000.1123459025@[10.10.2.4]> <20050807174129.20c7202f.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Andrew Morton <akpm@osdl.org> wrote (on Sunday, August 07, 2005 17:41:29 -0700):

> "Martin J. Bligh" <mbligh@mbligh.org> wrote:
>> 
>> 
>> 
>> --Chris Wright <chrisw@osdl.org> wrote (on Sunday, August 07, 2005 16:44:11 -0700):
>> 
>> > * Martin J. Bligh (mbligh@mbligh.org) wrote:
>> >> Starting on the work to merge xen cleanly as a subarch.
>> >> Introduce make_pages_readonly and make_pages_writable where appropriate 
>> >> for Xen, defined as a no-op on other subarches. Same for 
>> > 
>> > Maybe this is a bad name, since make_pages_readonly/writable has
>> > intutitive meaning, and then is non-inutitively a no-op (for default).
>> 
>> You're welcome to suggest something else if you want, though it would
>> have been easier if you'd done it the first time you saw this patch,
>> not now. Going through this stuff multiple times is going to get very
>> boring very fast.
>> 
>> xen_make_pages_readonly / xen_make_pages_writable ?
>> 
> 
> Well we don't want to assume "xen" at this stage.  We're faced with a
> choice at present: to make the linux->hypervisor interface be some
> xen-specific and xen-controlled thing, or to make it a more formal and
> controlled kernel interface which talks to a generic hypervisor rather than
> assuming it's Xen down there.

Yes, more generic than xen would be better. I think mach-xen is probably
OK for now, but I agree we should avoid wedging xen_* in generic code
callouts. What I'm trying to do right now is rip the whole duplicated
files out of the xen patches.

> As long as it doesn't hamper performance or general code sanity, I think it
> would be better to make this a well-defined and controlled Linux interface.
> Some of the code to do that is starting to accumulate in -mm.  Everyone
> needs to sit down, take a look at the patches and the proposal and work out
> if this is the way to proceed.

We're faced with a difficult choice - the xen patches are hard to read
without refactoring them. On the other hand it's going to be very painful
to keep them in sync out of tree whilst doing the refactoring. I'd prefer
to merge up some bits as we go, though maybe I should keep those more
neutral than this. Sigh ... this is going to be extremely painful whatever
we do.

M.
