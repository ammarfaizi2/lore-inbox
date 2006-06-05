Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751052AbWFEVqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbWFEVqR (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 17:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbWFEVqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 17:46:17 -0400
Received: from mail.gmx.de ([213.165.64.20]:8679 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750992AbWFEVqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 17:46:17 -0400
X-Authenticated: #704063
Subject: Re: [Patch] Zoran strncpy() cleanup
From: Eric Sesterhenn <snakebyte@gmx.de>
To: Horst Schirmeier <horst@schirmeier.com>
Cc: LKML <linux-kernel@vger.kernel.org>, bdirks@pacbell.net
In-Reply-To: <20060605213645.GO7236@quickstop.soohrt.org>
References: <1149538357.16994.7.camel@alice>
	 <20060605210230.GN7236@quickstop.soohrt.org>
	 <1149542155.17537.3.camel@alice>
	 <20060605213645.GO7236@quickstop.soohrt.org>
Content-Type: text/plain
Date: Mon, 05 Jun 2006 23:46:14 +0200
Message-Id: <1149543974.17681.2.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Problem is, the strings are (possibly) still not zero-terminated:
> strncpy() only appends zeroes if src contents are short enough; if they
> are not, dest is only zero-terminated if dest[sizeof(dest)-1] was zero
> before.
> strlcpy() semantics promise more sanity; dest is always zero-terminated
> (if its size is >= 1), and the size parameter holds total dest size.
> (See lib/string.c for more details.)

In all cases there is a memset() which sets the entire structure to
zero. Since we never write to the last byte with the strncpy() it will
be null terminated. But if you think strlcpy() is safer for the future,
i can make you a third patch.

Greetings, Eric

