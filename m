Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261650AbSJAPEH>; Tue, 1 Oct 2002 11:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261651AbSJAPEH>; Tue, 1 Oct 2002 11:04:07 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:7569 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S261650AbSJAPEH>;
	Tue, 1 Oct 2002 11:04:07 -0400
To: <linux-kernel@vger.kernel.org>
Subject: Re: Generic HDLC interface continued
References: <m3y99nrtsu.fsf@defiant.pm.waw.pl>
	<20020928202138.A17244@se1.cogenit.fr>
	<m3smzsnbx9.fsf@defiant.pm.waw.pl>
	<20020930225437.A19967@se1.cogenit.fr>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 01 Oct 2002 01:48:23 +0200
In-Reply-To: <20020930225437.A19967@se1.cogenit.fr>
Message-ID: <m3n0pzm43c.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu <romieu@cogenit.fr> writes:

> > Not exactly. The caller always knows meaning of the returned value
> > (or it reports error etc). The caller doesn't just know size of the value
> > _in_advance_, as it isn't constant. Still, meaning of the variable portion
> > of the data is defined by the constant part.
> 
> The caller doesn't know size in advance but he gets 'type' and 'size' at
> the same time. Why shouldn't 'size' be deduced from 'type' ?

The caller don't know the result size. It mallocs some space which is
long enough for usual things. Now, we have new super protocol with 100 KB
of config data, and the caller requests settings of that protocol.

With "size" variable, the caller signals that there are 500 bytes for
the result, and the kernel tells it that 100 KB are required, and that
it's BTW the super protocol itself. The caller can allocate more space
and try again, or just fail if it doesn't know the protocol.

Without "size" variable, the kernel tries to copy 100 KB to random
space, and we get results ranging from SEGV to mysterious behavior.

Please note that there is no call which could return the protocol
(or interface type) without copying the whole data - thus the caller
(utility) is unable to skip unknown interfaces.
-- 
Krzysztof Halasa
Network Administrator
