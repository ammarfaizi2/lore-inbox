Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263900AbUCZL3j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 06:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264010AbUCZL3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 06:29:39 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:63180 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263900AbUCZL3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 06:29:37 -0500
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: trini@kernel.crashing.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040324195502.00a5b148.akpm@osdl.org>
References: <20040324235722.QDLK23486.fed1mtao04.cox.net@localhost.localdomain>
	 <20040324195502.00a5b148.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1080210253.29835.37.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Subject: Re: [patch 1/22] Add __early_param for all arches
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.2) 
Date: Fri, 26 Mar 2004 11:29:35 +0000
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-24 at 19:55 -0800, Andrew Morton wrote:
> Please tell us a little more about why we need these patches.  (Apart from
> what seems to be a moderate amount of code consolidation).

A lot of command line options need checking before we get out of
setup_arch() into start_kernel() where parse_cmdline() is currently
called.

In particular, the only thing stopping us from registering real
permanent consoles from the moment we hit setup_arch() is the fact that
we haven't yet handled 'console=' on the command line, and we end up
enabling the first console registered as if there's no console=
argument, _despite_ the fact that there _is_ such an argument.

> Also, what is different between __setup and __early_setup?  Why is it not
> possible to make __setup run sufficiently early for whatever application is
> requiring these changes?

Drivers may require allocation (bootmem not slab). We want to run before
that's feasible -- before 'mem=', by definition :)

There _are_ a lot of patches but most of them are trivial and were
separated just for cleanliness. Where they're non-trivial that's because
there's real consolidation.

-- 
dwmw2

