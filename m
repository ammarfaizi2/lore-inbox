Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317140AbSF1Leq>; Fri, 28 Jun 2002 07:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317142AbSF1Lep>; Fri, 28 Jun 2002 07:34:45 -0400
Received: from elin.scali.no ([62.70.89.10]:30220 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S317140AbSF1Leo>;
	Fri, 28 Jun 2002 07:34:44 -0400
Subject: Re: Maximum core file size in Linux
From: Terje Eggestad <terje.eggestad@scali.com>
To: Amrith Kumar <akumar@netezza.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <GMEPJBOPOAKOBODMIKMGMEMHCAAA.akumar@netezza.com>
References: <GMEPJBOPOAKOBODMIKMGMEMHCAAA.akumar@netezza.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 28 Jun 2002 13:36:55 +0200
Message-Id: <1025264218.19968.156.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is likely a gdb issue. Unless you're carefull to use 64 bit
functions of *seek*() and ftell(), your only able to access the first
2GB of a file. gdb may have issues here.

I don't recall the elf header but you may want to check the 32 bit elf
format and see if is even capable to be used with core file that exceed
2GB. Said in anothre way there *could* be elf-header offsets that is 32
bit and try pointing beyond 2GB.  

Terje

On tor, 2002-06-27 at 14:30, Amrith Kumar wrote:
> Appears that there's an implicit 2Gb limit on the size of core files because
> it's being created without O_LARGEFILE.
> 
> A small change in fs/exec.c (do_coredump) gets me past the limit and I can
> now generate a core file in excess of 2Gb but then gdb complains that the
> core dump is too large ...
> 
> Looks like there's a broader underlying issue here that would involve
> changes to other places than I had thought would be required.
> 
> Anyone else out there run into a similar problem ? And if so, could you let
> me know what other things I may run into ... Also, is this something that
> has been fixed in a forthcoming release ?
> 
> Thanks,
> 
> /a
> 
> --
> Amrith Kumar
> akumar@netezza.com
> 508-665-6835
> 
> #include <std_disclaimer.h>
> This e-mail message is for the sole use of the intended recipient(s) and may
> contain Netezza Corporation confidential and privileged information.  Any
> unauthorized review, use, disclosure, or distribution is prohibited.  If you
> are not the intended recipient, please contact the sender by reply e-mail
> and destroy all copies of the original message.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
_________________________________________________________________________

Terje Eggestad                  mailto:terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 150, Oppsal                     +47 975 31 574  (MOBILE)
N-0619 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

