Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265792AbUHWQjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265792AbUHWQjM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 12:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265973AbUHWQhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 12:37:06 -0400
Received: from holomorphy.com ([207.189.100.168]:54404 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265805AbUHWQeP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 12:34:15 -0400
Date: Mon, 23 Aug 2004 09:27:35 -0700
From: wli@holomorphy.com
To: davidm@hpl.hp.com
Cc: Andrew Morton <akpm@osdl.org>, Jesse Barnes <jbarnes@engr.sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm3
Message-ID: <20040823162735.GB4418@holomorphy.com>
Mail-Followup-To: wli@holomorphy.com, davidm@hpl.hp.com,
	Andrew Morton <akpm@osdl.org>, Jesse Barnes <jbarnes@engr.sgi.com>,
	linux-kernel@vger.kernel.org
References: <20040820031919.413d0a95.akpm@osdl.org> <200408201144.49522.jbarnes@engr.sgi.com> <200408201257.42064.jbarnes@engr.sgi.com> <20040820115541.3e68c5be.akpm@osdl.org> <20040820200248.GJ11200@holomorphy.com> <16681.45746.300292.961415@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16681.45746.300292.961415@napali.hpl.hp.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2004 13:02:48 -0700, William Lee Irwin III said:
William> I suppose another way to answer the question of what's
William> going on is to fiddle with ia64's implementation of
William> profile_pc(). I suspect something like this may reveal the
William> offending codepaths.

On Mon, Aug 23, 2004 at 02:02:42AM -0700, David Mosberger wrote:
> You do realize that q-syscollect [1] can do this better for you
> without touching the kernel at all?
> [1] http://www.hpl.hp.com/research/linux/q-tools/

Never heard of it. Unfortunately, the issue I run into far more
frequently than tools not existing is users being unwilling or unable
to use them. In fact, it's even a relatively large hassle to get users
to boot with /proc/profile enabled regardless of its simplicity. For an
issue this common I would prefer that the most basic tools available
(i.e. the very few that are near-universal, e.g. readprofile(1) etc.)
report callers to spinlock contention by default.

That said, should other concerns override mine, and the decision is to
report the precise program counter for /proc/profile at all times for
all architectures, that decision would eliminate profile_pc() in favor
of instruction_pointer(), further consolidating /proc/profile code.


-- wli
