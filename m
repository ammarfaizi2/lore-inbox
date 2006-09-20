Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbWITGUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbWITGUh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 02:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbWITGUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 02:20:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25065 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750896AbWITGUg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 02:20:36 -0400
Date: Tue, 19 Sep 2006 23:20:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alex Dubov <oakad@yahoo.com>
Cc: linux-kernel@vger.kernel.org, drzeus-list@drzeus.cx,
       rmk+lkml@arm.linux.org.uk
Subject: Re: [PATCH 1/2] [MMC] Driver for TI FlashMedia card reader - source
Message-Id: <20060919232016.68a02e0e.akpm@osdl.org>
In-Reply-To: <20060920060212.7327.qmail@web36712.mail.mud.yahoo.com>
References: <20060920060212.7327.qmail@web36712.mail.mud.yahoo.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2006 23:02:11 -0700 (PDT)
Alex Dubov <oakad@yahoo.com> wrote:

> Driver for TI Flash Media card reader. At present, only MMC/SD
> cards are supported.

Could I ask where the information which permitted this (nice-looking) driver to
be written came from?


Trivia:

There's some whitespace damage in there.  Please search the diff for "^ "
and fix it up.

We indent the body of switch statements one tab stop less than this driver
does.

The driver has lots of really big inlined functions.  It's best to uninline
these.  If the function has a single callsite, gcc will inline it anyway. 
If the function has multiple callsites (now, or in the future), inlining it
is undesirable.

The driver has a lot of things like

	static inline void* tifm_get_drvdata(struct tifm_dev *dev)

whereas we prefer

	static inline void *tifm_get_drvdata(struct tifm_dev *dev)

