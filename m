Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262572AbTJJOvm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 10:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262850AbTJJOvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 10:51:42 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:47243 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262572AbTJJOvk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 10:51:40 -0400
Date: Fri, 10 Oct 2003 15:51:37 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2.4] EDD 4-byte MBR disk signature for the boot disk
Message-ID: <20031010145137.GC28795@mail.shareable.org>
References: <Pine.LNX.4.44.0310100903360.2846-100000@iguana.domsch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310100903360.2846-100000@iguana.domsch.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Domsch wrote:
>   There are 4 bytes in the MSDOS master boot record, at offset 0x228,
>   which may contain a per-system-unique signature.  By writing into this
>   signature from a tool that makes real-mode int13 calls a unique
>   signature such as "BOOT" for the boot disk (int13 dev 80h), Linux may
>   then retrieve this information and use it to compare against disks it
>   knows as named /dev/[hs]d[a-z].

If I put a hard disk from another system into my computer, and it has
the "BOOT" signature, Linux will see two disks with the signature.  Barf!

Same if I boot from two different disks at different times, and more
so if one of them fails to boot properly so that it's not even
possible for the booted kernel to erase the signature on its boot
disk.

It would be better to have the boot loader pick a likely-unique number
such as the CMOS time in seconds since whenever and store that, and
pass it as boot parameter to the kernel.  A few bits could be reserved
to indicate that it was from our boot loaders; it would be good if we
had a list of existing per-system-unique signatures to avoid.  Do you
know of such a list?

-- Jamie
