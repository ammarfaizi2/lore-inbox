Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265635AbRGCIqm>; Tue, 3 Jul 2001 04:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265629AbRGCIqc>; Tue, 3 Jul 2001 04:46:32 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:44003 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S265624AbRGCIqY>; Tue, 3 Jul 2001 04:46:24 -0400
Date: Tue, 3 Jul 2001 04:46:15 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix kernel linker scripts
Message-ID: <20010703044615.P32061@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <20010702115351.B11623@devserv.devel.redhat.com> <813.994133208@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <813.994133208@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Tue, Jul 03, 2001 at 02:06:48PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2001 at 02:06:48PM +1000, Keith Owens wrote:
> On Mon, 2 Jul 2001 11:53:51 -0400, 
> Jakub Jelinek <jakub@redhat.com> wrote:
> >Apparently all kernel scripts only have .rodata and not also .rodata.* input
> >sections in it.
> >-  .rodata : { *(.rodata) }
> >+  .rodata : { *(.rodata) *(.rodata.*) }
> 
> Any reason not to use *(.rodata*) to cover all rodata sections?  I see
> no need for two input definitions, one works for me.

The reason why I wrote it this way is so that it matches default ld linker
scripts:
...
  .rodata   : { *(.rodata) *(.rodata.*) *(.gnu.linkonce.r.*) }
  .rodata1   : { *(.rodata1) }
...
Of course, *(.rodata*) would work as well and provided nobody creates
sections like .rodatafoo, the behaviour would be the same as well.

	Jakub
