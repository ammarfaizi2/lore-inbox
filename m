Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262900AbTCQGQR>; Mon, 17 Mar 2003 01:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262903AbTCQGQR>; Mon, 17 Mar 2003 01:16:17 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58897 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262900AbTCQGQQ>; Mon, 17 Mar 2003 01:16:16 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Why is get_current() not const function?
Date: Mon, 17 Mar 2003 06:26:26 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <b53pqi$ud9$1@penguin.transmeta.com>
References: <20030313061926.S3910@devserv.devel.redhat.com>
X-Trace: palladium.transmeta.com 1047882418 6017 127.0.0.1 (17 Mar 2003 06:26:58 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 17 Mar 2003 06:26:58 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030313061926.S3910@devserv.devel.redhat.com>,
Jakub Jelinek  <jakub@redhat.com> wrote:
>
>Anyone remembers why get_current function (on arches which define
>current to get_current()) is not const

Because it makes no difference at all on x86, since gcc will ignore
"const" for inline functions. At least that used to be true.

>					 and why on x86-64
>the movq %%gs:0, %0 inline asm is volatile with "memory" clobber?

Can't help you on that one, but it looks like it uses various helper
functions for doing the x86-64 per-processor data structures, and I bet
those helper functions are shared by _other_ users who definitely want
to have their data properly re-read. Ie "current()" may be constant in
process context, but that sure isn't true about a lot of other things in
the per-processor data structures.

		Linus
