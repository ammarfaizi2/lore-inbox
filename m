Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266285AbUBDEVp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 23:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266299AbUBDEVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 23:21:45 -0500
Received: from mail.shareable.org ([81.29.64.88]:39118 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266285AbUBDEVn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 23:21:43 -0500
Date: Wed, 4 Feb 2004 04:21:34 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Andi Kleen <ak@suse.de>
Cc: johnstul@us.ibm.com, drepper@redhat.com, linux-kernel@vger.kernel.org,
       andrea@suse.de
Subject: Re: [RFC][PATCH] linux-2.6.2-rc2_vsyscall-gtod_B1.patch
Message-ID: <20040204042134.GA20740@mail.shareable.org>
References: <1075344395.1592.87.camel@cog.beaverton.ibm.com.suse.lists.linux.kernel> <401894DA.7000609@redhat.com.suse.lists.linux.kernel> <20040201012803.GN26076@dualathlon.random.suse.lists.linux.kernel> <401F251C.2090300@redhat.com.suse.lists.linux.kernel> <20040203085224.GA15738@mail.shareable.org.suse.lists.linux.kernel> <20040203162515.GY26076@dualathlon.random.suse.lists.linux.kernel> <20040203173716.GC17895@mail.shareable.org.suse.lists.linux.kernel> <20040203181001.GA26076@dualathlon.random.suse.lists.linux.kernel> <20040203182310.GA18326@mail.shareable.org.suse.lists.linux.kernel> <p73znbzlgu3.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73znbzlgu3.fsf@verdi.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Executables are at fixed addresses.

No, they are not.

Look up PIE - Position Independent Executable.

That's the point: on a hardened system _all_ objects, executable and
libraries, are mapped at randomised addresses.  Therefore the simple
overwrite-return-address exploit is no longer reliable and tends to
crash the program.

That's what this desire for randomised VDSO address is all about.  The
executable and all the libraries are at random addresses in
security-hardened PIE systems.

(Actually even when executables are at fixed addresses, they can be
mapped at an address which is harder to exploit because the address
contains a zero byte - something which is harder to get into a buffer
overflow - but only a little harder).

[ Ulrich: I see randomised prelinking with PIE mentioned, to give
per-box random addresses instead of per process.  I guess I wasn't far
wrong in suggesting prelinked random VDSO positions :) ]

If you are not running PIE and randomised executable and library
positions, then I agree there is nothing to gain from varying the VDSO
position, and it is a slight performance loss so should be disabled.

-- Jamie
