Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S133108AbQK0AR7>; Sun, 26 Nov 2000 19:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S133082AbQK0ARt>; Sun, 26 Nov 2000 19:17:49 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:48529 "EHLO
        freya.yggdrasil.com") by vger.kernel.org with ESMTP
        id <S135185AbQK0ARg>; Sun, 26 Nov 2000 19:17:36 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 26 Nov 2000 15:47:30 -0800
Message-Id: <200011262347.PAA11866@baldur.yggdrasil.com>
To: kaos@ocs.com.au
Subject: Re: initdata for modules?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au> wrote:
>"Adam J. Richter" <adam@yggdrasil.com> wrote:
>>	In reading include/linux/init.h, I was surprised to discover
>>that __init{,data} expands to nothing when compiling a module.
>>I was wondering if anyone is contemplating adding support for
>>__init{,data} in module loading, to reduce the memory footprints
>>of modules after they have been loaded.

>It has been discussed a few times but nothing was ever done about it.
>AFAIK the savings were not seen to be that important because modules
>occupy complete pages.  __init would have to be stored in a separate
>page which was then discarded. [...]

	No, you could just discard the part after the next page
boundary.  The expected savings would be about the same, since
the cases where the original code had just creeped over a page
boundary in many cases would result in dropping more memory savings
that the actual init size, from dropping those unused bytes
between the very end of the init section and the end of that page.
I say "about" the same becuase the distribution of text and data
sizes is not uniformly random within some fixed interval.

	Since you would not have to bump the start address of a
section to the next page boundary, I wonder if it would still
complicate insmod et al.

	In case there is any confusion, I am not suggesting that
this should go into the stock 2.4.0 releases.

	However, I do find it helpful in allocating my time to
cosider that saving one page by something like this or by enhancing
gcc's variable placement saves as much space as 1024 eliminations
of "= 0" or "= NULL" static variable initializations.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
