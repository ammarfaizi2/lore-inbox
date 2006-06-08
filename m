Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932499AbWFHFBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbWFHFBc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 01:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWFHFBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 01:01:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7405 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751228AbWFHFBb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 01:01:31 -0400
Date: Wed, 7 Jun 2006 22:01:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: adilger@clusterfs.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use unlikely() for current_kernel_time() loop
Message-Id: <20060607220118.f0c64086.akpm@osdl.org>
In-Reply-To: <p73ejy0tm83.fsf@verdi.suse.de>
References: <20060607173642.GA6378@schatzie.adilger.int>
	<p73ejy0tm83.fsf@verdi.suse.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08 Jun 2006 04:28:12 +0200
Andi Kleen <ak@suse.de> wrote:

> Andreas Dilger <adilger@clusterfs.com> writes:
> 
> > Hello,
> > I just noticed this minor optimization.  current_kernel_time() is called
> > from current_fs_time() so it is used fairly often but it doesn't use
> > unlikely(read_seqretry(&xtime_lock, seq)) as other users of xtime_lock do.
> > Also removes extra whitespace on the empty line above.
> 
> It would be better to put the unlikely into the read_seqretry I guess.
> 

yup.  But it'd be good to check that this actually causes the compiler to
do the right thing, rather than simply ignoring it.

I'm not sure how one would do that though.  I guess compare
before-and-after assembly code, work out if "after" is better.

