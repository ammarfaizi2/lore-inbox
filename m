Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263212AbTE3Dus (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 23:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263234AbTE3Dus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 23:50:48 -0400
Received: from mx1.elte.hu ([157.181.1.137]:701 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263212AbTE3Dur (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 23:50:47 -0400
Date: Fri, 30 May 2003 06:02:18 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Scott A Crosby <scrosby@cs.rice.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Algoritmic Complexity Attacks and 2.4.20 the dcache code
In-Reply-To: <oydbrxlbi2o.fsf@bert.cs.rice.edu>
Message-ID: <Pine.LNX.4.44.0305300550130.3609-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 29 May 2003, Scott A Crosby wrote:

> I have confirmed via an actual attack that it is possible to force the
> dcache to experience a 200x performance degradation if the attacker can
> control filenames. On a P4-1.8ghz, the time to list a directory of
> 10,000 files is 18 seconds instead of .1 seconds.

are you sure this is a big issue? Kernel 2.0 (maybe even 2.2) lists 10,000
files at roughly the same speed (18 seconds) without any attack pattern
used for filenames - still it's a kernel being used.

the network hash collision was a much more serious issue, because it could
be triggered externally, could be maintained with a relatively low input
packet flow, and affected all users of the network stack.

also, directories with 10,000 files are not quite common on systems where
there is a trust problem between users. So a typical directory with say
100 files will be listed in 0.18 seconds - it's slower, but does not make
the system unusable.

also, dcache flushes happen quite frequently under VM pressure - and
especially when using many files you get VM pressure. So it would take a
really specialized attack to keep the dcache size at the critical level
and trigger the slowdown.

also, any local user who can create thousands of files can cause much more
havoc by simply overloading the system. You might as well use that CPU
time to really bog down the system by making it swap heavily - this will
cause a _much_ heavier slowdown.

	Ingo

