Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273329AbRINHbE>; Fri, 14 Sep 2001 03:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273331AbRINHay>; Fri, 14 Sep 2001 03:30:54 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:56056 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S273329AbRINHao>; Fri, 14 Sep 2001 03:30:44 -0400
Message-ID: <3BA1B222.806F43AA@mvista.com>
Date: Fri, 14 Sep 2001 00:30:42 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Arjan Filius <iafilius@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: Feedback on preemptible kernel patch
In-Reply-To: <Pine.LNX.4.33.0109102323450.24212-100000@sjoerd.sjoerdnet> <1000402027.23162.45.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> On Mon, 2001-09-10 at 17:29, Arjan Filius wrote:
> > Yes I am using reiserfs (for "ages"). better said, reiser on LVM.
> >
> > Small discription of my system and used setup:
> > scsi-disk,scsi-cdrom,ide-disk,ide-scsi,ext2,reiser, iptables, ipv6,
> > acenic-Gbit-ethernet, ramdisk, highmem (1.5GB-ram), Athlon 1.1GHz, Asus
> > a7v MB (via).
> 
> Hi Arjan,
> 
> first, highmem is fixed and the original patch you have from me is good.
> second, Daniel Phillips gave me some feedback into how to figure out the
> VM error.  I am working on it, although just the VM potential --
> ReiserFS may be another problem.
> 
> third, you may be experiencing problems with a kernel optimized for
> Athlon.  this may or may not be related to the current issues with an
> Athlon-optimized kernel.  Basically, functions in arch/i386/lib/mmx.c
> seem to need some locking to prevent preemption.  I have a basic patch
> and we are working on a final one.
> 
Right, the same problem as using floating point in the kernel (mmx uses
the FP regs and they are not saved).  The question is: Just how long do
these routines take?  If it is very long it may be best to just say no. 
One way would be to always pretend that the "in_interrupt" flag is set. 
I think possibly some routines are short and the switch off/ switch on
pair is right, but for the long ones, well the preemption patch is
supposed to make the kernel more preemptable, not less.  Any one have
execution times for these functions?

George
