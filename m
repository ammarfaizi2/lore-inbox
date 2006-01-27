Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422658AbWA0Wws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422658AbWA0Wws (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 17:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422660AbWA0Wwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 17:52:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24045 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422658AbWA0Wwb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 17:52:31 -0500
Date: Fri, 27 Jan 2006 14:54:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: dipankar@in.ibm.com, torvalds@osdl.org, paulmck@us.ibm.com,
       linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk,
       nickpiggin@yahoo.com.au, hch@infradead.org
Subject: Re: [patch 2/2] fix file counting
Message-Id: <20060127145412.7d23e004.akpm@osdl.org>
In-Reply-To: <43D92DD6.6090607@cosmosbay.com>
References: <20060126184010.GD4166@in.ibm.com>
	<20060126184127.GE4166@in.ibm.com>
	<20060126184233.GF4166@in.ibm.com>
	<43D92DD6.6090607@cosmosbay.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet <dada1@cosmosbay.com> wrote:
>
> > This patch changes the file counting by removing the filp_count_lock.
> > Instead we use a separate atomic_t, nr_files, for now and all
> > accesses to it are through get_nr_files() api. In the sysctl
> > handler for nr_files, we populate files_stat.nr_files before returning
> > to user.
> > 
> > Counting files as an when they are created and destroyed (as opposed
> > to inside slab) allows us to correctly count open files with RCU.
> > 
> > Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>
> > ---
> 
> Well...
> 
> I am using a patch that seems sligthly better : It removes the filp_count_lock 
> as yours but introduces a percpu variable, and a lazy nr_files . (Its value 
> can be off with a delta of +/- 16*num_possible_cpus()

Yes, I think that is better.
