Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264324AbUDOPnd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 11:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264328AbUDOPnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 11:43:33 -0400
Received: from mail.cyclades.com ([64.186.161.6]:35014 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S264324AbUDOPna
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 11:43:30 -0400
Date: Thu, 15 Apr 2004 12:16:36 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shrink hash sizes on small machines, take 2
Message-ID: <20040415151635.GG2085@logos.cnet>
References: <20040410232707.GU6248@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040410232707.GU6248@waste.org>
User-Agent: Mutt/1.5.5.1i
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2004 at 06:27:07PM -0500, Matt Mackall wrote:
> The following attempts to cleanly address the low end of the problem,
> something like my calc_hash_order or Marcelo's approach should be used
> to attack the upper end of the problem.
> 
> 8<
> 
> Shrink hashes on small systems
> 
> Base hash sizes on available memory rather than total memory. An
> additional 50% above current used memory is considered reserved for
> the purposes of hash sizing to compensate for the hashes themselves
> and the remainder of kernel and userspace initialization.

Hi Matt, 

As far as I remember from my tests booting with 8MB yields 0-order (one page) 
dentry/inode hash tables, and 16MB yields 
1-order dentry/0-order inode hash. 

So we can't go lower than 1 page on <8MB anyway (and we dont). What 
is the problem you are seeing ?

Your patch changes 16MB to 0-order dentry hashtable?

On the higher end, we still need to figure out if the "huge"
hash tables (1MB dentry/512K inode on 4GB box, upto 8MB hash dentry 
on 16GB box) are really worth it. 

Arjan seems to be clipping the dentry to 128K on RH's kernels. 
I couldnt find much of a difference on dbench performance from 1MB to 512K 
or 128K dhash. Someone willing to help with SDET or different tests?

Thanks!
