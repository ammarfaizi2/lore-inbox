Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751346AbWHMRet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbWHMRet (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 13:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWHMRet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 13:34:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25315 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751346AbWHMRet (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 13:34:49 -0400
Date: Sun, 13 Aug 2006 10:34:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, pj@sgi.com,
       linux-kernel@vger.kernel.org, "Albert Cahalan" <acahalan@gmail.com>
Subject: Re: [RFC] ps command race fix
Message-Id: <20060813103434.17804d52.akpm@osdl.org>
In-Reply-To: <m1mza8wqdc.fsf@ebiederm.dsl.xmission.com>
References: <20060714203939.ddbc4918.kamezawa.hiroyu@jp.fujitsu.com>
	<20060724182000.2ab0364a.akpm@osdl.org>
	<20060724184847.3ff6be7d.pj@sgi.com>
	<20060725110835.59c13576.kamezawa.hiroyu@jp.fujitsu.com>
	<20060724193318.d57983c1.akpm@osdl.org>
	<20060725115004.a6c668ca.kamezawa.hiroyu@jp.fujitsu.com>
	<20060725121640.246a3720.kamezawa.hiroyu@jp.fujitsu.com>
	<m1mza8wqdc.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Aug 2006 10:29:51 -0600
ebiederm@xmission.com (Eric W. Biederman) wrote:

> So for systems that are going to be using a larger number of pid
> values I think we need a better data structure, and containers are
> likely to push us in that area.  Which means either an extensible
> hash table or radix tree look like the sane choices.

radix-trees are nice because you can efficiently traverse them in-order
while the contents are changing (albeit potentially missing newly-added
things, but that's inevitable).

radix-trees are not-nice because they allocate memory at insertion time. 
If that's a problem then rbtrees could perhaps be used.

idr-trees have similar characteristics to the radix-trees, except a) the
idr-tree find-next-above feature could perhaps be used for the core pid
allocation and b) idr-trees don't presently have suitable search functions
for performing the iteration.

At least we have plenty of choices ;)
