Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131861AbQKKSGB>; Sat, 11 Nov 2000 13:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131834AbQKKSFv>; Sat, 11 Nov 2000 13:05:51 -0500
Received: from proxy2.ba.best.com ([206.184.139.14]:61194 "EHLO
	proxy2.ba.best.com") by vger.kernel.org with ESMTP
	id <S131782AbQKKSFf>; Sat, 11 Nov 2000 13:05:35 -0500
Message-ID: <3A0D89F7.1CDC3B68@best.com>
Date: Sat, 11 Nov 2000 10:03:35 -0800
From: Robert Lynch <rmlynch@best.com>
Reply-To: rmlynch@best.com
Organization: Carpe per diem
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Peter Samuelson <peter@cadcamlab.org>, Andi Kleen <ak@suse.de>
Subject: Re: bzImage ~ 900K with i386 test11-pre2
In-Reply-To: <3A0C86B3.62DA04A2@best.com> <20001110234750.B28057@wire.cadcamlab.org> <20001111153036.A28928@gruyere.muc.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Samuelson wrote:
> [Robert Lynch] wrote:
> > I've been regularly building kernels in the testXX series, and
> > they have been coming out ~ 600K; test10-final and test11-pre1:
> > 
> > -rw-r--r--    1 root     root       610503 Oct 31 18:39 vmlinuz-t10
> > -rw-r--r--    1 root     root       610568 Nov  7 20:26 vmlinuz-t11p01
> > 
> > test11-pre2 comes out ~ 900K:
> > 
> > -rw-r--r--    1 root     root       926345 Nov 10 10:16 vmlinuz-t11p02
> 
> Track it down yourself:
> 
> 1) The sizes of your two 'vmlinux' files: do they differ wildly as well?

Wildly; compare test11-pre1 and testll-pre2 sizes:

-rwxr-xr-x    1 root     root      1789457 Nov  7 20:26
vmlinux-t11p01 
-rwxr-xr-x    1 root     root      2625016 Nov 10 10:15
vmlinux-t11p02    

> 2a) If no, check the make logs between the vmlinux link line and bzImage
>     creation.  Compare the two and note any significant differences.
> 
> 2b) If yes, write a perl script to compute symbol sizes from each
>     System.map file.  (Symbol size == address of next symbol minus
>     address of this symbol.)  Sort numerically, then compare old vs new
>     for symbols that have grown a lot, or large new symbols.
> 
> Peter

Whence Andi Kleen chipped in:

> No need to write one: ftp.firstfloor.org:/pub/ak/perl/bloat-o-meter 
> 
> -Andi

Running:

perl bloat-o-meter /boot/vmlinux-t11p01 /boot/vmlinux-t11p02 >
/tmp/bloat.out

looking at the output, the large positive changes seem to be
(doing it by eye, might have skipped and/or missed something):

Symbol	Old	size	New	size	Delta	Change	(%)

slabinfo_write_proc                  8      340     332  +4150.0
show_buffers                        24      368     344  +1433.3
sys_nfsservctl                      80     1060     980  +1225.0
dump_extended_fpu                    8       84      76  +950.00
get_fpregs                          36      372     336  +933.33
schedule_tail                       16      144     128  +800.00 
set_fpregs                          36      272     236  +655.56
tty_release                         16      108      92  +575.00
ext2_write_inode                    20      108      88  +440.00
...

I have surpressed my momentary urge to post the whole thing, so
as not to arouse the legendary ire of this list. :)

Bob L.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
