Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129262AbQKGX7z>; Tue, 7 Nov 2000 18:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130325AbQKGX7q>; Tue, 7 Nov 2000 18:59:46 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:15114 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S130481AbQKGX7d>;
	Tue, 7 Nov 2000 18:59:33 -0500
Message-ID: <3A0896F3.AB36C3EE@mandrakesoft.com>
Date: Tue, 07 Nov 2000 18:57:39 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
CC: kernel@kvack.org, Martin Josefsson <gandalf@wlug.westbo.se>,
        Tigran Aivazian <tigran@veritas.com>, Anil kumar <anils_r@yahoo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Installing kernel 2.4
In-Reply-To: <Pine.LNX.3.96.1001107175009.1482C-100000@kanga.kvack.org> <3A088C02.4528F66B@timpanogas.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Merkey wrote:
> here are tests for all this in the feature flags for intel and
> non-intel CPUs like AMD -- including MTRR settings.  All of this could
> be dynamic.  Here's some code that does this, and it's similiar to
> NetWare.  It detexts CPU type, feature flags, special instructions,
> etc.  All of this on x86 could be dynamically detected.   

Jeff, I think you miss the point that 100% dynamic detection comes with
a penalty over the current system.

Using CONFIG_M586 enables us to compile with Pentium-specific
instructions, and eliminate any code specific to 386's or 486's.  This
includes inlining Pentium-specific code into drivers and the core kernel
where possible, for the maximum possible performance.  Your scheme
doesn't work because of all the inlined code, nor does it support
maximum performance code on all processors without massive code bloat...

You do bring up a good point though.  Users compile their own kernels to
get the advantages I describe above.  Vendors, on the other hand, must
compile one-size-fits-all generic kernels.  Your expertise and
assistance would definitely benefit this case.

One change I would like to make in 2.5.x along these lines -- the Alpha
AXP port allow one to define either CONFIG_ALPHA_GENERIC -- support all
processors/machines -- or CONFIG_ALPHA_$MYMACHINE.  It would be nice to
follow that model for x86 too.  Currently, when I select CONFIG_M586, I
get code for 686, etc.  There is no way to simply say "Pentium and
nothing else".

	Jeff


-- 
Jeff Garzik             | "When I do this, my computer freezes."
Building 1024           |          -user
MandrakeSoft            | "Don't do that."
                        |          -level 1
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
