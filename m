Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129756AbQK1Hej>; Tue, 28 Nov 2000 02:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129853AbQK1He2>; Tue, 28 Nov 2000 02:34:28 -0500
Received: from kendy.up.ac.za ([137.215.101.101]:8711 "EHLO kendy.up.ac.za")
        by vger.kernel.org with ESMTP id <S129756AbQK1HeS>;
        Tue, 28 Nov 2000 02:34:18 -0500
Message-ID: <3A235584.B627F510@suntiger.ee.up.ac.za>
Date: Tue, 28 Nov 2000 08:49:40 +0200
From: Justin Schoeman <justin@suntiger.ee.up.ac.za>
Reply-To: justin@suntiger.ee.up.ac.za
Organization: University of Pretoria
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Question on vmalloc() memory management
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

I would just like to find out if there is any real reason why there are
no memory management functions for handling vmalloc()ed memory.  If you
have a look at bttv.c, you will see definitions of:

kvirt_to_pa (translate a vmalloc()ed address to a page number)
rvmalloc (malloc and mark as reserved)
rvfree (free and mark as unreserved)

These functions are duplicated (in fact, usually a direct copy), in just
about every video4linux driver (including many as standalone modules),
and some network and sound drivers.

Wouldn't it be a good idea to provide these functions as a standard part
of the mm subsystem of the kernel.  The functions are very small, but
closely related to the vm subsystem - standardising these functions
should reduce the kernel size a little, and also make module development
a little easier (I personally have been caught once or twice by changes
in the mm subsystem breaking the kvirt to phys translation).

Would such a patch be acceptable?  If it is, I will be glad to make a
patch and submit it.

TIA,

-justin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
