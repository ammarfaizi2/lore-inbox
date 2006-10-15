Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbWJOWCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbWJOWCa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 18:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWJOWCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 18:02:30 -0400
Received: from h8922032063.dsl.speedlinq.nl ([89.220.32.63]:58070 "EHLO
	jumbo.lan") by vger.kernel.org with ESMTP id S1751225AbWJOWC3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 18:02:29 -0400
Date: Sun, 15 Oct 2006 23:58:55 +0200
From: "Dennis J.A. Bijwaard" <dennis@h8922032063.dsl.speedlinq.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: bijwaard@gmail.com,
       "Dennis J.A. Bijwaard" <dennis@h8922032063.dsl.speedlinq.nl>,
       sct@redhat.com, adilger@clusterfs.com, linux-kernel@vger.kernel.org
Subject: Re: BUG: soft lockup detected on CPU#0! in sys_close and ext3
Message-ID: <20061015215854.GA12890@jumbo.lan>
References: <20061015175640.GA3673@jumbo.lan> <20061015121202.378bdd41.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061015121202.378bdd41.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Thanks for your reply. The machine has 512MB and some more swap:

Mem:    510960k total,   504876k used,     6084k free,     1868k buffers
Swap:   674640k total,     2652k used,   671988k free,   354832k cached

Machine may be slow for current standards, it has 2 * 500Mhz

Kind regards,
                Dennis

* Andrew Morton <akpm@osdl.org> [061015 21:13]:
> On Sun, 15 Oct 2006 19:56:40 +0200
> "Dennis J.A. Bijwaard" <dennis@h8922032063.dsl.speedlinq.nl> wrote:
> 
> > I got two soft lockups on one of the CPUs just now. I'm unsure if this
> > problem is in ext3, sys_close, or general kernel, so I've CC'd the
> > kernel list.
> > 
> > [1.] One line summary of the problem:
> > 
> > BUG: soft lockup detected on CPU#0! in sys_close/fput and ext3 journaling
> 
> Both warnings occurred when the kernel was tearing down large amounts of
> pagecache via invalidate_inode_pages().  One instances was a blockdev
> (probably the final close on the dvd) and the other was a regular file
> (perhaps a large dvd image?)
> 
> The CPU is slow: 500MHz pIII.  How much memory does it have?
> 
> So the kernel was doing a lot of work, on a slow CPU.  Perhaps that simply
> exceeded the softlockup timeout.  If that's true then the machine should
> have recovered.  Once it did, and once it didn't.  I don't know why it
> didn't.
> 
