Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262086AbUKPSah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbUKPSah (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 13:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262082AbUKPS2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 13:28:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45262 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262074AbUKPS10 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 13:27:26 -0500
Subject: Re: [2.6 patch] MTD: some cleanups
From: David Woodhouse <dwmw2@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20041112135322.GB7707@stusta.de>
References: <20041112135322.GB7707@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Red Hat UK Ltd.
Message-Id: <1100629567.8191.6993.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Tue, 16 Nov 2004 18:26:07 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-11-12 at 14:53 +0100, Adrian Bunk wrote:
> The patch below makes the following cleanups for code under drivers/mtd/ :
> - make some needlessly global code static

OK.

> - remove the following unused code:
>   - function ftl_freepart in drivers/mtd/ftl.c

It's a bug that we never free these. We should call the function
occasionally instead of deleting it.

>   - functions nettel_eraseconfig and nettel_erasecallback,
>    struct nettel_erase in drivers/mtd/maps/nettel.c

The nettel_eraseconfig() function isn't static -- I assume it was called
from the nettel-specific platform code.

>   - function physmap_set_partitions in drivers/mtd/maps/physmap.c

Again that's called from elsewhere.

-- 
dwmw2
