Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030379AbWARQ3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030379AbWARQ3t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 11:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030382AbWARQ3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 11:29:49 -0500
Received: from ns2.suse.de ([195.135.220.15]:13976 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030379AbWARQ3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 11:29:49 -0500
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <JBeulich@novell.com>
Subject: Re: [PATCH] CONFIG_UNWIND_INFO
Date: Wed, 18 Jan 2006 17:11:46 +0100
User-Agent: KMail/1.8.2
Cc: tony.luck@intel.com, "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       "Andrew Morton" <akpm@osdl.org>, "Paul Mackerras" <paulus@samba.org>,
       linux-kernel@vger.kernel.org
References: <4370AF4A.76F0.0078.0@novell.com> <20060118151816.GA82365@muc.de> <43CE73A0.76F0.0078.0@novell.com>
In-Reply-To: <43CE73A0.76F0.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601181711.47163.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 January 2006 16:58, Jan Beulich wrote:
> >The module loader should be discarding these sections on most architectures
> >because there is nothing that needs them and it's just a waste of memory
> >to store them.
> >
> >[IA64 might be an exception because they have a kernel level unwinder]
> >
> >So it would be best to change the module loader to do this I guess.
> 
> But that's why this is a config option: You can prevent the data from being created in the first place if you know you
> won't need it. 

The usual use case is that you only need it on disk for your gdb,
but not in RAM. And it now even causes problems like the missing
relocations on PPC64.

[Yes NLKD is not "usual" right now, sorry]

At some point it will change for x86-64 at least when the NLKD unwinder
is ported into the kernel (which I plan to do), but even then it won't
be needed for majority of architectures. Since IA64 likely will need
an exception mechanism for this anyways x86-64 could then later use it too.

> For nlkd, adding code to discard these sections despite CONFIG_UNWIND_INFO would only make for more 
> differences, because I'd then have to undo this discarding.

The interests of in tree usage normally beats caring for out of tree
patches.

-Andi
