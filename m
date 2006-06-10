Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751551AbWFJQYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbWFJQYO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 12:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751550AbWFJQYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 12:24:14 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:53337 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1751193AbWFJQYN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 12:24:13 -0400
Message-ID: <448AF226.7060003@tls.msk.ru>
Date: Sat, 10 Jun 2006 20:24:06 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: klibc - another libc?
References: <44869397.4000907@tls.msk.ru> <Pine.LNX.4.64.0606080036250.17704@scrub.home> <e69fu3$5ch$1@terminus.zytor.com> <Pine.LNX.4.64.0606091409220.17704@scrub.home> <e6cgjv$b8t$1@terminus.zytor.com> <4489C83F.40307@tls.msk.ru> <Pine.LNX.4.64.0606100316400.17704@scrub.home>
In-Reply-To: <Pine.LNX.4.64.0606100316400.17704@scrub.home>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> Hi,
> 
> On Fri, 9 Jun 2006, Michael Tokarev wrote:
> 
>> But I see a reason for kinit *now*, in its current form - it's
>> compatibility.  Later on, maybe the whole stuff can be removed entirely,
>> to rely on external tools for booting.
> 
> The compatibility code is already in the kernel, just don't call it if 

Isn't kinit/klibc intended to *replace* that whole code in the kernel?

> e.g. there's a /kinit in initramfs. We can add the hooks to the kernel to 
> pull whatever you want into the initramfs and with time we can remove 
> the old code.
> Why create new (temporary?) compatibility code, if the current code is 
> working just fine?

That was partly my question (or something I had in mind but didn't ask).

Well.  It's interesting.

Embedded folks are using uclibc or dietlibc - i see no reason for another
"more small" libc for booting, regular tools (linked against uc or diet)
can be used just fine.

Big systems will usually require some "advanced" stuff like that same
mdadm or lvm - and again, I don't see why regular glibc can't be used
(wich has an advandage - no need to have two versions of the toolset,
linked with klibc and glibc).

The only real reason I see in klibc is to be able to remove all that
'kinit' code from kernel but still be compatible - so that I will
be able to download linux-2.7, make oldconfig all install, and it
Will Just Work (in case I had no initrd/initramfs) - new userspace
kinit will take care of everything removed from kernel code.

In the other words, i see the whole klibc thing as a temporary
compatibility solution.

Did I miss something?

And yes, it's a PITA to have two sets of all the system utilities -
I'd not go this route.  Also, since klibc will have compatibility
problems with kernel API changes, such a 'parallel toolset' needs
to be recompiled on a regular basis, which means not two toolsets,
but many of them (one 'main', and several 'small for boot', for
different kernel versions, linked against different klibc-XXX.so).

The only problem I see with using glibc in initramfs is -- systems
with small amount of memory, where full-blown glibc with all the
required tools will just not fit into ramfs/tmpfs.  Not "embedded"
systems (like boxed routers for example - they're already using
something much more compact than glibc).  Are there such systems
out there still?

/mjt
