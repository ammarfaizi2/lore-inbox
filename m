Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759305AbWLARjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759305AbWLARjt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 12:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759306AbWLARjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 12:39:49 -0500
Received: from hiauly1.hia.nrc.ca ([132.246.100.193]:7174 "EHLO
	hiauly1.hia.nrc.ca") by vger.kernel.org with ESMTP id S1759305AbWLARjt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 12:39:49 -0500
Message-Id: <200612011738.kB1HcGwo006938@hiauly1.hia.nrc.ca>
Subject: Re: [parisc-linux] Re: [2.6 patch] parisc: "extern inline" -> "static
To: grundler@parisc-linux.org (Grant Grundler)
Date: Fri, 1 Dec 2006 12:38:16 -0500 (EST)
From: "John David Anglin" <dave@hiauly1.hia.nrc.ca>
Cc: bunk@stusta.de, akpm@osdl.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, kyle@parisc-linux.org,
       parisc-linux@parisc-linux.org
In-Reply-To: <20061201164354.GA10549@colo.lackof.org> from "Grant Grundler" at Dec 1, 2006 09:43:54 am
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The parisc point intentionally switched to "extern inline" at one
> point and unless what jda wrote is now incorrect, I'm not inclined
> to change it.

The handling of "extern inline" is changing in GCC 4.3 to the C99 specified
behavior.  The attribute gnu_inline on an inline declaration results in the
old GNU C89 inline behavior even in the ISO C99 mode.

The C99 behavior allows the function being inlined to be externally
called.  As a result, conflicts will occur if the function is defined in
a header included by multiple objects.  So, code that assumed the previous
GNU treatment unfortunately needs to change.

The main difference between "static inline" and "extern inline" in the
old GNU treatment was that with "extern inline" the function was never
compiled on its own, even if its address was explicitly referenced.
With "static inline", the function would be compiled on its own in some
circumstances.  So, this is mostly a code size issue.

More details are present in extend.texi in the GCC head.  This has also
been discussed on the gcc list a few times.

Dave
-- 
J. David Anglin                                  dave.anglin@nrc-cnrc.gc.ca
National Research Council of Canada              (613) 990-0752 (FAX: 952-6602)
