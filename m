Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264667AbTFLBq7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 21:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264668AbTFLBq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 21:46:59 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38921 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264667AbTFLBqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 21:46:50 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Compiling kernel with SuSE 8.2/gcc 3.3
Date: Thu, 12 Jun 2003 02:00:06 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <bc8mr6$eqk$1@old-penguin.transmeta.com>
References: <3EE6B7A2.3000606@austin.rr.com.suse.lists.linux.kernel> <p73he6x59hf.fsf@oldwotan.suse.de> <3EE7D659.2000003@austin.rr.com>
X-Trace: palladium.transmeta.com 1055383206 16917 127.0.0.1 (12 Jun 2003 02:00:06 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 12 Jun 2003 02:00:06 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@old-penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3EE7D659.2000003@austin.rr.com>,
Steve French  <smfrench@austin.rr.com> wrote:
>Although it fixes it for building on 32 bit architectures, won't changing
>
>
>	__u64 uid = 0xFFFFFFFFFFFFFFFF;
>to
>
>	__u64 uid = 0xFFFFFFFFFFFFFFFFULL;
>
>generate a type mismatch warning on ppc64 and similar 64 bit
>architecutres since __u64 is not a unsigned long long on ppc64 
>(it is unsigned long)?

No, why would it? 

If you do

	char c = 1;

do you expect a warning? The right side of the assignent 
is an "int", and the left side is a "char", but it's perfectly ok to
assign a wider type to a narrower one.

And so if "__u64" were to be a plain "unsigned long" on a 64-bit
architecture (and even if "unsigned long long" were to be 128 bits), the
constant 0xFFFFFFFFFFFFFFFFULL is (a) a perfectly valid unsigned long
long value and (b) fits perfectly well even in an "unsigned long", so
the compiler has no reason to complain about the assignment losing bits
(which it otherwise might do).

So I'd much rather make the constants too big than too small. And yes,
Andrew's suggestion about just assigning -1 works, but it's actually a
very subtle cast at that point.

		Linus
