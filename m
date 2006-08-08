Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbWHHGbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWHHGbr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 02:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWHHGbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 02:31:46 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:59029 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751247AbWHHGbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 02:31:46 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] x86_64:  Auto size the per cpu area.
References: <m1irl4ftya.fsf@ebiederm.dsl.xmission.com>
	<m1slk89ozd.fsf@ebiederm.dsl.xmission.com>
	<20060807165512.dabefb63.akpm@osdl.org>
	<200608080417.59462.ak@suse.de>
	<20060807194159.f7c741b5.akpm@osdl.org>
	<1155005284.3042.11.camel@laptopd505.fenrus.org>
	<m13bc7aidw.fsf_-_@ebiederm.dsl.xmission.com>
	<20060807230116.3c9247d6.akpm@osdl.org>
Date: Tue, 08 Aug 2006 00:31:06 -0600
In-Reply-To: <20060807230116.3c9247d6.akpm@osdl.org> (Andrew Morton's message
	of "Mon, 7 Aug 2006 23:01:16 -0700")
Message-ID: <m1psfb91sl.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> On Mon, 07 Aug 2006 23:47:23 -0600
> ebiederm@xmission.com (Eric W. Biederman) wrote:
>
>> +#ifdef CONFIG_MODULES
>> +# define PERCPU_MODULE_RESERVE 8192
>> +#else
>> +# define PERCPU_MODULE_RESERVE 0
>> +#endif
>> +
>> +#define PERCPU_ENOUGH_ROOM \
>> +	(ALIGN(__per_cpu_end - __per_cpu_start, SMP_CACHE_BYTES) + \
>> +	 PERCPU_MODULE_RESERVE)
>> +
>
> Seems sane, but isn't 8192 a bit small?

By my measure 8K is about 1/2KB less than what we have free in
2.6.18-rc3.  So it looks like a good initial guess to me.

Eric
