Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318331AbSGYAPG>; Wed, 24 Jul 2002 20:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318332AbSGYAPG>; Wed, 24 Jul 2002 20:15:06 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:47609 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318331AbSGYAPF>; Wed, 24 Jul 2002 20:15:05 -0400
Subject: Re: [PATCH] VM accounting 1/3 trivial
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hugh Dickins <hugh@veritas.com>
Cc: Robert Love <rml@tech9.net>, David Mosberger <davidm@hpl.hp.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0207241453420.1159-100000@localhost.localdomain>
References: <Pine.LNX.4.21.0207241453420.1159-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 25 Jul 2002 02:31:54 +0100
Message-Id: <1027560714.6456.43.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-24 at 15:48, Hugh Dickins wrote:
> Thank you, it is surely incorrect (in the case where the do_munmap does
> not cover the whole vma, leaving one or two pieces behind: I think that
> must be the case you're remembering).  Would a patch which (if necessary)
> reapplies VM_ACCOUNT to the leftover piece(s) be welcome, or would it
> just look like an ugly face-saving exercise?

I went around this about five times before changing do_munmap having
failed dismally on each case. I wouldnt worry about face saving, I made
the same mistake and spent a couple of days debugging it.

> But I'll still have a consistency problem with MAP_NORESERVE versus
> sysctl_overcommit_memory, when the latter is changed (> 1 or <= 1).

Its very simple. If you have said "no overcommit" you cannot allow
anyone to violate the rule because any reservation could cause someone
who didnt NORESERVE to get killed off.

Secondly on my test runs, no process on a standard distro seems to use
NORESERVE anyway 8)

