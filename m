Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422744AbWGNUFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422744AbWGNUFU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 16:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422745AbWGNUFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 16:05:20 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:30148 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1422744AbWGNUFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 16:05:18 -0400
Subject: [PATCH 00/02] remove set_wmb
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, mingo@elte.hu,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       David Howells <dhowells@redhat.com>
In-Reply-To: <20060714105841.4490c0e2.akpm@osdl.org>
References: <1152882288.1883.30.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0607140757080.5623@g5.osdl.org>
	 <Pine.LNX.4.64.0607141017520.5623@g5.osdl.org>
	 <1152898699.27135.20.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0607141040550.5623@g5.osdl.org>
	 <20060714105841.4490c0e2.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 16:04:57 -0400
Message-Id: <1152907497.27135.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

set_wmb(var, value) is not used anywhere in the kernel. And it doesn't
do anything special but shorten the typing of:

  var = value;
  wmb();

Which the above is much more readable, and thus set_wmb is just
something to confuse developers even more.

So this patch series removes set_wmb from the kernel.  It's not
currently used in the kernel, and any out-of-kernel branch can easily
replace it.  So there should be no harm in removing it.

The first patch removes it from Documentation/memory-barriers.txt and
the second patch does a sweep through all the architectures to get rid
of it.  All archs do the above code except ia64 and sparc which do a
mb() instead.  But regardless, it's still not used.

-- Steve

