Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282816AbRK0G2t>; Tue, 27 Nov 2001 01:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282819AbRK0G2j>; Tue, 27 Nov 2001 01:28:39 -0500
Received: from rj.SGI.COM ([204.94.215.100]:64684 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S282817AbRK0G2Y>;
	Tue, 27 Nov 2001 01:28:24 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/802/Makefile 
In-Reply-To: Your message of "Mon, 26 Nov 2001 22:18:55 -0800."
             <20011126.221855.102041585.davem@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 27 Nov 2001 17:28:16 +1100
Message-ID: <12324.1006842496@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2001 22:18:55 -0800 (PST), 
"David S. Miller" <davem@redhat.com> wrote:
>   From: Keith Owens <kaos@ocs.com.au>
>   Date: Tue, 27 Nov 2001 17:12:04 +1100
>   
>   The source repository (whether BK or any other system) is not the
>   problem.  You can get the timestamps right in the source but the moment
>   you generate and ship a diff then you lose control of timestamps.  See
>   the long screed below about the problems with shipping generated files,
>   from kbuild-2.5.txt.
>
>Even after reading this I don't understand why defkeymap.c gets
>special treatment just because it requires external tools to generate.
>
>If the timestamps get messed up, it's going to try to regerenerate the
>file with loadkeys whether you have it or not.

When the maintainer did the build on their system, the timestamps were
right.  The moment the change is converted to a patch and sent for
inclusion in the kernel, timestamp order cannot be guaranteed, the
final result on kernel.org may have the base file being older or newer
than the generated output.  kbuild 2.4 is completely broken for
generated files, tthe only reason it "works" is because most of these
files do not change.

kbuild 2.5 fixes this problem.  It knows that you can never rely on
timestamps when you ship both a base file and a file that has been
generated from it.  Instead it uses checksums to detect any changes,
that is part of the gory details that were omitted from the previous
mail.

>At best, I'd be happy to take a patch which commented out the rule
>which tries to generate net/802/cl2llc.c but not one which will chmod
>it.  Because the latter only makes sense if we are now deciding to do
>this for _every_ such case in the tree.

I have fixed _every_ such case in 2.5.  It is unfixable in 2.4, the
order of timestamps on generated and shipped files is not reliable.

