Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270133AbUJTACY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270133AbUJTACY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 20:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269872AbUJSXqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:46:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:60043 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270133AbUJSXAE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 19:00:04 -0400
Date: Tue, 19 Oct 2004 15:52:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alasdair G Kergon <agk@redhat.com>
Cc: blaisorblade_spam@yahoo.it, linux-kernel@vger.kernel.org,
       neilb@cse.unsw.edu.au
Subject: Re: [patch 1/1] dm: fix printk warnings about whether %lu/%Lu is
 right for sector_t
Message-Id: <20041019155258.75f35416.akpm@osdl.org>
In-Reply-To: <20041019174115.GC6408@agk.surrey.redhat.com>
References: <20041008144034.EB891B557@zion.localdomain>
	<20041008121239.464151bd.akpm@osdl.org>
	<20041019174115.GC6408@agk.surrey.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alasdair G Kergon <agk@redhat.com> wrote:
>
> On Fri, Oct 08, 2004 at 12:12:39PM -0700, Andrew Morton wrote:
>  > I would prefer that SECTOR_FORMAT be removed altogether.
>   
>  > The industry-standard way of printing a sector_t is:
>  > 	printk("%llu", (unsigned long long)sector);
>   
>  What about reading a sector_t with sscanf, which looks like the
>  reason for the existence of SECTOR_FORMAT?

I'm not sure that it has arisen.  I'd do:

	unsigned long long temp;
	sector_t sector;

	sscanf(buf, "%llu", &temp);
	sector = temp;

