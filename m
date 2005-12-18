Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932680AbVLRDZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932680AbVLRDZf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 22:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932681AbVLRDZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 22:25:35 -0500
Received: from cantor2.suse.de ([195.135.220.15]:49101 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932680AbVLRDZe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 22:25:34 -0500
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 01/13]  [RFC] ipath basic headers
References: <200512161548.jRuyTS0HPMLd7V81@cisco.com>
	<200512161548.aLjaDpGm5aqk0k0p@cisco.com>
	<20051217131456.GA13043@infradead.org>
	<m1irtn75pk.fsf@ebiederm.dsl.xmission.com>
From: Andi Kleen <ak@suse.de>
Date: 18 Dec 2005 04:25:27 +0100
In-Reply-To: <m1irtn75pk.fsf@ebiederm.dsl.xmission.com>
Message-ID: <p73oe3fdr2w.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Christoph Hellwig <hch@infradead.org> writes:
> 
> > please always used fixes-size types for user communication.  also please
> > avoid ioctls like the rest of the IB codebase.
> 
> Could someone please explain to me how the uverbs abuse of write
> is better that ioctl?  

It's actually worse because if they have a 32bit compat issue
then ioctl can be fixed up, but read/write can't. 

I wish the people arguing against ioctl all the time would
just stop that because the alternatives are usually worse.
 
> - 64bit compilers will not pad every structure to 8 bytes.  This
>   only will happen if you happen to have an 8 byte element in your
>   structure that is only aligned to 32bits by a 32bit structure.
>   Unfortunately the 32bit gcc only aligns long long to 32bits on
>   x86, which triggers the described behavior.

Exactly - and driver writers usually don't get that right so we
need to have a tool to fix it up in the end. And with ioctl
that's easiest.

-Andi
