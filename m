Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQLKRcb>; Mon, 11 Dec 2000 12:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129545AbQLKRcV>; Mon, 11 Dec 2000 12:32:21 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:48399 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129226AbQLKRcF>;
	Mon, 11 Dec 2000 12:32:05 -0500
To: Ulrich.Weigand@de.ibm.com
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
Subject: Re: NFS: set_bit on an 'int' variable OK for 64-bit?
In-Reply-To: <C12569B2.005C9182.00@d12mta01.de.ibm.com>
From: Jes Sorensen <jes@linuxcare.com>
Date: 11 Dec 2000 18:01:30 +0100
In-Reply-To: Ulrich.Weigand@de.ibm.com's message of "Mon, 11 Dec 2000 17:51:04 +0100"
Message-ID: <d34s0a7uz9.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Ulrich" == Ulrich Weigand <Ulrich.Weigand@de.ibm.com> writes:

Ulrich> Hello,

Ulrich> since test11, the NFS code uses the set_bit and related
Ulrich> routines to manipulate the wb_flags member of the nfs_page
Ulrich> struct (nfs_page.h).  Unfortunately, wb_flags has still data
Ulrich> type 'int'.

Ulrich> This is a problem (at least) on the 64-bit S/390 architecture,
Ulrich> as our ..._bit macros assume bit 0 is the least significant
Ulrich> bit of a 'long', which means due to big-endian byte order that
Ulrich> bit 0 resides in the 7th byte of the variable.  As an int
Ulrich> occupies only 4 bytes, however, set_bit(0, int) clobbers
Ulrich> memory.

Ulrich> Now the question is, who's correct?

You are, the bit macros should only be used on long's. It happens to
work on little endian bitfield machines like the Alpha but thats the
same as when we had the problem with bit operations on char * in the
file system code a couple of years ago.

The NFS code needs to be fixed for this then.

Jes
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
