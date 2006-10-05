Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbWJEAHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWJEAHQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 20:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWJEAHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 20:07:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13251 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751246AbWJEAHN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 20:07:13 -0400
Date: Wed, 4 Oct 2006 17:06:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steve Fox <drfickle@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Andi Kleen <ak@suse.de>, Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: 2.6.18-mm2 boot failure on x86-64
Message-Id: <20061004170659.f3b089a8.akpm@osdl.org>
In-Reply-To: <1159980119.28106.75.camel@flooterbu>
References: <20060928014623.ccc9b885.akpm@osdl.org>
	<efh217$8au$1@sea.gmane.org>
	<20060928140124.5f7154e3.akpm@osdl.org>
	<1159969349.28106.64.camel@flooterbu>
	<20061004084540.af17fee5.akpm@osdl.org>
	<1159980119.28106.75.camel@flooterbu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Oct 2006 11:41:59 -0500
Steve Fox <drfickle@us.ibm.com> wrote:

> On Wed, 2006-10-04 at 08:45 -0700, Andrew Morton wrote:
> > On Wed, 04 Oct 2006 08:42:28 -0500
> > Steve Fox <drfickle@us.ibm.com> wrote:
> > > Sorry for the delay. I was finally able to perform a bisect on this. It
> > > turns out the patch that causes this is
> > > x86_64-mm-re-positioning-the-bss-segment.patch, which seems like a
> > > strange candidate, but sure enough I can boot to login: right up until
> > > that patch is applied.
> > 
> > hm, that patch was merged into mainline September 29.  Does mainline work?
> 
> -git21 also fails with this same error.
> 

OK, thanks.  And we know that
x86_64-mm-re-positioning-the-bss-segment.patch triggered this failure.  And
that patch is non-buggy, and the xfrm code is probably non-buggy.  So we don't
know squat, and we're going to need to debug this crash.

Well.  There is one trick we could use: apply
x86_64-mm-re-positioning-the-bss-segment.patch to 2.6.18 base and see if it
crashes.  If it doesn't, then we can theorise that the bug is some buggy
post 2.6.18 patch which is being exposed by
x86_64-mm-re-positioning-the-bss-segment.patch.  A technique I've used
before for identifying the buggy patch is to do a git-bisect, but apply
x86_64-mm-re-positioning-the-bss-segment.patch by hand at each bisection
step.  It's pretty straightforward as long as the patch roughly applies at
each step.  

Or we could debug it.  Can you send the .config?  Let's see if it happens
with my toolchain+machine first.

Thanks.
