Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264083AbTGCPFm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 11:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264127AbTGCPFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 11:05:42 -0400
Received: from air-2.osdl.org ([65.172.181.6]:48090 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264083AbTGCPFh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 11:05:37 -0400
Date: Thu, 3 Jul 2003 08:20:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jari Ruusu <jari.ruusu@pp.inet.fi>
Cc: Andries.Brouwer@cwi.nl, akpm@digeo.com, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH] cryptoloop
Message-Id: <20030703082034.5643b336.akpm@osdl.org>
In-Reply-To: <3F0411B9.9E11022D@pp.inet.fi>
References: <UTC200307021844.h62IiIQ19914.aeb@smtp.cwi.nl>
	<3F0411B9.9E11022D@pp.inet.fi>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jari Ruusu <jari.ruusu@pp.inet.fi> wrote:
>
> Andries.Brouwer@cwi.nl wrote:
> > akpm:
> > > You'll note that loop.c goes from (page/offset/len) to (addr/len),
> > > and this transfer function then immediately goes from (addr,len)
> > > to (page/offset/len). That's rather silly ..
> > 
> > Changing that would kill all existing modules that use the loop device.
> > 
> > Maybe nobody cares. Then we can do so in a subsequent patch.
> 
> I care. Please don't break the transfer function prototype.

Why?

> I don't know if you guys have realized it or not, but cryptoloop+cryptoapi
> is the slowest possible loop crypto implementation on the planet. Before you
> guys sacrifice loop performance with cryptoloop only stuff, you may want to
> do google search for "loop-AES" (twice as fast on most modern boxes) and
> choose to preserve fast interfaces that other implementations depend on.

It's not clear what point you're actually trying to make here.  But it's
worth pointing out that the current transfer function interface can be sped
up (a bit) by going to a pageframe-based one.
