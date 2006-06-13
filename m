Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbWFMIsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWFMIsa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 04:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWFMIsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 04:48:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14016 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750791AbWFMIs3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 04:48:29 -0400
Date: Tue, 13 Jun 2006 04:48:19 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Sebastien Dugue <sebastien.dugue@bull.net>
Cc: Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-kernel@vger.kernel.org,
       Pierre PEIFFER <pierre.peiffer@bull.net>
Subject: Re: NPTL mutex and the scheduling priority
Message-ID: <20060613084819.GL3115@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20060612.171035.108739746.nemoto@toshiba-tops.co.jp> <1150115008.3131.106.camel@laptopd505.fenrus.org> <20060612124406.GZ3115@devserv.devel.redhat.com> <1150125869.3835.12.camel@frecb000686>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150125869.3835.12.camel@frecb000686>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2006 at 05:24:28PM +0200, S?bastien Dugu? wrote:
>   The patch you refer to is at
> http://marc.theaimsgroup.com/?l=linux-kernel&m=114725326712391&w=2
> 
>   But maybe a better solution for condvars would be to implement
> something like a futex_requeue_pi() to handle the broadcast and
> only use PI futexes all along in glibc.

FUTEX_REQUEUE certainly should be able to requeue from normal futex
to a PI futex or vice versa, I don't think it is desirable to create
a separate futex cmds for that.
Now not sure what do you mean by "use PI futexes all along in glibc",
certainly you don't mean using them for normal mutexes, right? 
FUTEX_LOCK_PI has effects the normal futexes shouldn't have.
The condvars can be also used with PP mutexes and using PI for the cv
internal lock unconditionally wouldn't be the right thing either.

	Jakub
