Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264508AbSIQTAL>; Tue, 17 Sep 2002 15:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264509AbSIQTAL>; Tue, 17 Sep 2002 15:00:11 -0400
Received: from mail.libertysurf.net ([213.36.80.91]:54055 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S264508AbSIQTAG> convert rfc822-to-8bit; Tue, 17 Sep 2002 15:00:06 -0400
Date: Tue, 17 Sep 2002 22:48:56 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: groudier@localhost.my.domain
To: Todd Inglett <tinglett@vnet.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: sym53c8xx_2 and highmem_io
In-Reply-To: <1032198591.18300.22.camel@q.rchland.ibm.com>
Message-ID: <20020917223636.E4131-100000@localhost.my.domain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 16 Sep 2002, Todd Inglett wrote:

> I've been having an interesting experience getting sym53c8xx_2 working
> on ppc64 now that highio is in place.  Of course ppc64 doesn't need
> highio, and it does set blk_nohighio = 1 in setup_arch().  So the
> sym53c8xx driver works.
>
> However, sym53c8xx_2 fails because after calling scsi_register() in its
> attach it blindly slams highmem_io on (in sym_glue.c).  Is this
> correct?  It seems to me that it should just leave it alone since
> scsi_register already handled that.

The may-be offending line is not from me. It has been added by a kernel
maintainer at the time the corresponding feature ;-) was added to the
Linux kernel.

Note that this let me think that it may well have been correct at that
time, at least.;)

The greatest guru for all this kinds of alchemy that address complex
beyond expectation architectures is David S. Miller IMO. You may submit
him your suggestion or just sent it to the linux Kernel list.

> I might be misunderstanding something here.  Is there anything else a
> 64-bit arch must do for highio?  I found we also weren't setting max_pfn
> which seemed bad...though maybe irrelevant.

highio very probably addresses antic 32 bit archs that want to address
more than 4 GB of physical memory, thus Intel PAE band-aid to IA32.

> The trivial patch to fix it is attached, but I haven't tested it on a
> system that supports highio.

Nor I can, since such systems are too expensive for me and, on the other
hand, I don't need nor want to use such horrible hardware.

Regards,
  Gérard.

