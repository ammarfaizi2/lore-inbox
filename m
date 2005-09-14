Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932575AbVINUVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932575AbVINUVa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 16:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932765AbVINUV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 16:21:29 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:26037 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932575AbVINUV2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 16:21:28 -0400
Date: Thu, 15 Sep 2005 01:45:50 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Subject: Re: [PATCH]: Brown paper bag in fs/file.c?
Message-ID: <20050914201550.GB6315@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20050914.113133.78024310.davem@davemloft.net> <20050914191842.GA6315@in.ibm.com> <20050914.125750.05416211.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050914.125750.05416211.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2005 at 12:57:50PM -0700, David S. Miller wrote:
> From: Dipankar Sarma <dipankar@in.ibm.com>
> Date: Thu, 15 Sep 2005 00:48:42 +0530
> 
> > __free_fdtable() is used only when the fdarray/fdset are vmalloced
> > (use of the workqueue) or there is a race between two expand_files().
> > That might be why we haven't seen this cause any explicit problem
> > so far.
> > 
> > This would be an appropriate patch - (untested). I will update
> > as soon as testing is done.
> 
> Thanks.
> 
> I still can't figure out what causes my sparc64 bug.  Somehow a
> kmalloc() chunk of file pointers gets freed too early, the SLAB is
> shrunk due to memory pressure so the page containing that object gets
> freed, that page ends up as an anonymous page in userspace, but filp
> writes from the older usage occurs and corrupts the page.
> 
> I wonder if we simply leave a stale pointer around to the older
> fd array in some case.

Are you running with preemption enabled ? If so, fyi, I had sent
out a patch earlier that fixes locking for preemption.
Also, what triggers this in your machine ? I can try to reproduce
this albeit on a non-sparc64 box.

Thanks
Dipankar
