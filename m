Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261531AbSJUTGP>; Mon, 21 Oct 2002 15:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261555AbSJUTGP>; Mon, 21 Oct 2002 15:06:15 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:24489 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261531AbSJUTGO>;
	Mon, 21 Oct 2002 15:06:14 -0400
Date: Tue, 22 Oct 2002 00:48:06 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: mingming cao <cmm@us.ibm.com>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]IPC locks breaking down with RCU
Message-ID: <20021022004806.A10573@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <Pine.LNX.4.44.0210201809490.2106-100000@localhost.localdomain> <3DB44343.701B7EFD@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DB44343.701B7EFD@us.ibm.com>; from cmm@us.ibm.com on Mon, Oct 21, 2002 at 11:11:15AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2002 at 11:11:15AM -0700, mingming cao wrote:
> A simple solution I could think of for this problem, moving the per_id
> lock out of the kern_ipc_perm structure, and put it in the ipc_id
> structure. Actually I did this way at the first time,  then I agreed
> with you that moving the per_id lock into there kern_ipc_perm structure
> will help reduce cacheline bouncing.  
> 
> I think that having the per_id lock stay out of the structure it
> protects will easy the job of ipc_rmid(), also will avoid the wrong
> preempt count problem caused by the additional check "if (out)" in
> ipc_unlock() as you mentioned above.

I took a quick look at the original ipc code and I don't understand
something - it seems to me the ipc_ids structs are protected by the semaphore
inside for all operations, so why do we need the spinlock in the
first place ? Am I missing something here ?

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
