Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264870AbTFLPwp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 11:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264871AbTFLPwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 11:52:44 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:54217 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264870AbTFLPwn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 11:52:43 -0400
Date: Thu, 12 Jun 2003 21:35:57 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: John M Flinchbaugh <glynis@butterfly.hjsoft.com>,
       linux-kernel@vger.kernel.org,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: 2.5.70-bk16: nfs crash
Message-ID: <20030612160557.GC1438@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20030612135254.GA2482@in.ibm.com> <Pine.LNX.4.44.0306120847540.2742-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306120847540.2742-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 08:49:53AM -0700, Linus Torvalds wrote:
> On Thu, 12 Jun 2003, Dipankar Sarma wrote:
> > 
> > hlist poison patch is broken. list_del_rcu() and hlist_del_rcu() 
> > *must not* re-initialize the pointers. Maneesh submitted a patch
> > earlier today that corrects this -
> 
> Sorry, but you're wrong.
> 
> If you depend on not re-initializing the pointers, you should not use the 
> "xxx_del()" function, and you should document it.

Right. That is why they are list_del_rcu() and hlist_del_rcu().
The comments for list_del_rcu() clearly say that pointers
are not re-initialized.

> 
> This is that the __xxx_del() functions are there for - they won't do the
> poisoning. The regular delete functions have historically always poisoned
> the pointers - it was only removed a few months ago by Andrew.

Poisoning xxx_del() functions is ok. That should be done.

Thanks
Dipankar
