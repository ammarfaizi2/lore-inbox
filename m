Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264299AbUEIEhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264299AbUEIEhW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 00:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264271AbUEIEhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 00:37:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:60043 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264299AbUEIEhR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 00:37:17 -0400
Date: Sat, 8 May 2004 21:36:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: dipankar@in.ibm.com, manfred@colorfullife.com, davej@redhat.com,
       wli@holomorphy.com, linux-kernel@vger.kernel.org, maneesh@in.ibm.com
Subject: Re: dentry bloat.
Message-Id: <20040508213643.08e7ae80.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0405082120290.1592@ppc970.osdl.org>
References: <409B1511.6010500@colorfullife.com>
	<20040508012357.3559fb6e.akpm@osdl.org>
	<20040508022304.17779635.akpm@osdl.org>
	<20040508031159.782d6a46.akpm@osdl.org>
	<Pine.LNX.4.58.0405081019000.3271@ppc970.osdl.org>
	<20040508120148.1be96d66.akpm@osdl.org>
	<Pine.LNX.4.58.0405081208330.3271@ppc970.osdl.org>
	<Pine.LNX.4.58.0405081216510.3271@ppc970.osdl.org>
	<20040508204239.GB6383@in.ibm.com>
	<20040508135512.15f2bfec.akpm@osdl.org>
	<20040508211920.GD4007@in.ibm.com>
	<20040508171027.6e469f70.akpm@osdl.org>
	<Pine.LNX.4.58.0405081947290.1592@ppc970.osdl.org>
	<20040508211236.10481447.akpm@osdl.org>
	<Pine.LNX.4.58.0405082120290.1592@ppc970.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
>  > The calculation of DNAME_INLINE_LEN assumes that slab padded the dentry out
>  > to the next cacheline.
> 
>  No it doesn't. It's just:
> 
>  	#define DNAME_INLINE_LEN (sizeof(struct dentry)-offsetof(struct dentry,d_iname))
> 
>  which is always right. 

erk.  OK.  Things are (much) worse than I thought.  The 24 byte limit means
that 20% of my names will be externally allocated, but that's no worse than
what we had before.

We should make this change to 2.4.x.
