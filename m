Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264970AbTFLThe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 15:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264968AbTFLTgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 15:36:50 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:44486 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264965AbTFLTgc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 15:36:32 -0400
Date: Fri, 13 Jun 2003 01:23:02 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: John M Flinchbaugh <glynis@butterfly.hjsoft.com>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: 2.5.70-bk16: nfs crash
Message-ID: <20030612195302.GH1438@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20030612125630.GA19842@butterfly.hjsoft.com> <20030612135254.GA2482@in.ibm.com> <16104.40370.828325.379995@charged.uio.no> <20030612155345.GB1438@in.ibm.com> <16104.43445.918001.683257@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16104.43445.918001.683257@charged.uio.no>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 09:26:29AM -0700, Trond Myklebust wrote:
> I still need a real fix for d_move(). In addition, I'm getting worried

Linus' fix allowing unhashed src dentries seems ok, if that is what
you are looking for.


> about the changes in functionality that you've introduced here. It
> seems to me that your lockless scheme opens for a *lot* of races:
> 
> Look at all those functions that take dcache_lock, and then test
> dentry->d_count. Unless I'm missing something here, your d_lookup()
> clearly has them all screwed, no?

Not necessarily. One example is the fact that d_lookup() can
only increase d_count. Besides, dput() decrements d_count
without dcache_lock, so I am not sure holding dcache_lock during
d_count test buys you much.

We will do some audit tomorrow and see if there are issues here.

Thanks
Dipankar
