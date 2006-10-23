Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbWJWM5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWJWM5q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 08:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbWJWM5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 08:57:46 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:13287 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964786AbWJWM5p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 08:57:45 -0400
Subject: Re: incorrect taint of ndiswrapper
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Giridhar Pemmasani <pgiri@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061023113523.50028.qmail@web32402.mail.mud.yahoo.com>
References: <20061023113523.50028.qmail@web32402.mail.mud.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 23 Oct 2006 14:00:51 +0100
Message-Id: <1161608452.19388.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-10-23 am 04:35 -0700, ysgrifennodd Giridhar Pemmasani:
> So the idea of tainting is to _prevent_ any binary code being loaded into
> kernel, even if kernel is marked as having binary code loaded, which I
> thought was the purpose of tainting (so that people not interested in dealing
> with binary code know they don't have/want to)? If that is the goal, how do
> you know this scheme of adding names to module loader in kernel guarantees
> that (now or in future)? 

There are two overlapping mechanisms here

Taint is used to identify situations where debug data may not be good,
that may be proprietary or other dubiously legal code, it may be forcing
SMP active on non SMP suitable systems, it may be overriding certain
options in a potentially hazardous fashion. Taint exists primarily to
help debugging data analysis.

EXPORT_SYMBOL_GPL() is used to assert that the symbol is absolutely
definitely not a public symbol. EXPORT_SYMBOL exports symbols which
might be but even then the GPL derivative work rules apply. When you
mark a driver GPL it is permitted to use _GPL symbols, but if it does so
it cannot then go and load other non GPL symbols and expect people not
to question its validity.

