Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751615AbWIFHTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615AbWIFHTF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 03:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751609AbWIFHTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 03:19:05 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:48625 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932119AbWIFHTE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 03:19:04 -0400
Date: Wed, 6 Sep 2006 09:18:27 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Daniel Walker <dwalker@mvista.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>,
       Hua Zhong <hzhong@gmail.com>
Subject: Re: lockdep oddity
Message-ID: <20060906071827.GB6898@osiris.boeblingen.de.ibm.com>
References: <20060901015818.42767813.akpm@osdl.org> <20060905130356.GB6940@osiris.boeblingen.de.ibm.com> <1157486867.22250.9.camel@dwalker1.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157486867.22250.9.camel@dwalker1.mvista.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2006 at 01:07:47PM -0700, Daniel Walker wrote:
> On Tue, 2006-09-05 at 15:03 +0200, Heiko Carstens wrote:
> > Found this will debugging some random memory corruptions that happen when
> > CONFIG_PROVE_LOCKING and CONFIG_PROFILE_LIKELY are both on.
> > Switching both off or having only one of them on seems to work.
> 
> There's potential for a some issues in current -mm , given the config
> above. If you us the generic atomic operations
> (asm-generic/bitops/atomic.h) for test_and_set_bit(). It eventually
> calls into trace_hardirqs_off() and then back into likely profiling. 
> 
> What architecture are you running this on?

This was s390. We have our own bitops and trace_hardirqs_off() won't
be called for test_and_set_bit(). Must be something different.
