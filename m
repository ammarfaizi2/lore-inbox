Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262078AbUKKBps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbUKKBps (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 20:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbUKKBps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 20:45:48 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:64964 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262078AbUKKBpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 20:45:41 -0500
Subject: Re: Broken kunmap calls in rc4-mm1.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041111012919.GD3217@holomorphy.com>
References: <1100135825.7402.32.camel@desktop.cunninghams>
	 <20041111012919.GD3217@holomorphy.com>
Content-Type: text/plain
Message-Id: <1100137328.7402.45.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 11 Nov 2004 12:42:08 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-11-11 at 12:29, William Lee Irwin III wrote:
> On Thu, Nov 11, 2004 at 12:17:05PM +1100, Nigel Cunningham wrote:
> > That oops in kunmap got me thinking of my recent DEBUG_HIGHMEM
> > additions, so I want for a walk through the -mm4 patch, and found plenty
> > of instances of people making the same mistake I did... using the struct
> > page * in the call to kunmap, rather than the virtual address.
> > I guess the best way to handle it is find/notify the respective authors
> > of patches in the tree? The problems are in:
> > Reiser4 (lots)
> > CacheFS (lots)
> > afs
> > binfmt_elf
> > libata_core
> > (I'm hoping some of the above people will see this message and save me
> > some effort :>)
> 
> That only applies to kunmap_atomic(); kunmap()'s argument should be a page.

Ah. My bad. That cuts it down by quite a few. I should have stuck to
looking for kmap_atomic :>

Humble apologies to those wrongly maligned!

Remaining culprits are....

Reiser4:
- do_readpage_tail
 -reiser4_status_init
 -reiser4_status_write

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

