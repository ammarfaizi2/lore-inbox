Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751002AbWGUS33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbWGUS33 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 14:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWGUS32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 14:29:28 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:21735
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1751002AbWGUS32
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 14:29:28 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>, ricknu-0@student.ltu.se
Subject: Re: [RFC][PATCH] A generic boolean (version 2)
Date: Fri, 21 Jul 2006 20:27:37 +0200
User-Agent: KMail/1.9.1
References: <1153341500.44be983ca1407@portal.student.luth.se> <1153445087.44c02cdf40511@portal.student.luth.se> <Pine.LNX.4.61.0607211623270.28469@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0607211623270.28469@yvahk01.tjqt.qr>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jeff@garzik.org>, Alexey Dobriyan <adobriyan@gmail.com>,
       Vadim Lobanov <vlobanov@speakeasy.net>,
       Shorty Porty <getshorty_@hotmail.com>,
       Peter Williams <pwil3058@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607212027.37823.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 July 2006 16:23, Jan Engelhardt wrote:
> >The changes are:
> >* u2 has been corrected to u1 (and also added it as __u1)
> 
> Do we really need this? Is not 'bool' enough?

I would say we don't even _want_ this.
A u1 variable will basically never be one bit wide.
It will be at least 8bit, or let's say 32bit. Maybe
even 64bit on some archs. It all depends on the compiler
plus the arch.

We _don't_ want u1, because we don't get what we see.
If we say u8 or u32, we get an 8bit wide data type and
a 32bit wide type. But we _don't_ get a 1bit wide
type for u1. We get something undefined.

Consider:

struct device_control_buffer {
	u1 device_is_fooing;
	u32 foodata;
} __attribute__((packed));

This would not lead to the expected results.
It's horribly broken, obfuscating and misleading.

-- 
Greetings Michael.
