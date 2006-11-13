Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755260AbWKMUtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755260AbWKMUtt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 15:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755334AbWKMUtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 15:49:49 -0500
Received: from khc.piap.pl ([195.187.100.11]:34228 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1755260AbWKMUts (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 15:49:48 -0500
To: Paul Fulghum <paulkf@microgate.com>
Cc: Jeff Garzik <jeff@garzik.org>,
       Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Re: linux-2.6.19-rc5-g088406bc build #120 failed
References: <200611130943.42463.toralf.foerster@gmx.de>
	<4558860B.8090908@garzik.org> <45588895.7010501@microgate.com>
	<m3ejs78adt.fsf@defiant.localdomain> <4558BF72.2030408@microgate.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Mon, 13 Nov 2006 21:49:47 +0100
In-Reply-To: <4558BF72.2030408@microgate.com> (Paul Fulghum's message of "Mon, 13 Nov 2006 12:54:42 -0600")
Message-ID: <m3ac2v6phw.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Fulghum <paulkf@microgate.com> writes:

> We were in a perpetual state of:
>
> 1. supply patch
> 2. get criticism from new person just joining thread
> 3. change patch to address criticism
> 4. goto #1

Right, the description fits. OTOH I recall the criticism had a fair
amount of merit. That's how the things work here. Been there many
times BTW.

>> Nevertheless a fix outlined above would be acceptable, wouldn't it?
>
> It breaks things by forcing the customer to include code
> that is not required. That is an issue for embedded systems.

Nope, the fix which didn't change Kconfig and just assumed HDLC=m and
SYNCLINK*=y => HDLC is not available. I.e., the one with

#if defined(CONFIG_HDLC_MODULE) &&/|| defined(CONFIG_SYNCLINK*something)
#define CONFIG_HDLC something

changed into

#if defined(CONFIG_HDLC_MODULE) &&/|| defined(CONFIG_SYNCLINK*something)
#define USE_HDLC something
        ^^^^^^^^

> But since we seem stuck in a state where real fixes
> are not allowed, and this breakage is constantly reintroduced,

It may look like that sometimes but it's not real. Anyway I think
everyone would benefit from the correct fix and the issue wouldn't
come again. Having looked at it I'd fix it myself but I'm pretty
sure you still have the old patch (which changes CONFIG_ macros
outside Kconfig, I mean in .c files) and it could be trivially
modified then applied (and perhaps tested with real hardware if
needed).
-- 
Krzysztof Halasa
