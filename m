Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312885AbSCZAOi>; Mon, 25 Mar 2002 19:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312886AbSCZAO2>; Mon, 25 Mar 2002 19:14:28 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:18446 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S312885AbSCZAOK>; Mon, 25 Mar 2002 19:14:10 -0500
Message-ID: <3C9FBCDA.C898E977@zip.com.au>
Date: Mon, 25 Mar 2002 16:12:10 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [patch] smaller kernels
In-Reply-To: <20020325165605.7d9c1d6e.rusty@rustcorp.com.au> <Pine.LNX.4.21.0203251921570.3378-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> 
> I've just readded all asserts which you removed... if you really want to
> remove any of those, please prove me that they are useless.

I grepped a year's lkml traffic - nobody is hitting any
of them...

The quotaops.h checks were useless:

	if (pointer == NULL)
		BUG();
	dereference(pointer);

The others can become calls to out_of_line_bug() if
you want.  That's dget(), unhash_process(),
memclear_highpage_flush(), __skb_pull() and tcp_prequeue()

-
