Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbUJ3N5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbUJ3N5Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 09:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbUJ3N5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 09:57:25 -0400
Received: from cantor.suse.de ([195.135.220.2]:42900 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261176AbUJ3N5T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 09:57:19 -0400
To: Dave Airlie <airlied@gmail.com>
Cc: linux-kernel@vger.kernel.org, eich@suse.de
Subject: Re: status of DRM_MGA on x86_64
References: <1099052450.11282.72.camel@hostmaster.org.suse.lists.linux.kernel.suse.lists.linux.kernel>
	<1099061384.11918.4.camel@hostmaster.org.suse.lists.linux.kernel.suse.lists.linux.kernel>
	<41829E39.1000909@us.ibm.com.suse.lists.linux.kernel.suse.lists.linux.kernel>
	<1099097616.11918.26.camel@hostmaster.org.suse.lists.linux.kernel.suse.lists.linux.kernel>
	<p734qkd0y0n.fsf@verdi.suse.de.suse.lists.linux.kernel>
	<21d7e99704103004155d2826fb@mail.gmail.com.suse.lists.linux.kernel>
	<21d7e997041030041748b60ce7@mail.gmail.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 30 Oct 2004 15:57:18 +0200
In-Reply-To: <21d7e997041030041748b60ce7@mail.gmail.com.suse.lists.linux.kernel>
Message-ID: <p73k6t8z4u9.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Airlie <airlied@gmail.com> writes:

> sorry missed the list....
> 


Ok my answers again.
 
> > It was solved long ago for the Radeon driver by Egbert Eich.
> > But for some unknown reason the DRI people never merged his patches.
> 
> Because no-one agreed that his solution was clean enough for use,
> no-one contributed well described patches of the separate pieces to
> drm or dri,
> 
> At the moment any solution to the 32/64-bit DRI will either break pure
> 64-bit systems or break 32/64-bit mixed systems, nobody has stepped
> forward and said that either of these are acceptable,

In short I think it doesn't make sense. There is enough existence
proof that you can write working 32bit emulation layers without
breaking any backwards compatibility. From my experiences with Egberts
patches there are also no compatibility problems.

You pay some cost for the conversion, but it tends to be not significant
(iirc from Egbert's results the non native case was not significantly
slower in ViewPerf)

Some people have attempted to design biarch ABIs in the past
for new interfaces, but more often than not they got it wrong in some
subtle detail and in the end you had to convert anyways. 

> and no drm
> developer has the hardware to work on it,

Well, Egbert has and he wrote the code.

There is a working patch that you just need to apply, isn't there?

> This 64-bit vs 32/64-bit stuff has been on my drm todo list for ages
> but I've neither received clean patches or someone who has the test
> environment to convince me that breaking one or other of the currently
> working systems is acceptable... 

Again you don't need to break anything. You just convert the ABI.

As a short layman's introduction on how Linux 32bit compatibility
works see http://www.firstfloor.org/~andi/writing-ioctl32
(some details are unfortunately outdated for 2.6, but you'll get
the high level view) 

-Andi
