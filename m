Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131167AbRBRARi>; Sat, 17 Feb 2001 19:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132241AbRBRAR3>; Sat, 17 Feb 2001 19:17:29 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:62218 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S131167AbRBRARS>; Sat, 17 Feb 2001 19:17:18 -0500
Date: Sat, 17 Feb 2001 19:16:59 -0500
From: Chris Mason <mason@suse.com>
To: Frank de Lange <frank@unternet.org>, linux-kernel@vger.kernel.org
cc: reiser@namesys.com
Subject: Re: reiserfs on 2.4.1,2.4.2-pre (with null bytes patch) breaks
 mozilla compile
Message-ID: <1217040000.982455419@tiny>
In-Reply-To: <20010217172118.A5737@unternet.org>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Saturday, February 17, 2001 05:21:18 PM +0100 Frank de Lange
<frank@unternet.org> wrote:

> Hi'all,
> 
> Well, subject says it all... When I try to compile mozilla (CVS version)
> with the '--enable-elf-dynstr-gc' option, the compile fails with a
> segfault:
> 
> ../../dist/bin/elf-dynstr-gc ../../dist/lib/components/libsample.so
> make[2]: *** [install] Segmentation fault (core dumped)
> 

That's not good.  Which compiler did you use to compile the kernel?  This
sounds lame, but reiserfs exercises the cpu/mem more than ext2, so we hit
bad ram more often.  If we run out of other things to try, please run a
memory tester.

> compiling the same codebase on an ext2 filesystem does not produce this
> segfault. When I compare the produced library (libsample.so), there is a
> consistent difference between the one compile on the reiserfs and the ext2
> filesystem. Running objdump on the reiserfs-compiled library also produces
> errors (some assertion failures, a lot of 'invalid string offset' errors,
> and finally a 'Memory exhausted' error), while objdump happily
> disassebles the ext-produced binary.
> 

Where in the libsample.so file are the differences (what byte offset?).
Are they restricted to a given range, or do they vary randomly?

> These problems occur on:
> 
>  2.4.1
>  2.4.2-pre4
>  2.4.2-pre4 with Chris Mason's 'reiserfs fix for null bytes in small
>  files'
> 
At least the patch didn't make it worse.  Would anyone care to comment on
how the elf-dynstr-gc option changes the file access patterns for the
compile?

thanks,
Chris
