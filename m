Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbTJCW4p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 18:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbTJCW4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 18:56:45 -0400
Received: from users.ccur.com ([208.248.32.211]:7786 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id S261518AbTJCW4n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 18:56:43 -0400
Date: Fri, 3 Oct 2003 18:55:09 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, riel@redhat.com, andrea@suse.de
Subject: Re: mlockall and mmap of IO devices don't mix
Message-ID: <20031003225509.GA26590@rudolph.ccur.com>
References: <20031003214411.GA25802@rudolph.ccur.com> <20031003152349.7194b73d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031003152349.7194b73d.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 03, 2003 at 03:23:49PM -0700, Andrew Morton wrote:
> Joe Korty <joe.korty@ccur.com> wrote:
> >
> > 2.6.0-test6: the use of mlockall(2) in a process that has mmap(2)ed
> > the registers of an IO device will hang that process uninterruptibly.
> > The task runs in an infinite loop in get_user_pages(), invoking
> > follow_page() forever.
> 
> whoops.
> 
> I think the right fix is in get_user_pages(): if the region is VM_IO then
> don't call follow_page() at all.
> 
> Something like this?


Sigh.  No go; it *looks* good but my app still locks up....

Regards,
Joe
