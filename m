Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262213AbUFJSNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbUFJSNP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 14:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbUFJSNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 14:13:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:37087 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262213AbUFJSNL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 14:13:11 -0400
Date: Thu, 10 Jun 2004 11:12:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kevin Corry <kevcorry@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, agk@redhat.com
Subject: Re: [PATCH] 2/5: Device-mapper: kcopyd
Message-Id: <20040610111223.04a0c142.akpm@osdl.org>
In-Reply-To: <200406100816.18263.kevcorry@us.ibm.com>
References: <20040602154129.GO6302@agk.surrey.redhat.com>
	<20040609231805.029672aa.akpm@osdl.org>
	<200406100816.18263.kevcorry@us.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Corry <kevcorry@us.ibm.com> wrote:
>
>  On Thursday 10 June 2004 6:18 am, Andrew Morton wrote:
>  > Alasdair G Kergon <agk@redhat.com> wrote:
>  > > kcopyd
>  > >
>  > > ...
>  > > +/* FIXME: this should scale with the number of pages */
>  > > +#define MIN_JOBS 512
>  >
>  > This pins at least 2MB of RAM up-front, even if devicemapper is not in use.
> 
>  Is that really the case?

No, sorry, I had CONFIG_DEBUG_PAGEALLOC turned on...

130k is still quite a lot.  Bear in mind that this memory is never used
unless the page allocation attept fails.  The mempool is there to prevent
OOM deadlocks and it is usually the case that a single mempool item is
sufficient for that.
