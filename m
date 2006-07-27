Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751651AbWG0PPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651AbWG0PPI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 11:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751687AbWG0PPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 11:15:08 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:25481
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751651AbWG0PPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 11:15:07 -0400
Message-Id: <44C8F4E5.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Thu, 27 Jul 2006 16:16:21 +0100
From: "Jan Beulich" <jbeulich@novell.com>
To: "Michael Buesch" <mb@bu3sch.de>
Cc: <jgarzik@pobox.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix Intel RNG detection
References: <44C8BE63.76E4.0078.0@novell.com>
 <200607271623.48023.mb@bu3sch.de>
In-Reply-To: <200607271623.48023.mb@bu3sch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> +#ifdef CONFIG_SMP
>> +static volatile char __initdata waitflag;
>
>I don't think we want to add yet another use of volatile
>(see the kernel archives for why).
>Use memory barriers instead, please.

I can certainly do that.

>> +#define waitflag err
>
>That's really confusing magic.

Any better idea? I just wanted to prevent adding another #ifdef CONFIG_SMP, and since it doesn't matter where the write
goes for UP, doing it that way seemed the simplest solution.

>> +	writeb(0xff, mem);
>> +	writeb(0x90, mem);
>> +	mfg = readb(mem + 0);
>> +	dvc = readb(mem + 1);
>> +	writeb(0xff, mem);
>
>Do these magic registers have names? Possible to use #defines for it?

While one could certainly make up names for them (the documentation of the functionality used here isn't the best I've
seen), I generally dislike creating defines when their values are used just in a single place *and* when their naming
can at best be artificial (i.e. doesn't serve documentation purposes). But if you and/or Jeff insist, I can certainly do
a change like that.

Jan

Jan
