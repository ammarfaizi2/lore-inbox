Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWITXI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWITXI3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 19:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWITXI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 19:08:29 -0400
Received: from smtp-out.google.com ([216.239.45.12]:50719 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750735AbWITXI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 19:08:28 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=QxW2zu1Tx4mu3otSI4j9WaHa6FQ02LIFF8EWcXNDY6WnR494uuPgvBCXFL1d9J9nd
	0xe2SDhGjRTfh0PR6ZMEQ==
Message-ID: <404ea8000609201608i5abb35eco269225c441b66d1a@mail.google.com>
Date: Wed, 20 Sep 2006 16:08:18 -0700
From: "Dmitriy Zavin" <dmitriyz@google.com>
To: "Andi Kleen" <ak@suse.de>
Subject: Re: [PATCH 2/4] jiffies: Add 64bit jiffies compares (needed when long < 64bit).
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <200609200940.38356.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11587201623432-git-send-email-dmitriyz@google.com>
	 <11587201623187-git-send-email-dmitriyz@google.com>
	 <11587201621900-git-send-email-dmitriyz@google.com>
	 <200609200940.38356.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These compares are there to use jiffies_64 safely on 32bit and 64 bit
systems, and jiffies_64 (and thus get_jiffies_64()) is always defined
as u64. Since this is not arch code, but generic for all
architectures, it should use the generic u64/s64 types. If the user
passes in a long and assumes that it's 64 bit, then it is user error.
I'll add a comment that says that these macros must be used with u64
values (as returned by get_jiffies_64()).

Thanks.

--Dima

P.S. This also means that currently, on 64 bit systems,
time_before/time_after is broken (typecheck fails) on values returned
by get_jiffies_64().

On 9/20/06, Andi Kleen <ak@suse.de> wrote:
>
> > +#define time_after64(a,b)            \
> > +     (typecheck(__u64, a) && \
> > +      typecheck(__u64, b) && \
>
> Did you double check the typecheck DTRT when someone
> passes in both plain long and long long on 64bit?
>
> -Andi
>
>
