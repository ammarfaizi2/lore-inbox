Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266001AbUHAOub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266001AbUHAOub (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 10:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266004AbUHAOub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 10:50:31 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:65479 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266001AbUHAOuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 10:50:25 -0400
Date: Sun, 1 Aug 2004 10:54:03 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH][2.6] first/next_cpu returns values > NR_CPUS
In-Reply-To: <20040801124053.GS2334@holomorphy.com>
Message-ID: <Pine.LNX.4.58.0408011052090.4095@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0407311347270.4094@montezuma.fsmlabs.com>
 <20040731232126.1901760b.pj@sgi.com> <Pine.LNX.4.58.0408010316590.4095@montezuma.fsmlabs.com>
 <20040801124053.GS2334@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Aug 2004, William Lee Irwin III wrote:

> On Sun, Aug 01, 2004 at 03:22:56AM -0400, Zwane Mwaikambo wrote:
> > NR_CPUS was 3, the test case may as well be passing first_cpu or next_cpu
> > a value of 0 for the map. The "bug" in the i386 find_next_bit really
> > looks like a feature if you look at the code.
>
> Hmm. I'm actually somewhat puzzled by this also. Shouldn't things only
> check for inequalities between the results of these and NR_CPUS? i.e.
> things like:
> 	if (any_online_cpu(cpus) >= NR_CPUS)
> and
> 	for (cpu = first_cpu(cpus); cpu < NR_CPUS; cpu = next_cpu(cpus))
> etc.?
>
> Maybe the few callers that are sensitive to the precise return value
> should use min_t(int, NR_CPUS, ...) instead of all callers taking the
> branch on behalf of those few.

The problem is that next_cpu(0) will assign the incorrect value of '32'
to variable cpu so when you exit the loop, you'll have some silly number.
This really should be covered in the API, especially since that's what the
API states is the expected behaviour.
