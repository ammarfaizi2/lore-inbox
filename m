Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265682AbUFRXXC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265682AbUFRXXC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 19:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265804AbUFRXSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 19:18:47 -0400
Received: from holomorphy.com ([207.189.100.168]:39818 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265791AbUFRXQi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 19:16:38 -0400
Date: Fri, 18 Jun 2004 16:16:31 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] flexible-mmap-2.6.7-D5
Message-ID: <20040618231631.GO1863@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
References: <20040618213814.GA589@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040618213814.GA589@elte.hu>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2004 at 11:38:14PM +0200, Ingo Molnar wrote:
> the flexible-mmap-2.6.7-D5 patch (attached) splits the flexible-mmap
> layout stuff out of exec-shield. The patch is against 2.6.7 + my latest
> NX patch. (i've attached the NX patch too, for convenience.)
> the goal of the patch is to change the way virtual memory is allocated,
> from:
>   0x08000000 ... binary image
>   0x08xxxxxx ... brk area, grows upwards
>   0x40000000 ... start of mmap, new mmaps go after old ones
>   0xbfxxxxxx ... stack
> to a more flexible top-down mmap() method:
> 
>   0x08000000 ... binary image
>   0x08xxxxxx ... brk area, grows upwards
>   0xbfxxxxxx ... _end_ of all mmaps, new mmaps go below old ones
>   0xbfyyyyyy ... stack

It may be useful to move STACK_TOP to 0x8040000 give the stack more head
room and fit small statically-linked executables into one pagetable page.
Otherwise the stack has very little headroom after the first mmap().


-- wli
