Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270821AbTHLQu0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 12:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270847AbTHLQu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 12:50:26 -0400
Received: from fw1.masirv.com ([65.205.206.2]:60749 "EHLO NEWMAN.masirv.com")
	by vger.kernel.org with ESMTP id S270821AbTHLQuX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 12:50:23 -0400
Message-ID: <1060653695.5293.65.camel@huykhoi>
From: Anthony Truong <Anthony.Truong@mascorp.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christian Mautner <linux@mautner.ca>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4: Allocation of >1GB in one chunk
Date: Mon, 11 Aug 2003 19:01:35 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-12 at 18:00, Geert Uytterhoeven wrote:

On Mon, 11 Aug 2003, Christian Mautner wrote:
> please forgive me to ask this (perhaps newbie?) question here on
> l-k, but I'm desperate. This is my problem:
> 
> I am running various kinds of EDA software on 32-bit Linux, and they
> need substantial amounts of memory. I am running 2.4.21 with with
> PAGE_OFFSET at 0xc0000000, so I can run processes just over 3GB. The
> machine (a dual Xeon) has 4GB memory and 4GB swap.
> 
> But there is this one program now that dies because it's out of
> memory. No surprise, as this happens frequently with tasks that would
> need 4GB or more.
> 
> But this one needs less than 3GB. But what it does need (I strace'ed
> this), is 1.3GB in one whole chunk.
> 
> I wrote a test program to mimic this:
> 
> The attached program allocates argv[1] MB in 1MB chunks and argv[2] MB
> in one big chunk. (The original version also touched every page, but
> this makes no difference here.)
> 
> [chm@trex7:~/C] ./foo 2500 500
> Will allocate 2621440000 bytes in 1MB chunks...
> Will allocate 524288000 bytes in one chunk...
> Succeeded.
> 
> [chm@trex7:~/C] ./foo 1500 1000
> Will allocate 1572864000 bytes in 1MB chunks...
> Will allocate 1048576000 bytes in one chunk...
> malloc: Cannot allocate memory
> Out of memory.
> 
> The first call allocated 3GB and succeeds, the second one only 2.5GB
> but fails!
> 
> The thing that comes to my mind is memory fragmentation, but how could
> that be, with virtual memory? 

Virtual memory fixes physical memory fragmentation only. I.e. you can
`glue'
multiple physical chunks together into one large virtual chunk.

Biut you're still limited to a 32-bit virtual address space (3 GB in
user
space). If this virtual 3 GB gets fragmented, you're still out of luck.

To check this, print all allocated virtual addresses, or look at
/proc/<pid>/maps, and see why it fails.

Gr{oetje,eeting}s,

                                                Geert


Hello,
There is indeed fragmentation problem even with virtual memory address
space.  I think in the second foo call, Christian might have run into
this fragmentation problem.

Regards,
Anthony Dominic Truong.




Disclaimer: The information contained in this transmission, including any
attachments, may contain confidential information of Matsushita Avionics
Systems Corporation.  This transmission is intended only for the use of the
addressee(s) listed above.  Unauthorized review, dissemination or other use
of the information contained in this transmission is strictly prohibited.
If you have received this transmission in error or have reason to believe
you are not authorized to receive it, please notify the sender by return
email and promptly delete the transmission.


