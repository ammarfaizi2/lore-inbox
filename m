Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262865AbTDVDkB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 23:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262872AbTDVDkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 23:40:01 -0400
Received: from [12.47.58.203] ([12.47.58.203]:22947 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262865AbTDVDkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 23:40:00 -0400
Date: Mon, 21 Apr 2003 20:52:31 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 67-mjb2 vs 68-mjb1 (sdet degredation)
Message-Id: <20030421205231.4392aaa7.akpm@digeo.com>
In-Reply-To: <147950000.1050981750@[10.10.2.4]>
References: <1425480000.1050959528@flay>
	<20030421144631.4987db46.akpm@digeo.com>
	<147950000.1050981750@[10.10.2.4]>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Apr 2003 03:51:57.0835 (UTC) FILETIME=[85B295B0:01C30882]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> > Here's a backout patch.  Does it fix it up?
> 
> Yeah, that fixes it. Ho hum ... I wonder if we can find something that
> works well for both cases? I guess the options would be:
> 
> 1. Some way to make the rwlock mechanism itself faster.
> 2. Try to fix the contention itself somehow for this instance.

You're using PIII's, which don't mind the additional buslocked operation. 
P4's hate it.  We'd need to retest on big P4 and other architectures to
decide.

I suspect the spinlock is better that the rwlock overall - having multiple
CPUs looking up things in the same address_space is relatively uncommon. 
Having one CPU looking things up in one address space is very common, and
that's the thing which the s/rwlock/spinlock/ speeds up.

