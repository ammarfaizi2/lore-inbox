Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263840AbUEXCj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263840AbUEXCj5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 22:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263842AbUEXCj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 22:39:57 -0400
Received: from holomorphy.com ([207.189.100.168]:33670 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263840AbUEXCj4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 22:39:56 -0400
Date: Sun, 23 May 2004 19:39:52 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Phy Prabab <phyprabab@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: 4g/4g for 2.6.6
Message-ID: <20040524023952.GL1833@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Phy Prabab <phyprabab@yahoo.com>, linux-kernel@vger.kernel.org
References: <20040523194302.81454.qmail@web90007.mail.scd.yahoo.com> <Pine.LNX.4.58.0405231329460.25502@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405231329460.25502@ppc970.osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2004 at 01:32:19PM -0700, Linus Torvalds wrote:
> Quite frankly, a number of us are hoping that we can make them
> unnecessary. The cost of the 4g/4g split is absolutely _huge_ on some
> things, including basic stuff like kernel compiles.
> The only valid reason for the 4g split is that the VM doesn't always 
> behave well with huge amounts of highmem. The anonvma stuff in 2.6.7-pre1 
> is hoped to make that much less of an issue.
> Personally, if we never need to merge 4g for real, I'll be really really 
> happy. I see it as a huge ugly hack.

The performance can be improved by using a u area to store and map
things like vmas, kernel stacks, pagetables, file handles and
descriptor tables, and the like with supervisor privileges in the same
set of pagetables as the user context so that system calls may be
serviced without referencing the larger global kernel data area, which
would require the %cr3 reload. This does, however, seem at odds with
Linux' design in a number of respects, e.g. vmas etc. are on lists
containing elements belonging to different contexts. I suspect kernels
doing this would have to architect their page replacement algorithms
and truncate() semantics so as to avoid these out-of-context accesses
or otherwise suffer these operations being inefficient.

-- wli
