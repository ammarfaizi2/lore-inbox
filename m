Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265087AbUHAMlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265087AbUHAMlF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 08:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265144AbUHAMlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 08:41:05 -0400
Received: from holomorphy.com ([207.189.100.168]:166 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265087AbUHAMlC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 08:41:02 -0400
Date: Sun, 1 Aug 2004 05:40:53 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH][2.6] first/next_cpu returns values > NR_CPUS
Message-ID: <20040801124053.GS2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@linuxpower.ca>, Paul Jackson <pj@sgi.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <Pine.LNX.4.58.0407311347270.4094@montezuma.fsmlabs.com> <20040731232126.1901760b.pj@sgi.com> <Pine.LNX.4.58.0408010316590.4095@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408010316590.4095@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 01, 2004 at 03:22:56AM -0400, Zwane Mwaikambo wrote:
> NR_CPUS was 3, the test case may as well be passing first_cpu or next_cpu
> a value of 0 for the map. The "bug" in the i386 find_next_bit really
> looks like a feature if you look at the code.

Hmm. I'm actually somewhat puzzled by this also. Shouldn't things only
check for inequalities between the results of these and NR_CPUS? i.e.
things like:
	if (any_online_cpu(cpus) >= NR_CPUS)
and
	for (cpu = first_cpu(cpus); cpu < NR_CPUS; cpu = next_cpu(cpus))
etc.?

Maybe the few callers that are sensitive to the precise return value
should use min_t(int, NR_CPUS, ...) instead of all callers taking the
branch on behalf of those few.


-- wli
