Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264278AbUGFVgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264278AbUGFVgM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 17:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264571AbUGFVgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 17:36:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:65495 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264278AbUGFVgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 17:36:08 -0400
Date: Tue, 6 Jul 2004 22:35:52 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Kevin Corry <kevcorry@us.ibm.com>, linux-kernel@vger.kernel.org,
       dm-devel@redhat.com, torvalds@osdl.org, agk@redhat.com,
       jim.houston@comcast.net
Subject: Re: [PATCH] 1/1: Device-Mapper: Remove 1024 devices limitation
Message-ID: <20040706213552.GA30237@agk.surrey.redhat.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Kevin Corry <kevcorry@us.ibm.com>, linux-kernel@vger.kernel.org,
	dm-devel@redhat.com, torvalds@osdl.org, agk@redhat.com,
	jim.houston@comcast.net
References: <200407011035.13283.kevcorry@us.ibm.com> <200407021233.09610.kevcorry@us.ibm.com> <20040702124218.0ad27a85.akpm@osdl.org> <200407061323.27066.kevcorry@us.ibm.com> <20040706142335.14efcfa4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040706142335.14efcfa4.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2004 at 02:23:35PM -0700, Andrew Morton wrote:
> Kevin Corry <kevcorry@us.ibm.com> wrote:

> > It seems (based on some comments in lib/idr.c) that
 
> Confused.  idr_find() returns the thing it found, or NULL.  

Yes, but the comments imply that the thing it found might in some
circumstances not be the thing you asked it to look for (if there've 
been deletions) and it's the caller's responsibility to verify
what's returned.

> To which comments do you refer?

lib/idr.c:30

 * What you need to do is, since we don't keep the counter as part of
 * id / ptr pair, to keep a copy of it in the pointed to structure
 * (or else where) so that when you ask for a ptr you can varify that
 * the returned ptr is correct by comparing the id it contains with the one
 * you asked for.  In other words, we only did half the reuse protection.
 * Since the code depends on your code doing this check, we ignore high
 * order bits in the id, not just the count, but bits that would, if used,
 * index outside of the allocated ids.  In other words, if the largest id
 * currently allocated is 32 a look up will only look at the low 5 bits of
 * the id.  Since you will want to keep this id in the structure anyway
 * (if for no other reason than to be able to eliminate the id when the
 * structure is found in some other way) this seems reasonable.  If you
 * really think otherwise, the code to check these bits here, it is just
 * disabled with a #if 0.

Alasdair
-- 
agk@redhat.com
