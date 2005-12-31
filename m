Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbVLaPrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbVLaPrh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 10:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbVLaPrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 10:47:37 -0500
Received: from canuck.infradead.org ([205.233.218.70]:55433 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1750781AbVLaPrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 10:47:36 -0500
Subject: Re: Integer types
From: David Woodhouse <dwmw2@infradead.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Jeff Sipek <jeffpc@optonline.net>, linux-kernel@vger.kernel.org
In-Reply-To: <84144f020512310155r4e99006cn21c5d622b544baa1@mail.gmail.com>
References: <20051231084719.GA6702@optonline.net>
	 <84144f020512310155r4e99006cn21c5d622b544baa1@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 31 Dec 2005 15:47:23 +0000
Message-Id: <1136044043.3516.155.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-12-31 at 11:55 +0200, Pekka Enberg wrote:
> > * u8, u16, ...
> > * uint8_t, uint16_t, ...
> > * u_int8_t, t_int16_t, ...
> 
> From the above list, the first ones. See
> http://article.gmane.org/gmane.linux.kernel/259313. Please note that
> there's also __le32 and __be32 for variables that have fixed byte
> ordering.

As ever, however, be aware that our esteemed leader is fickle.
Especially when he's wrong, as he was on that occasion.

The bit about namespace pollution is a red herring -- that's a good
enough reason for using '__u8', '__u16' etc. in those headers which are
user-visible and which mustn't require standard types, but it's no
excuse for the existence of the 'u8', 'u16' forms in code and headers
which _aren't_ user-visible.

The reason for the existence of the 'uXX' form is because once upon a
time, the kernel was buildable with compilers which predated the C99
standard types. It remains for historical reasons and because some
people (especially Linus) have some kind of emotional attachment to it.

The choice of whether to use 'uXX' or to use the proper standard
'uintXX_t' types is to a large extent a matter of the individual
developer's taste. If you're writing large chunks of your own code, then
do as you see fit; if you're modifying existing code, then use what's
there already.

-- 
dwmw2

