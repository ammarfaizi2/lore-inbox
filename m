Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264895AbTFLQVO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 12:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264887AbTFLQTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 12:19:12 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:13776 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264884AbTFLQS7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 12:18:59 -0400
Date: Thu, 12 Jun 2003 22:05:27 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: John M Flinchbaugh <glynis@butterfly.hjsoft.com>,
       linux-kernel@vger.kernel.org,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Maneesh Soni <maneesh@in.ibm.com>, Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.70-bk16: nfs crash
Message-ID: <20030612163527.GD1438@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <Pine.LNX.4.44.0306120847540.2742-100000@home.transmeta.com> <Pine.LNX.4.44.0306120915190.2742-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306120915190.2742-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 09:18:11AM -0700, Linus Torvalds wrote:
> 
> On Thu, 12 Jun 2003, Linus Torvalds wrote:
> > 
> > If you depend on not re-initializing the pointers, you should not use the 
> > "xxx_del()" function, and you should document it.
> 
> Besides, the code doesn't actually depend on not re-initializing the 
> pointers, it depends on the _forward_ pointers still being walkable in 
> case some other CPU is traversing the list just as we remove the entry.
> 
> Which means that I think the proper patch is to (a) document this and also
> (b) poison the back pointer.

That should work. However, I do have once concern. At the generic
list macro level, we don't know if the lockfree traversal is being
done in forward or backward direction. So, I am not sure if
list_del_rcu() should poison the backward pointer or atleast
document the fact that RCU-based traversal would not work on
backward pointers. hlist_del_rcu() can indeed poison pprev. 


> 
> A patch like the attached, in short.

Since we are at it, I can submit a patch documenting the rest of
hlist functions, if you like.

Thanks
Dipankar
