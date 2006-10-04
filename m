Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161097AbWJDHL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161097AbWJDHL4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 03:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030461AbWJDHL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 03:11:56 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:27809 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030456AbWJDHLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 03:11:55 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: vgoyal@in.ibm.com
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, horms@verge.net.au, lace@jankratochvil.net,
       hpa@zytor.com, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com, maneesh@in.ibm.com
Subject: Re: [PATCH 12/12] i386 boot: Add an ELF header to bzImage
References: <20061003170032.GA30036@in.ibm.com>
	<20061003172511.GL3164@in.ibm.com>
Date: Wed, 04 Oct 2006 01:08:56 -0600
In-Reply-To: <20061003172511.GL3164@in.ibm.com> (Vivek Goyal's message of
	"Tue, 3 Oct 2006 13:25:11 -0400")
Message-ID: <m11wpoeewn.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> writes:

> Increasingly the cobbled together boot protocol that
> is bzImage does not have the flexibility to deal
> with booting in new situations.
>
> Now that we no longer support the bootsector loader
> we have 512 bytes at the very start of a bzImage that
> we can use for other things.
>
> Placing an ELF header there allows us to retain
> a single binary for all of x86 while at the same
> time describing things that bzImage does not allow
> us to describe.
>
> The existing bugger off code for warning if we attempt to
> boot from the bootsector is kept but the error message is
> made more terse so we have a little more room to play with.

Vivek for this first round can we please take out the ELF
note processing.  Now that vmlinux has ELF notes of interest
to the bootloader we really should be getting the ELF notes
from there.

So the generation of the ELF notes needs to move into the
vmlinux and then we need to copy them to ELF header.

If we just remove the ELF note munging code from this patch
that should be a good first step in getting the ELF notes correct.

Eric
