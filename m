Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932443AbWHHQJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbWHHQJu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 12:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbWHHQJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 12:09:50 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:35535 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932443AbWHHQJt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 12:09:49 -0400
Subject: Re: [PATCH] sys_getppid oopses on debug kernel (v2)
From: Dave Hansen <haveblue@us.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       alan@lxorguk.ukuu.org.uk, muli@il.ibm.com, B.Steinbrink@gmx.de,
       stable@kernel.org
In-Reply-To: <44D8B2C5.1080905@sw.ru>
References: <44D8B2C5.1080905@sw.ru>
Content-Type: text/plain
Date: Tue, 08 Aug 2006 09:09:21 -0700
Message-Id: <1155053361.19249.60.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-08 at 19:50 +0400, Kirill Korotaev wrote:
> sys_getppid() optimization can access a freed memory.
> On kernels with DEBUG_SLAB turned ON, this results in Oops.
> As Dave Hansen noted, this optimization is also unsafe
> for memory hotplug. 

Yeah, I just tried coding up something to do a seqlock to note when
tasks are freed, but it doesn't work.  Unless somebody is really going
crazy with getppid() on a very large system, this should be just fine.

-- Dave


