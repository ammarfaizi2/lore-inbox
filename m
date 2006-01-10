Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWAJQH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWAJQH6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 11:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWAJQH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 11:07:57 -0500
Received: from mx.pathscale.com ([64.160.42.68]:33685 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932100AbWAJQH4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 11:07:56 -0500
Subject: Re: [PATCH 1 of 3] Introduce __raw_memcpy_toio32
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: sam@ravnborg.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <adaslrw3zfu.fsf@cisco.com>
References: <patchbomb.1136579193@eng-12.pathscale.com>
	 <d286502c3b3cd6bcec7b.1136579194@eng-12.pathscale.com>
	 <20060110011844.7a4a1f90.akpm@osdl.org>  <adaslrw3zfu.fsf@cisco.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Tue, 10 Jan 2006 08:07:56 -0800
Message-Id: <1136909276.32183.28.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-10 at 06:55 -0800, Roland Dreier wrote:

> That is a good question, especially since the optimized
> x86_64-specific version is out-of-line.  I suspect the answer is
> mainly that that's the easiest way to stick it in a header in
> include/asm-generic.

Yes, this is correct.

> I think it would be worth working a little
> harder and making the generic version out-of-line.

I'm fine with doing that, but I wonder what an appropriate way to do it
would be.

Really, we'd like the generic implementation to be declared in
asm-generic and defined in lib.  Each arch that needed the generic
version could then have its arch/XXX/lib/Makefile modified to pull in
the generic version from lib, while arches that had special versions
could remain unencumbered.

The only problem with this is that it's an unusual approach, so I don't
have any obvious examples to copy.  The closest I can think of is
arch/x86_64/kernel/Makefile, which pulls in routines from the i386 tree
like this:

        bootflag-y += ../../i386/kernel/bootflag.o

So say arch/ia64/lib/Makefile, for example, could have a line like this:

     obj-y += ../../../lib/raw_memcpy_toio32.o

Sam, do you think this is safe to do in generalwith respect to kbuild?

Additionally, does it meet everyone's needs in terms of being generic,
safe, in good style, and keeping bloat to a minimum?

	<b

