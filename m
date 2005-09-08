Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932580AbVIHPkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932580AbVIHPkL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 11:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932708AbVIHPkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 11:40:11 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:9608 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932580AbVIHPkJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 11:40:09 -0400
Subject: Re: [PATCH] add stricmp
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jan Beulich <JBeulich@novell.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <432074B302000078000244A3@emea1-mh.id2.novell.com>
References: <43206F420200007800024455@emea1-mh.id2.novell.com>
	 <20050908151754.GB11067@infradead.org>
	 <432074B302000078000244A3@emea1-mh.id2.novell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Thu, 08 Sep 2005 17:04:49 +0100
Message-Id: <1126195489.19834.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-09-08 at 17:28 +0200, Jan Beulich wrote:
> Then how am I supposed to do ASCII-only case-insensitive compares (i.e.
> reading config files)? And why is there a strnicmp? If this is not going

There is no such thing as "ascii" for case sensitivity. The case and
ordering rules are locale not symbol set based and they also depend
totally on the exact semantics of whatever legacy technology you are
interfacing with. I assume you mean "C locale, ascii character set",
which limits your debugger to speaking a subset of American English (no
café or naïve 8))

Any routine of that nature belongs in the user environment to which it
applies, and should be used with care, and preferably pushed to user
space or to a user app on the debug hosting box as kgdb does.

The only general, usable strnicmp safe for general kernel use would be a
full all singing all dancing UTF-8 symbol aware arbitary locale
implementation. And that we *definitely* do not want in kernel.

Alan

