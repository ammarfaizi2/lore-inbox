Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287279AbSALS3L>; Sat, 12 Jan 2002 13:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287283AbSALS24>; Sat, 12 Jan 2002 13:28:56 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:42506 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S287279AbSALS2m>;
	Sat, 12 Jan 2002 13:28:42 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200201121828.g0CISaM342258@saturn.cs.uml.edu>
Subject: Re: [PATCH] 1-2-3 GB
To: andrea@suse.de (Andrea Arcangeli)
Date: Sat, 12 Jan 2002 13:28:36 -0500 (EST)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), hpa@zytor.com (H. Peter Anvin),
        linux-kernel@vger.kernel.org
In-Reply-To: <20020112184216.U1482@inspiron.school.suse.de> from "Andrea Arcangeli" at Jan 12, 2002 06:42:16 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli writes:
> On Sat, Jan 12, 2002 at 12:26:35PM -0500, Albert D. Cahalan wrote:

>> The numbers are wrong anyway, because of vmalloc() and PCI space.
>> The PCI space is motherboard-dependent AFAIK, but you could at
>> least account for the 128 MB vmalloc() area:
>
> looks dirty, the size of the kernel direct mapping is mainly in function
> of #defines that can be changed freely, they're not constant in function
> of CONFIG_1G etc.. and it changes also in function of smp/up/4G/64G
> options.  The 3GB/2GB/1GB/3.5GB visible into the menuconfig are exact
> instead.  So I wouldn't mention inprecise stuff that can changed under
> us (and the exact size of the kernel direct mapping doesn't matter to
> the user anyways I think [and if it matters I think it means he's
> skilled enough to know about vmalloc space ;) ]).

The problem is that the "1GB" option doesn't cover 1 GB.
It is common for people to buy 1 GB of memory (power of 2),
and then complain that Linux only sees 896 MB of memory.

So how will you make the choices clear to such people?
There are 3 options, not counting the slram block device:

a. give up 128 MB (12.5 %) of memory
b. suffer the kmap overhead
c. give up some user virtual address space

None of this is obvious. The user sees "1GB" and will
innocently believe that this is good for a 1 GB system!

BTW, do we no longer require that the kernel side of things
(whole thing, including vmalloc space) be a power of two?
There used to be a bitwise operation in the user access stuff.
