Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265841AbTFSRD4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 13:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265844AbTFSRD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 13:03:56 -0400
Received: from rj.sgi.com ([192.82.208.96]:61872 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S265841AbTFSRDz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 13:03:55 -0400
Message-ID: <3EF1F050.2FBFA654@sgi.com>
Date: Thu, 19 Jun 2003 12:18:08 -0500
From: Ray Bryant <raybry@sgi.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Bug in __pollwait() can cause select() and poll() to hang 
 in   2.4.21
References: <3EF1D830.F12113D@sgi.com.suse.lists.linux.kernel> <p733ci65894.fsf@oldwotan.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> Nasty bug. How about adding a BUG() for current->state != TASK_RUNNING at
> the beginning of __alloc_pages unless GFP_ATOMIC is set?
> 
> -Andi

A good idea.  There may be other places like this that call into
__alloc_pages() with current->state != TASK_RUNNING.

However, this may break otherwise happily running kernels being used in
production today that are not in low memory situations.  Might it not be
better for me to run this in debug mode and see if we can find other
places where this is happening?  If I don't find any, then we can add
the BUG() as a way to avoid future introductions of this problem.

-- 
Best Regards,
Ray
-----------------------------------------------
                  Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
           so I installed Linux.
-----------------------------------------------
