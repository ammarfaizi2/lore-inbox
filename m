Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264743AbTE1OMn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 10:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264744AbTE1OMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 10:12:43 -0400
Received: from uni01du.unity.ncsu.edu ([152.1.13.101]:23938 "EHLO
	uni01du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S264743AbTE1OMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 10:12:42 -0400
From: jlnance@unity.ncsu.edu
Date: Wed, 28 May 2003 10:14:59 -0400
To: linux-kernel@vger.kernel.org
Subject: Large process & 2.4.X
Message-ID: <20030528141459.GA7793@ncsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,
    I have found a set of instructions for compiling a kernel which
allows processes to access about an extra 500M of memory.  I need
this functionality since I run large processes which sometimes die
because they can not allocate more then 3G of memory.
    Before I go too far down this road, I want to bounce these
instructions off this list to make sure this is the best way to
get what I am after and also to see what the downsides are.

    What I am susposed to do is very simple:

1) Modify page.h such that __PAGE_OFFSET is changed from 0xC0000000 to
   0xE0000000.

2) Modify processor.h such that TASK_UNMAPPED_BASE is changed from
   (TASK_SIZE/3) to (TASK_SIZE/16)

3) Modify vmlinux.lds similar to step 1

Then the kernel is built with CONFIG_HIGHMEM4G=y (the machines have 4G of
ram).

The part that has me concerned is that I am not sure why I need to change
__PAGE_OFFSET if CONFIG_HIGHMEM4G is on.  I am not sure how these options
interact with each other.  Also, what am I loosing by making __PAGE_OFFSET
this large?  I believe that TASK_UNMAPPED_BASE is just moving the stack
around so that it does not get in the way of malloc().  Is this correct?

Thanks,

Jim
