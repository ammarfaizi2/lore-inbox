Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030580AbWJJWOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030580AbWJJWOg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 18:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030581AbWJJWOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 18:14:36 -0400
Received: from mail.impinj.com ([206.169.229.170]:15698 "EHLO earth.impinj.com")
	by vger.kernel.org with ESMTP id S1030580AbWJJWOf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 18:14:35 -0400
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Subject: Re: BUG in filp_close() (was: Re: 2.6.19-rc1-mm1)
Date: Tue, 10 Oct 2006 15:14:35 -0700
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20061010000928.9d2d519a.akpm@osdl.org> <1160495269.9864.18.camel@kleikamp.austin.ibm.com> <1160518024.28923.33.camel@kleikamp.austin.ibm.com>
In-Reply-To: <1160518024.28923.33.camel@kleikamp.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610101514.36161.vlobanov@speakeasy.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 October 2006 15:07, Dave Kleikamp wrote:
> Still don't know exactly what's going on here.  In case it helps, this
> is the call to dup2() from strace output:
>
> 1419  open("/dev/null", O_RDWR)         = 7
> 1419  getrlimit(RLIMIT_NOFILE, {rlim_cur=1024, rlim_max=1024}) = 0
> 1419  dup2(7, 524)                      = 524
> 1419  dup2(7, 525 <unfinished ...>

Thanks for the data point.

Hmmm... looks as if the likely sequence of events was:
create embedded fdtable
extend fdtable, allocate external data to handle fd = 524
try to extend fdtable again, crash.

Seems as if alloc_fdtable() or copy_fdtable() are to blame, but the code logic 
seems to be identical. Hmmmm.

-- Vadim Lobanov

