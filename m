Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265128AbUFARPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265128AbUFARPi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 13:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265102AbUFARPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 13:15:38 -0400
Received: from 209-128-98-078.bayarea.net ([209.128.98.78]:56449 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S265128AbUFARPe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 13:15:34 -0400
Message-ID: <40BCB988.80408@zytor.com>
Date: Tue, 01 Jun 2004 10:14:48 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6.6-rc3] gcc-3.4.0 fixes
References: <200404292146.i3TLkfI0019612@harpo.it.uu.se>	<c892nk$5pf$1@terminus.zytor.com> <16572.38987.239160.819836@alkaid.it.uu.se>
In-Reply-To: <16572.38987.239160.819836@alkaid.it.uu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> 
> You're assuming pointers have uniform representation.
> C makes no such guarantees, and machines _have_ had
> different types of representations in the past.
 >

By the way, I am not in any shape, way or form making that assumption - 
although that's presumably how it would be *implemented* in an architecture 
with sane pointers like, to the best of my knowledge ALL gcc targets.

(foo *)bar++;

... should be implemented as ...

({
	foo *tmp1 = (foo *)bar;
	tmp2 = tmp1 + 1;
	bar = __typeof__(bar)tmp2;
	tmp1;
})

	-hpa
