Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbTEAE6k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 00:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262414AbTEAE6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 00:58:40 -0400
Received: from [12.47.58.20] ([12.47.58.20]:37018 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262406AbTEAE6X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 00:58:23 -0400
Date: Wed, 30 Apr 2003 22:11:29 -0700
From: Andrew Morton <akpm@digeo.com>
To: hugang <hugang@soulinfo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Faster generic_fls
Message-Id: <20030430221129.11595e2e.akpm@digeo.com>
In-Reply-To: <20030501130318.459a4776.hugang@soulinfo.com>
References: <200304300446.24330.dphillips@sistina.com>
	<20030430135512.6519eb53.akpm@digeo.com>
	<20030501130318.459a4776.hugang@soulinfo.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 May 2003 05:10:38.0400 (UTC) FILETIME=[01176400:01C30FA0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hugang <hugang@soulinfo.com> wrote:
>
> Here is table version of the fls. Yes it fast than other.

nooo..  That has a big cache footprint.  At the very least you should use
a binary search.  gcc will do it for you:

	switch (n) {
	case 0 ... 1:
		return 1;
	case 2 ... 3:
		return 2;
	case 4 ... 7:
		return 3;
	case 8 ... 15:
		return 4;

etc.


