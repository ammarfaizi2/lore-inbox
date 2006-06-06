Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbWFFVJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWFFVJp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 17:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbWFFVJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 17:09:45 -0400
Received: from khc.piap.pl ([195.187.100.11]:10768 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751109AbWFFVJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 17:09:44 -0400
To: Paul Fulghum <paulkf@microgate.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Dave Jones <davej@redhat.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: [PATCH] fix missing hdlc symbols for synclink drivers
References: <20060603232004.68c4e1e3.akpm@osdl.org>
	<20060605230248.GE3963@redhat.com>
	<20060605184407.230bcf73.rdunlap@xenotime.net>
	<1149622813.11929.3.camel@amdx2.microgate.com>
	<m3u06yc9mr.fsf@defiant.localdomain> <4485E723.4070201@microgate.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Tue, 06 Jun 2006 23:09:42 +0200
In-Reply-To: <4485E723.4070201@microgate.com> (Paul Fulghum's message of "Tue, 06 Jun 2006 15:35:47 -0500")
Message-ID: <m3lksac7op.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Fulghum <paulkf@microgate.com> writes:

> If I took that approach then you could never
> use the synclink drivers without generic HDLC.
>
> The synclink drivers can be used independent of
> the generic HDLC or with generic HDLC depending
> on space requirements and application.

Ah, now I understand. Anyway, the Makefile is not related to the problem.

> If you can provide a patch that continues allowing
> that level of flexibility in a way more to
> your liking, then please post it and I'll have a look.

I think I would modify the conditionals in drivers/char/synclink.c
- to assume that generic HDLC is not present if CONFIG_SYNCLINK=y
and CONFIG_HDLC=m. I would even put a user-visible comment in the
*config (like the one in generic HDLC menu if you have no X.25/LAPB).

I.e., I would probably change:

#ifdef CONFIG_HDLC_MODULE
#define CONFIG_HDLC 1
#endif

into something like:

#if defined(CONFIG_HDLC_MODULE) && defined(CONFIG_SYNCLINK_MODULE)
#define CONFIG_HDLC 1
#endif

plus that comment in Kconfig.

(Not sure if the other synclink*.c files are relevant and need similar
changes).
-- 
Krzysztof Halasa
