Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWA1TKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWA1TKv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 14:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbWA1TKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 14:10:51 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:51904 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750702AbWA1TKu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 14:10:50 -0500
Date: Sun, 29 Jan 2006 00:40:16 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: paulmck@us.ibm.com, dada1@cosmosbay.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk,
       nickpiggin@yahoo.com.au, hch@infradead.org
Subject: Re: [patch 2/2] fix file counting
Message-ID: <20060128191016.GG5633@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060126184010.GD4166@in.ibm.com> <20060126184127.GE4166@in.ibm.com> <20060126184233.GF4166@in.ibm.com> <43D92DD6.6090607@cosmosbay.com> <20060127145412.7d23e004.akpm@osdl.org> <20060127231420.GA10075@us.ibm.com> <20060127152857.32066a69.akpm@osdl.org> <20060128184245.GE5633@in.ibm.com> <20060128105108.1724e1cc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060128105108.1724e1cc.akpm@osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2006 at 10:51:08AM -0800, Andrew Morton wrote:
> Dipankar Sarma <dipankar@in.ibm.com> wrote:
> >
> >  > (And it forgot to initialise the atomic_t)
> > 
> >  I declared it static. Isn't that sufficient ?
> 
> ATOMIC_INIT(0);

OK, I will put an explicit initializer for that static variable.

> 
> >  > (And has a couple of suspicious-looking module exports.  We don't support
> >  > CONFIG_PROC_FS=m).
> > 
> >  Where ?
> 
> +EXPORT_SYMBOL(get_nr_files);
> +EXPORT_SYMBOL(get_max_files);
> 
> Why are these needed?

get_max_files() is needed by unix sockets which can be a module.
IIRC, xfs needed get_nr_files() when I originally wrote this patch. 
There doesn't seem to be any in-tree use now,
but files_stat was earlier exported and we should probably
mark this for unexport at a later time.

Thanks
Dipankar
