Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932556AbVIHBvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932556AbVIHBvO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 21:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbVIHBvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 21:51:14 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:30749 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932556AbVIHBvN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 21:51:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rfsUMKJVsHeZkLw1lg5JwZdWjqMssJBeQ1ULshIIkVosHrPDNTRcvbVc+wWKdM25OecTW/hks9ib3iVZtFl0EXrFMq3fE1N4cCETE6tJO67l415dJ1Kk8orVOPD5CWG8zPL/rxEOmC3YvjweVQFq5cgvWY+3qifnOXmWdbK2Efo=
Message-ID: <aec7e5c305090718515118a7a7@mail.gmail.com>
Date: Thu, 8 Sep 2005 10:51:08 +0900
From: Magnus Damm <magnus.damm@gmail.com>
Reply-To: magnus.damm@gmail.com
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH] i386: single node SPARSEMEM fix
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, Magnus Damm <magnus@valinux.co.jp>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>,
       "A. P. Whitcroft [imap]" <andyw@uk.ibm.com>
In-Reply-To: <1126117674.7329.27.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050906035531.31603.46449.sendpatchset@cherry.local>
	 <1126114116.7329.16.camel@localhost> <512850000.1126117362@flay>
	 <1126117674.7329.27.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/05, Dave Hansen <haveblue@us.ibm.com> wrote:
> On Wed, 2005-09-07 at 11:22 -0700, Martin J. Bligh wrote:
> > CONFIG_NUMA was meant to (and did at one point) support both NUMA and flat
> > machines. This is essential in order for the distros to support it - same
> > will go for sparsemem.
> 
> That's a different issue.  The current code works if you boot a NUMA=y
> SPARSEMEM=y machine with a single node.  The current Kconfig options
> also enforce that SPARSEMEM depends on NUMA on i386.
> 
> Magnus would like to enable SPARSEMEM=y while CONFIG_NUMA=n.  That
> requires some Kconfig changes, as well as an extra memory present call.
> I'm questioning why we need to do that when we could never do
> DISCONTIG=y while NUMA=n on i386.

Actually, I do not really care about the Kconfig stuff. I just added
that to show you guys why and when the change in
arch/i386/kernel/setup.c was needed. So my main interest is to include
the fix to the single-node version of setup_memory(). This to sync up
the single-node case with the multiple-node version of setup_memory(),
and to make it easier for me and other people to start using sparsemem
om single-node (or non-NUMA if you prefer that) configurations.

/ magnus
