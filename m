Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265400AbSKKDD3>; Sun, 10 Nov 2002 22:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265424AbSKKDD3>; Sun, 10 Nov 2002 22:03:29 -0500
Received: from air-2.osdl.org ([65.172.181.6]:63147 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265400AbSKKDD3>;
	Sun, 10 Nov 2002 22:03:29 -0500
Date: Sun, 10 Nov 2002 19:05:05 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: "Henning P. Schmiedehausen" <hps@intermeta.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: sscanf("-1", "%d", &i) fails, returns 0
In-Reply-To: <aqlnmp$sd4$1@forge.intermeta.de>
Message-ID: <Pine.LNX.4.33L2.0211101854350.22017-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Nov 2002, Henning P. Schmiedehausen wrote:

| "Randy.Dunlap" <rddunlap@osdl.org> writes:
|
| >+		digit = *str;
| >+		if (is_sign && digit == '-')
| >+			digit = *(str + 1);
|
| If signed is not allowed and you get a "-", you're in an error case
| again...

Yes, and a 0 value is returned.
IOW, asking for an unsigned number (in the format string)
and getting "-123" does return 0.

What should it do?
This function can't return -EINPUTERROR or -EILSEQ.
(since it's after feature-freeze :)
And the original problem was that a leading '-' sign on a
signed number (!) caused a return of 0.  At least that is fixed.

So now the problem (?) is that a '-' sign on an unsigned number
returns 0.  We can always add a big printk() there that
something is foul.  Other ideas?

-- 
~Randy

