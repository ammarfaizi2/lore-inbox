Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbWISPDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWISPDo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 11:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbWISPDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 11:03:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53644 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750781AbWISPDn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 11:03:43 -0400
Date: Tue, 19 Sep 2006 08:03:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 5/7] Alter get_order() so that it can make use of
 ilog2() on a constant [try #3]
Message-Id: <20060919080324.601e50f9.akpm@osdl.org>
In-Reply-To: <23843.1158656897@warthog.cambridge.redhat.com>
References: <20060919003031.166d08a4.akpm@osdl.org>
	<20060913183522.22109.10565.stgit@warthog.cambridge.redhat.com>
	<20060913183531.22109.85723.stgit@warthog.cambridge.redhat.com>
	<23843.1158656897@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2006 10:08:17 +0100
David Howells <dhowells@redhat.com> wrote:

> > I didn't pursue it further, because sprinkling ARCH_HAS_FOO things into
> > bitops.h(!) is all rather hacky.  Better to use CONFIG_* so they're always
> > visible and one knows where to go to find things.
> 
> But (1) they're not config options,

Well they are, really.  "This architecture has its own get_order()".  It's
not *user* configurable, but neither is, say CONFIG_GENERIC_HARDIRQS.

The problem we have with the ARCH_HAS_FOO things is that there's never been
an include/asm/arch_has_foo.h in which to define them, so stuff gets
sprinkled all over the place.

> and (2) there's plenty of precedent for
> this sort of thing (ARCH_HAS_PREFETCH for example).

There's precedent both ways.  The advantages of doing it in config are

a) You know where to go to find it: arch/foo/Kconfig

b) It's always available, due to forced inclusion of config.h.

(I think I actually would prefer include/asm/arch_has_foo.h if we had it,
because it's lighter-weight.  But we don't)
