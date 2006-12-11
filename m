Return-Path: <linux-kernel-owner+w=401wt.eu-S937577AbWLKTMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937577AbWLKTMs (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 14:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937579AbWLKTMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 14:12:48 -0500
Received: from smtp.osdl.org ([65.172.181.25]:55508 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937577AbWLKTMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 14:12:47 -0500
Date: Mon, 11 Dec 2006 11:11:07 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Olaf Hering <olaf@aepfle.de>
cc: Paul Mackeras <paulus@samba.org>, Herbert Poetzl <herbert@13thfloor.at>,
       Andy Whitcroft <apw@shadowen.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-git13: uts banner changes break SLES9 (at least)
In-Reply-To: <20061211185536.GA19338@aepfle.de>
Message-ID: <Pine.LNX.4.64.0612111106310.12500@woody.osdl.org>
References: <457D750C.9060807@shadowen.org> <20061211163333.GA17947@aepfle.de>
 <Pine.LNX.4.64.0612110840240.12500@woody.osdl.org>
 <Pine.LNX.4.64.0612110852010.12500@woody.osdl.org> <20061211180414.GA18833@aepfle.de>
 <20061211181813.GB18963@aepfle.de> <Pine.LNX.4.64.0612111022140.12500@woody.osdl.org>
 <20061211182908.GC7256@MAIL.13thfloor.at> <Pine.LNX.4.64.0612111040160.12500@woody.osdl.org>
 <20061211185536.GA19338@aepfle.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Dec 2006, Olaf Hering wrote:
> 
> arch/powerpc/boot/wrapper:156:    version=`${CROSS}strings "$kernel" | grep '^Linux version [-0-9.]' | \

This is also obviously broken (and really sad), but actually ends up being 
better than what get_kernel_version apparently does, by at least adding 
the requirement that the string "Linux version" be slightly more correct.

However, it's also TOTALLY BROKEN. 

For example, if the Linux version string happens to be preceded by a byte 
that is a valid ASCII character, the grep will fail miserably. So that PoS 
is actually going to fail for various random kernels too, and depends 
intimately on just what variable _happened_ to be linked just before the 
version string.

The fact is, doing strings on the kernel is just not a viable alternative 
to real versioning.

			Linus
