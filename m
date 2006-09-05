Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161024AbWIEUHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161024AbWIEUHu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 16:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161025AbWIEUHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 16:07:49 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:2320 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1161024AbWIEUHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 16:07:49 -0400
Subject: Re: lockdep oddity
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>,
       Hua Zhong <hzhong@gmail.com>
In-Reply-To: <20060905130356.GB6940@osiris.boeblingen.de.ibm.com>
References: <20060901015818.42767813.akpm@osdl.org>
	 <20060905130356.GB6940@osiris.boeblingen.de.ibm.com>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 13:07:47 -0700
Message-Id: <1157486867.22250.9.camel@dwalker1.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-05 at 15:03 +0200, Heiko Carstens wrote:

> 
> Found this will debugging some random memory corruptions that happen when
> CONFIG_PROVE_LOCKING and CONFIG_PROFILE_LIKELY are both on.
> Switching both off or having only one of them on seems to work.

There's potential for a some issues in current -mm , given the config
above. If you us the generic atomic operations
(asm-generic/bitops/atomic.h) for test_and_set_bit(). It eventually
calls into trace_hardirqs_off() and then back into likely profiling. 

What architecture are you running this on?

Daniel

