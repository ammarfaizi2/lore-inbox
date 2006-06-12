Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbWFLJRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWFLJRz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 05:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbWFLJRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 05:17:55 -0400
Received: from jaguar.mkp.net ([192.139.46.146]:40117 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S1751224AbWFLJRy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 05:17:54 -0400
To: Chase Venters <chase.venters@clientec.com>
Cc: Chris Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org
Subject: Re: cacheline alignment and per-cpu data
References: <44899681.6070003@nortel.com>
	<Pine.LNX.4.64.0606091054180.4969@turbotaz.ourhouse>
From: Jes Sorensen <jes@sgi.com>
Date: 12 Jun 2006 05:17:53 -0400
In-Reply-To: <Pine.LNX.4.64.0606091054180.4969@turbotaz.ourhouse>
Message-ID: <yq0mzci3f7i.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Chase" == Chase Venters <chase.venters@clientec.com> writes:

Chase> On Fri, 9 Jun 2006, Chris Friesen wrote:
>> Will this cause cacheline pingpong?  If I do this sort of thing do
>> I need to ensure that the struct is a multiple of cacheline size
>> (or specify cacheline alignement)?

Chase> Yes. If CPU 2 tries to write to struct member 1 of array
Chase> element 2, and array element 1 is in CPU 1's cache, it must be
Chase> invalidated.

Chase> GCC (and kernel macros) provide good support for enforced
Chase> cacheline alignment, but it's also possible to pad your
Chase> structures.

Best way to go is to use __cacheline_aligned rather than try to get
the padding right manually. Someone will add a field somewhere in the
middle and mess it up and nobody notices.

Cheers,
Jes
