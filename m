Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262015AbVBPOBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbVBPOBL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 09:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262017AbVBPOBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 09:01:11 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:62638 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262015AbVBPOBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 09:01:06 -0500
To: Itsuro Oda <oda@valinux.co.jp>
Cc: fastboot <fastboot@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] /proc/cpumem
References: <20050203154433.18E4.ODA@valinux.co.jp>
	<m14qgu81bw.fsf@ebiederm.dsl.xmission.com>
	<20050216170224.4C66.ODA@valinux.co.jp>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 16 Feb 2005 06:58:32 -0700
In-Reply-To: <20050216170224.4C66.ODA@valinux.co.jp>
Message-ID: <m1hdkcvc6v.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Itsuro Oda <oda@valinux.co.jp> writes:

> Hi, Eric and all
> 
> Attached is an implementation of /proc/cpumem.
> /proc/cpumem shows the valid physical memory ranges.

Interesting.  My imagination when I proposed this
was something based on struct resource that works
like /proc/iomem on x86 but can be meaningfully
be used on systems with where ram lives in a separate
address space from io device memory.

> example: amd64 8GB Mem
> # cat /proc/cpumem
> 0000000000000000 000000000009b800
> 0000000000100000 00000000fbe70000
> 0000000100000000 0000000100000000
> #
> start address and size. hex digit.

The lack of a type field looses a fair amount of functionality compared
to /proc/iomem.  In particular you can't see where the ACPI data is.

The other direction something like this can go is to dump 
the data structures in linux/mmzone.h 
 
> Any comments, recomendations and suggestions are welcom.
> 
> BTW, does not kexec/kdump run on 2.6.11-rc3-mm2 ?
> How do I get and examine the latest kexec/kdump ?

I'm not quite certain what is happening.

I have been playing with kexec user space a little bit and a new 
development release is at:
http://www.xmission.com/~ebiederm/files/kexec/kexec-tools-1.101.tar.gz

I have written a first pass at a user space core dump generator,
using /dev/mem.  /sbin/kexec still needs some work to prepare
the ELF headers before a crash.

Eric
