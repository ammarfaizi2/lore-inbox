Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262055AbVFHAtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbVFHAtR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 20:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbVFHAtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 20:49:16 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:19819 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262055AbVFHAtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 20:49:11 -0400
Subject: Re: [PATCH 2.6.12-rc6-mm1] add allowed CPUs check into
	find_idlest_{group|cpu}()
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: "M.Baris Demiray" <baris@labristeknoloji.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <42A66485.8010208@labristeknoloji.com>
References: <42A66485.8010208@labristeknoloji.com>
Content-Type: text/plain
Date: Wed, 08 Jun 2005 10:49:04 +1000
Message-Id: <1118191744.5104.49.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-08 at 03:22 +0000, M.Baris Demiray wrote:
> Hello Nick,
> a new patch related with recent thread is appended.
> 

Hi,

> I check for CPUs only, ie. not for intersection, in find_idlest_cpu()
> since there should be one-to-one comparison when finding CPU. But I
> take intersection of group's CPUs and current task's allowed CPUs in
> find_allowed_group(). Comments?
> 

Getting better. Thanks.

By taking the intersection in find_idlest_cpu, I don't mean checking
whether or not they intersect as in find_idlest_group. I mean doing
this:


    cpumask_t tmp;

    /* Find the intersection */
    cpus_and(tmp, group->cpumask, p->cpus_allowed);

    for_each_cpu_mask(i, tmp) {

Right? That is effectively the same as what you've got in your patch,
but it means we don't need to do the cpumask comparison every time
around the loop (aside from being an extra branch, the actual operation
itself gets a little costly with huge cpu masks).

Nick

-- 
SUSE Labs, Novell Inc.



Send instant messages to your online friends http://au.messenger.yahoo.com 
