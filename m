Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265151AbTFMFtz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 01:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265152AbTFMFtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 01:49:55 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:21440 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265151AbTFMFty (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 01:49:54 -0400
Date: Fri, 13 Jun 2003 11:36:32 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: John M Flinchbaugh <glynis@butterfly.hjsoft.com>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: 2.5.70-bk16: nfs crash
Message-ID: <20030613060632.GB1331@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20030612125630.GA19842@butterfly.hjsoft.com> <20030612135254.GA2482@in.ibm.com> <16104.40370.828325.379995@charged.uio.no> <20030612155345.GB1438@in.ibm.com> <16104.43445.918001.683257@charged.uio.no> <20030612195302.GH1438@in.ibm.com> <16105.24576.901270.856844@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16105.24576.901270.856844@charged.uio.no>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 10:24:16PM -0700, Trond Myklebust wrote:
> Wrong. Look at the VFS code. In all cases the test is of the form.
> 
>     spin_lock(&dcache_lock);
>     /* Are we the sole users of this dentry */
>     if (atomic_read(&dentry->d_count) == 1) {
>        /* Yes - do some operation */
>     }
> 
> 
> Knowing that d_lookup() can *increase* d_count is not a plus here. The
> whole idea is to have a test for sole use.

I missed this part. If you want to do this, I would suggest taking
the per-dentry lock instead. Most dcache routines have been fixed
to do this. We will look around and see anything violates this rule.

Thanks
Dipankar
