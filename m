Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268981AbRHBSFC>; Thu, 2 Aug 2001 14:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269018AbRHBSEw>; Thu, 2 Aug 2001 14:04:52 -0400
Received: from mail.valinux.com ([198.186.202.175]:45585 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S268981AbRHBSEv>;
	Thu, 2 Aug 2001 14:04:51 -0400
Message-ID: <3B699786.C3178BE1@valinux.com>
Date: Thu, 02 Aug 2001 11:10:14 -0700
From: "Jason T. Collins" <jcollins@valinux.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-beta1va3.10smp-piii i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Corin Hartland-Swann <cdhs@commerce.uk.net>, linux-kernel@vger.kernel.org
Subject: Re: Memory Problems - CTCS/memtst
In-Reply-To: <Pine.LNX.4.21.0108021659300.23264-100000@willow.commerce.uk.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corin Hartland-Swann wrote:
> 
> Alan,
> 
> On Thu, 2 Aug 2001, Alan Cox wrote:
> > > The BIOS has an ECC logging feature, and if I understand it correctly,
> > > then there /cannot/ have been any main memory errors or they would have
> > > shown up in the logs. At least not any single or double-bit errors (ECC
> > > corrects single-bit and detects double-bit, doesn't it?)

Remember, the memory itself is only one area where there might be problems. 
There are other memory related areas including the following that are not
covered by ECC memory:

North bridge (memory controller)
L1/L2/L3 cache levels (some processors have ECC checking in the cache)
Register corruption

In addition, the transfers between the CPU and memory could be corrupted in
transit before the ECC checksum is calculated (I've actually seen this happen
on a poorly designed motherboard).  In other words, there are a lot of things
that could be wrong, see the FAQ in CTCS for more of my ramblings on the
subject.

One way to tell whether or not your memory is the problem is by examining your
files/coredumps for corruption.  If entire page-sized chunks have been
substituted with chunks from other files, pages in RAM, etc, you're likely
dealing with a kernel MM bug rather than memory corruption.  (I suppose an MMU
bug is possible too.. sigh...)  A few bits swapped here and there points to
hardware/faulty memory.  That's one reason why my memory checker displays that
nice context information, so those sorts of determinations can be made.

> I've just tried test 2 on another machine (with good memory) and it looks
> like it's a bug in memtst rather than the detection of an error.

This doesn't surprise me too much, the software is pretty new.  The fact that
the expected and resulting memory contents in the log is the same would seem to
confirm that, plus the fact that the 'error' happened on the first byte in the
test array and other strange things.  :)  A quick check confirms it breaks for
me too, so I'll find this bug and whack it in a new release.  Expect something
this weekend.

-- 
Jason T. Collins  "Noone has lived to see even three of my techniques.  It
Software Engineer  is almost sunset.  How many will you see before you die?"
VA Linux Systems   'Twilight' Suzuka, "Creeping Evil"
