Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264142AbTLVCOx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 21:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbTLVCOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 21:14:53 -0500
Received: from holomorphy.com ([199.26.172.102]:16543 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264142AbTLVCOw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 21:14:52 -0500
Date: Sun, 21 Dec 2003 18:14:18 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Ingo Oeser <ioe-lkml@rameria.de>
Subject: Re: [PATCH] another minor bit of cpumask cleanup
Message-ID: <20031222021418.GA27687@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, Andrew Morton <akpm@osdl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ingo Oeser <ioe-lkml@rameria.de>
References: <20031221180044.0f27eca1.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031221180044.0f27eca1.pj@sgi.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 21, 2003 at 06:00:44PM -0800, Paul Jackson wrote:
> Looking further, I see this macro is never used, and its subordinate
> inline macro next_online_cpu() used no where else.  What's more, it's
> redundant.  Calling it with a map of "cpu_online_map" (which you have to
> do, given it's broken thus) is just as good as calling the macro right
> above, "for_each_cpu()", with that same "cpu_online_map". Indeed the
> only uses of "for_each_cpu()", in arch/i386/mach-voyager/voyager_smp.c,
> do pass "cpu_online_map" explicitly, in 5 of 6 calls there from.

Callers couldn't be converted without risking a "cleanup factor". It's
not terribly surprising some issue might appear since it wasn't used.

I don't honestly care if it lives or dies; it appeared to make more
sense as a generic macro than a voyager-specific macro at the time.


-- wli
