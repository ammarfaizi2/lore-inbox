Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264599AbTLVWOx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 17:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264605AbTLVWOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 17:14:53 -0500
Received: from peabody.ximian.com ([141.154.95.10]:51930 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S264599AbTLVWOu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 17:14:50 -0500
Subject: Re: atomic copy_from_user?
From: Rob Love <rml@ximian.com>
To: Joe Korty <joe.korty@ccur.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20031222215933.GA3189@rudolph.ccur.com>
References: <1072054100.1742.156.camel@cube>
	 <20031222150026.GD27687@holomorphy.com>
	 <20031222182637.GA2659@rudolph.ccur.com> <1072126506.3318.31.camel@fur>
	 <20031222212237.GA2865@rudolph.ccur.com> <1072129210.3318.34.camel@fur>
	 <20031222215933.GA3189@rudolph.ccur.com>
Content-Type: text/plain
Message-Id: <1072131288.3318.48.camel@fur>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Mon, 22 Dec 2003 17:14:48 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-12-22 at 16:59, Joe Korty wrote:

>  I do not see why a non-preempt kernel would care at all about
> the value of preempt_count.  (kmap_atomic is obviously setting it,
> where is the place in a non-preempt kernel where the set value
> is being acted upon?).

Last I checked, the architecture-specific page fault handlers.  They do
something like:

	if (in_atomic())
		goto do_not_service_fault;

This let us implement the atomic copy_*_user() functions.

kmap_atomic() needs to mark the system atomic, so the in_atomic() will
fail.

This was done around ~2.5.30 by akpm.

	Rob Love


