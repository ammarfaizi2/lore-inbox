Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbTDQPzr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 11:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbTDQPzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 11:55:47 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34055 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261706AbTDQPzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 11:55:45 -0400
Date: Thu, 17 Apr 2003 09:07:45 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Arjan van de Ven <arjanv@redhat.com>
cc: Jeff Garzik <jgarzik@pobox.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BK+PATCH] remove __constant_memcpy
In-Reply-To: <1050569207.1412.1.camel@laptop.fenrus.com>
Message-ID: <Pine.LNX.4.44.0304170903001.1530-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 17 Apr 2003, Arjan van de Ven wrote:
> 
> it can do that ANYWAY for all kinds of things.
> We really should ask the gcc folks to add a
> -fdontyoudareusefloatingpoint flag (well different name probably)

Well, _most_ architectures actually have that flag already. It's not 
called -fdontyoudareusefloatingpoint on any of them, though ;)

It's most commonly called "-mno-fpu", but sh calls it "-mno-implicit-fp",
and alpha calls it "-mno-fp-regs".

On x86, gcc doesn't have such an option, although "-mno-sse" and
"-mno-sse2" probably come closest (and we should probably use them, but
since older gcc's don't know about it and it hasn't been an issue yet we
haven't).

HOWEVER, that doesn't fix the memcpy() issue. The fact is, the kernel 
_can_ and does use SSE instructions - it's just that it has to do magic 
crap before it does so. 

		Linus

