Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261809AbVGaQdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbVGaQdP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 12:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbVGaQdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 12:33:15 -0400
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:11526 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id S261809AbVGaQdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 12:33:14 -0400
Subject: Re: [PATCH] speed up on find_first_bit for i386 (let compiler do
	the work)
From: Richard Kennedy <richard@rsk.demon.co.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sun, 31 Jul 2005 17:33:12 +0100
Message-Id: <1122827592.5333.9.camel@castor.rsk.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
FWIW the following routine is consistently slightly faster using
Steven's test harness , with a big win when no bit set.

static inline int new_find_first_bit(const unsigned long *b, unsigned
size)
{
	int x = 0;
	do {
		unsigned long v = *b++;
	  	if (v)
			return __ffs(v) + x;
		if (x >= size)
			break;
		x += 32;
	} while (1);
	return x;
}

Tested on P III M 933MHz / gcc 4.0.1

clock speed = 00000000:17c56980 398813568 ticks per second

no bit set
ffb=320  my=320 new=320
generic ffb: 00000000:02fd6660
time: 0.125776182us
my ffb: 00000000:03c314e9
time: 0.158260714us
new ffb : 00000000:02d9190b
time: 0.119810758us

last bit set
ffb=319  my=319 new=319 
generic ffb: 00000000:04e5900c
time: 0.205994717us
my ffb: 00000000:0327475d
time: 0.132658024us
new ffb: 00000000:02c86938
time: 0.117068655us

middle bit set
ffb=159  my=159 new=159
generic ffb: 00000000:03c2bc56
time: 0.158203865us
my ffb: 00000000:01356b8b
time: 0.050846204us
new ffb: 00000000:0115f133
time: 0.045673521us

first bit set
ffb=0  my=0 new=0 
generic ffb: 00000000:02d07460
time: 0.118390436us
my ffb: 00000000:005d3079
time: 0.015313564us
new ffb: 00000000:005cca07
time: 0.015247804us

Cheers
Richard
Not subscribed please CC -- thanks.


