Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbWGVJFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWGVJFc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 05:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWGVJFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 05:05:32 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:49538 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751116AbWGVJFb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 05:05:31 -0400
Date: Sat, 22 Jul 2006 10:56:04 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Michael Buesch <mb@bu3sch.de>
cc: ricknu-0@student.ltu.se, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Vadim Lobanov <vlobanov@speakeasy.net>,
       Shorty Porty <getshorty_@hotmail.com>,
       Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [RFC][PATCH] A generic boolean (version 2)
In-Reply-To: <200607212027.37823.mb@bu3sch.de>
Message-ID: <Pine.LNX.4.61.0607221054380.8381@yvahk01.tjqt.qr>
References: <1153341500.44be983ca1407@portal.student.luth.se>
 <1153445087.44c02cdf40511@portal.student.luth.se>
 <Pine.LNX.4.61.0607211623270.28469@yvahk01.tjqt.qr> <200607212027.37823.mb@bu3sch.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >* u2 has been corrected to u1 (and also added it as __u1)
>> 
>> Do we really need this? Is not 'bool' enough?
>
>I would say we don't even _want_ this.
>A u1 variable will basically never be one bit wide.

Not without a compiler hack at least.

>Consider:
>
>struct device_control_buffer {
>	u1 device_is_fooing;
>	u32 foodata;
>} __attribute__((packed));
>
>This would not lead to the expected results.
>It's horribly broken, obfuscating and misleading.

And in fact, bitfields work different:

struct device {
	int device_is_fooing:1;
	u32 foodata;
};

but the result is likely the same.


Jan Engelhardt
-- 
