Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265249AbUFAVsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265249AbUFAVsE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 17:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265250AbUFAVsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 17:48:04 -0400
Received: from aun.it.uu.se ([130.238.12.36]:648 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265249AbUFAVr3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 17:47:29 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16572.63852.106490.852850@alkaid.it.uu.se>
Date: Tue, 1 Jun 2004 23:47:24 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6.6-rc3] gcc-3.4.0 fixes
In-Reply-To: <40BCB988.80408@zytor.com>
References: <200404292146.i3TLkfI0019612@harpo.it.uu.se>
	<c892nk$5pf$1@terminus.zytor.com>
	<16572.38987.239160.819836@alkaid.it.uu.se>
	<40BCB988.80408@zytor.com>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:
 > Mikael Pettersson wrote:
 > > 
 > > You're assuming pointers have uniform representation.
 > > C makes no such guarantees, and machines _have_ had
 > > different types of representations in the past.
 >  >
 > 
 > By the way, I am not in any shape, way or form making that assumption - 
 > although that's presumably how it would be *implemented* in an architecture 
 > with sane pointers like, to the best of my knowledge ALL gcc targets.
 > 
 > (foo *)bar++;
 > 
 > ... should be implemented as ...
 > 
 > ({
 > 	foo *tmp1 = (foo *)bar;
 > 	tmp2 = tmp1 + 1;
 > 	bar = __typeof__(bar)tmp2;
 > 	tmp1;
 > })

I did an experiment with updating an unsigned short
via a cast-as-lvalue to unsigned char, and gcc did
in fact implement the temp + copy semantics you
describe above. That is,

	unsigned short x = 0xaafe;
	((unsigned char)x)++;

resulted in x == 0x00ff.

So cast-as-lvalue is at least reasonably correctly
implemented in gcc.

Whether it's useful and portable is a another matter :-)
