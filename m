Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318936AbSHMF3m>; Tue, 13 Aug 2002 01:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318937AbSHMF3m>; Tue, 13 Aug 2002 01:29:42 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:45258 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318936AbSHMF3l>; Tue, 13 Aug 2002 01:29:41 -0400
Date: Tue, 13 Aug 2002 11:07:25 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Christoph Hellwig <hch@infradead.org>,
       Ravikiran G Thirumalai <kiran@in.ibm.com>,
       Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [patch 1 of 2] Scalable statistics counters
Message-ID: <20020813110725.A10332@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20020812183524.B1992@in.ibm.com> <20020812144605.A4595@infradead.org> <20020813013546.A7819@in.ibm.com> <20020812210952.A17329@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020812210952.A17329@infradead.org>; from hch@infradead.org on Mon, Aug 12, 2002 at 09:09:52PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2002 at 09:09:52PM +0100, Christoph Hellwig wrote:
> On Tue, Aug 13, 2002 at 01:35:46AM +0530, Dipankar Sarma wrote:
> > Suppose I use seq_file interface and not put all statctrs in one /proc
> > file, how do I associate the statctr data structure with the /proc
> > inode ? IOW, how do I quickly get the statctr_pentry corresponding to the
> > counter in statctr_open() ?
> 
> Stuff it into the ->private member of struct seq_file in your open method.

Yes, that I learnt by looking at mounts_open(), the problem is how
do I get the statctr_pentry (or statctr_group if you like) in
the open method ? It seems to me that in order to do this, we
need the following -

1. An exported wrapper create_statctr_entry() around 
   create_seq_entry() code that sticks the statctr_group pointer into
   proc_entry->data.
2. Some way to get the proc entry from the inode in statctr_open()
   and stick it to seq_file->private for seq_file methods to use.

Is this understanding correct or is there a better and simpler
way to do this ?

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
