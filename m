Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbTDQTmi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 15:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbTDQTmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 15:42:37 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:9747 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261903AbTDQTmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 15:42:37 -0400
Date: Thu, 17 Apr 2003 12:54:30 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Arjan van de Ven <arjanv@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BK+PATCH] remove __constant_memcpy
In-Reply-To: <20030417191939.GG25696@gtf.org>
Message-ID: <Pine.LNX.4.44.0304171253270.2795-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 17 Apr 2003, Jeff Garzik wrote:
> 
> __constant_memcpy was used for small, constant-sized cases AFTER
> the kernel made the decision not to hand the copy duties over to the
> kernel's MMX/SSE code.  Take a look at the bottom of the patch below,
> and also this snip from a non-hacked string.h, for illustration...

This is the part I don't like

 #define memcpy(t, f, n) \
 (__builtin_constant_p(n) ? \
- __constant_memcpy((t),(f),(n)) : \
+ __builtin_memcpy((t),(f),(n)) : \
  __memcpy((t),(f),(n)))

Notice? Our old __constant_memcpy() would do the rigth thing for large 
copies. In conrast, I don't know that gcc will do so.

		Linus

