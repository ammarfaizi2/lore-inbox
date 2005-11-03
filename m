Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751548AbVKCDk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbVKCDk6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 22:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbVKCDk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 22:40:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:37004 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751548AbVKCDk5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 22:40:57 -0500
Date: Thu, 3 Nov 2005 13:40:43 +1100
From: Andrew Morton <akpm@osdl.org>
To: Michael Krufky <mkrufky@m1k.net>
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: Re: [PATCH 05/37] dvb: add alternate stv0297-driver
Message-Id: <20051103134043.55fc2b26.akpm@osdl.org>
In-Reply-To: <43672375.1020603@m1k.net>
References: <43672375.1020603@m1k.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Krufky <mkrufky@m1k.net> wrote:
>
> +#define abs64(x) (x) < 0 ? -(x) : (x);

Needs parentheses around the whole thing.

This should go into include/linus/kernel.h, after labs(), methinks.

>  +static s64 div64(s64 dividend,s64 divisor)

hm.  If we really need a 64-by-64 divide then it shouldn't be hidden in a dvb
driver, please.   I bet we have a few in the tree already, actually.

So it'd be appreciated if someone could take a shot at generating a generic
version of this.  It'll need to be inlined for 64-bit arches, out-of-line
for 32-bit.

It'll also need to be permanently wired into the kernel, alas.  We cannot
tell at compile time whether it'll be needed :(   EXPORT_SYMBOL() it.

