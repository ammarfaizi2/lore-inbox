Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263340AbTDSCih (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 22:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263343AbTDSCih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 22:38:37 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:8713 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S263340AbTDSCie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 22:38:34 -0400
Date: Sat, 19 Apr 2003 11:50:53 +0900 (JST)
Message-Id: <20030419.115053.123574563.yoshfuji@wide.ad.jp>
To: latten@austin.ibm.com
Cc: davem@redhat.com, kuznet@ms2.inr.ac.ru, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: IPsecv6 integrity failures not dropped
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@wide.ad.jp>
In-Reply-To: <200304182017.h3IKH4ng019821@faith.austin.ibm.com>
References: <200304182017.h3IKH4ng019821@faith.austin.ibm.com>
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200304182017.h3IKH4ng019821@faith.austin.ibm.com> (at Fri, 18 Apr 2003 15:17:04 -0500), latten@austin.ibm.com says:

> incoming packet fails, result is an ICMPv6 Parameter problem 
> of Unknown-Next-Header, instead of just dropping packet. This 
> is because xfrm6_rcv() expects an unsigned-8-bit return value 
> from the input handler, i.e. ah6_input() or esp6_input(). But handler 
> returns a signed int (-EINVAL) that seems to be getting converted into 
> a "u8" via 2's complement, because ah6_input() says it is returning
> -EINVAL/-22, but xfrm6_rcv() says it got a return value of 234,
> which it believes to be valid and passes to ip6_input() who thinks it is 
> the next header.  
> 
> I modified ah6_input() and esp6_input() to return zero instead of -EINVAL
> in the fix below. I tested it and it works.

just change u8 nexthdr = 0 to int nexthdr = 0, in xfrm6_rcv() is fine, 
isn't it?

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
