Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264595AbUETBFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264595AbUETBFn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 21:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264799AbUETBFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 21:05:43 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:47040 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264595AbUETBFl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 21:05:41 -0400
Subject: Re: [Ext2-devel] Re: question about ext3_find_goal with reservation
From: Mingming Cao <cmm@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: tytso@mit.edu, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
In-Reply-To: <20040519155249.76626220.akpm@osdl.org>
References: <E1BOQmf-0005cP-4Q@thunk.org>
	<20040513195310.5725fa43.akpm@osdl.org>
	<1085004276.15374.1318.camel@w-ming2.beaverton.ibm.com> 
	<20040519155249.76626220.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 May 2004 18:04:44 -0700
Message-Id: <1085015085.15395.1448.camel@w-ming2.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-05-19 at 15:52, Andrew Morton wrote:
> Mingming Cao <cmm@us.ibm.com> wrote:
> > If the pattern is random write, in the current implementation(with the
> > goal fix), the ext3_find_near() will find a goal with good locality.( I
> > have a hard time understand the ext3_find_near(), need some help
> > here...)
> 
> The comments in ext3_find_near() pretty well cover things.
Thanks.
> 
> > With reservation, we probably don't need ext3_find_near() to guide us to
> > find a goal block. But we still need that in the case the filesystem is
> > mounted without reservation on.
> 
> You might need it for the very first block allocation.  For example, if the
> app opens an existing file and starts appending to it, does the current
> code correctly commence allocation immediately beyond the file's final
> block?

Good point. I will check.
> 
> > If all above make sense, then the goal should be the start block of the
> > reservation window.
> 
> Well.  It'll be some block within the reservation window - the code should
> be recording how far across the reservation window we currently are.  We
> don't want to do a linear search across the entire reservation window for
> each block allocation attempt.
Currently we don't trace the last-allocated-block-from-reservation
window, but it's doable. It's kind of duplicated with the
i_next_alloc_goal

> It would be nice to separate the old allocation things (i_alloc_block,
> i_alloc_goal, etc) from the new code completely.  Making one somehow
> dependent upon or aware fo the other is confusing, and ultimately we'd like
> to remove those fields from the inode altogether.
> 
yes, it's nice to do so.  I will think about it.

