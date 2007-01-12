Return-Path: <linux-kernel-owner+w=401wt.eu-S932119AbXALPkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbXALPkB (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 10:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbXALPkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 10:40:01 -0500
Received: from mtagate6.de.ibm.com ([195.212.29.155]:14068 "EHLO
	mtagate6.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932119AbXALPkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 10:40:00 -0500
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH/RFC 2.6.21 3/5] ehca: completion queue: remove use of do_mmap()
Date: Fri, 12 Jan 2007 16:36:15 +0100
User-Agent: KMail/1.8.2
Cc: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, openfabrics-ewg@openib.org,
       openib-general@openib.org, raisch@de.ibm.com
References: <200701112008.37236.hnguyen@linux.vnet.ibm.com> <20070111192056.GB24623@infradead.org>
In-Reply-To: <20070111192056.GB24623@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701121636.15989.hnguyen@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
> > +		if (my_cq->ownpid != cur_pid) {
> > +			ehca_err(device, "Invalid caller pid=%x ownpid=%x "
> > +				 "cq_num=%x",
> > +				 cur_pid, my_cq->ownpid, my_cq->cq_number);
> > +			return -EINVAL;
> > +		}
> 
> (for other reviewers: this is not new code, just moved around)
> 
> Owner tracking by pid is really dangerous.  File descriptors can be
> passed around by unix sockets, a single process can have files open
> more than once, etc..
> 
> It seems ehca wants to prevent threads other than the creating one
> from performing most operations.  Can you explain the reason for this?
you point to the right spot... This has a historic reason as we
have needed to support fork(), system("date") etc for kernel 2.6.9, 
hence those vma flags manipulation and this pid checking as proactive
protection/restriction. For newer kernel, I guess >=2.6.12, this checking
were not necessary, but we would feel better after we had tested user 
space stuff more thoroughly without this piece of code. Since this is 
not new code, can we pls handle this later?
Regards
Nam
