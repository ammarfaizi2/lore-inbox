Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbTEFGwr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 02:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbTEFGwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 02:52:47 -0400
Received: from pizda.ninka.net ([216.101.162.242]:20709 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262416AbTEFGwq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 02:52:46 -0400
Date: Mon, 05 May 2003 22:57:48 -0700 (PDT)
Message-Id: <20030505.225748.35026531.davem@redhat.com>
To: akpm@digeo.com
Cc: rusty@rustcorp.com.au, dipankar@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmalloc_percpu
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030505235549.5df75866.akpm@digeo.com>
References: <20030505224815.07e5240c.akpm@digeo.com>
	<20030505.223554.88485673.davem@redhat.com>
	<20030505235549.5df75866.akpm@digeo.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@digeo.com>
   Date: Mon, 5 May 2003 23:55:49 -0700

   How about we leave kmalloc_per_cpu as-is (it uses kmalloc()), and
   only apply Rusty's new code to DEFINE_PER_CPU?
   
I propose to make it use kmalloc() all the time.

It simply doesn't make sense to use a pool given what you've
shown me.  If we've decided that any limit whatsover is bad,
why impose any limit at all?  Smells like bad design frankly.

Normal DEFINE_PER_CPU() need not a pool, therefore we don't need
a pool for anything.

Make kmalloc_per_cpu() merely a convenience macro, made up of existing
non-percpu primitives.
