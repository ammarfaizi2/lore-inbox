Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269226AbUINWZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269226AbUINWZE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 18:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267634AbUINWYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 18:24:49 -0400
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:27365 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S269622AbUINWVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 18:21:49 -0400
Date: Tue, 14 Sep 2004 18:20:02 -0400
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: TG3 doesn't work in kernel 2.4.27 (David S. Miller)
In-reply-to: <20040913154828.35d60ac1.davem@davemloft.net>
To: "David S. Miller" <davem@davemloft.net>
Cc: Anton Blanchard <anton@samba.org>, moilanen@austin.ibm.com,
       roland@topspin.com, plars@linuxtestproject.org, Brian.Somers@Sun.COM,
       linux-kernel@vger.kernel.org
Message-id: <41476E92.6020609@sun.com>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_j+GlaQb1NJrGJEf38sBJnQ)"
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <412DC055.4070401@sun.com>
 <20040830161126.585a6b62.davem@davemloft.net>
 <1094238777.9913.278.camel@plars.austin.ibm.com> <4138C3DD.1060005@sun.com>
 <52acw7rtrw.fsf@topspin.com> <20040903133059.483e98a0.davem@davemloft.net>
 <52ekljq6l2.fsf@topspin.com> <20040907133332.4ceb3b5a@localhost>
 <52isapkg9z.fsf@topspin.com> <20040908073412.3b7c9388@localhost>
 <20040908130728.GA2282@krispykreme>
 <20040913154828.35d60ac1.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_j+GlaQb1NJrGJEf38sBJnQ)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

David S. Miller wrote:
> On Wed, 8 Sep 2004 23:07:28 +1000
> Anton Blanchard <anton@samba.org> wrote:
>
>
>>
>>
>>>I've had mixed results.  On some of my blades it never works.  On others
>>>it will come up every third attempt or so.
>>
>>2.6 BK as of 2 days ago wasnt working on my JS20 either. Ive been
>>meaning to look closer but havent had a chance yet.
>
>
> Are you going to work on this soon Anton?  I will cook up some
> debugging patches, this bug sucks and I want to fix it soon.

I've gone through the changes you've made lately and I found a thinko,
patch attached.

With this patch, I can turn off autoneg on our b1600's switch and the
b200x falls back to 1000FD as required.

Signed-Off: Mike Waychison <michael.waychison@sun.com>

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice
http://www.sun.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBR26QdQs4kOxk3/MRAoCrAJ95xamjKjB1gSnNa63PrncjvHEfWwCghxkJ
UOQQ0P+4kc/FnbwfeXEaGHA=
=G6li
-----END PGP SIGNATURE-----

--Boundary_(ID_j+GlaQb1NJrGJEf38sBJnQ)
Content-type: text/x-patch; name=tg3-hw-autoneg-fallback.patch
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=tg3-hw-autoneg-fallback.patch

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.2191  -> 1.2192 
#	   drivers/net/tg3.c	1.203   -> 1.204  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/09/14	root@lnx42.localdomain	1.2192
# tg3.c:
#   - fixed small thinko for hw autoneg fallback to 1000FD
# --------------------------------------------
#
diff -Nru a/drivers/net/tg3.c b/drivers/net/tg3.c
--- a/drivers/net/tg3.c	Tue Sep 14 22:13:16 2004
+++ b/drivers/net/tg3.c	Tue Sep 14 22:13:16 2004
@@ -2168,7 +2168,7 @@
 					else
 						val |= 0x4010880;
 
-					tw32_f(MAC_SERDES_CFG, serdes_cfg);
+					tw32_f(MAC_SERDES_CFG, val);
 				}
 
 				tw32_f(SG_DIG_CTRL, 0x01388400);

--Boundary_(ID_j+GlaQb1NJrGJEf38sBJnQ)--
