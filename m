Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130108AbRAAALT>; Sun, 31 Dec 2000 19:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131022AbRAAALJ>; Sun, 31 Dec 2000 19:11:09 -0500
Received: from mercury.nildram.co.uk ([195.112.4.37]:3087 "EHLO
	mercury.nildram.co.uk") by vger.kernel.org with ESMTP
	id <S130108AbRAAAKz>; Sun, 31 Dec 2000 19:10:55 -0500
Message-ID: <3A4FC3E6.47ECDA64@magenta-netlogic.com>
Date: Sun, 31 Dec 2000 23:40:22 +0000
From: Tony Hoyle <tmh@magenta-netlogic.com>
Organization: Magenta Logic
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-prerelease i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: J Sloan <jjs@pobox.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: tdfx.o and -test13
In-Reply-To: <E14CrTQ-0000BD-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> I see modversions.h being included properly on the command line

Me too..

make[3]: Entering directory `/usr/src/linux/drivers/char/drm'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -pipe
-mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include
/usr/src/linux/include/linux/modversions.h   -c -o agpsupport.o
agpsupport.c
In file included from agpsupport.c:1:
/usr/src/linux/include/linux/modversions.h:3: warning: ignoring pragma:
"Modversions included

Modversions *is* being included... putting a message into the header
file shows it to be correctly included at compile time.  However by the
time the C file is processed it the symbols it has defined appear to no
longer exist.  When you put the patch into drmP.h it never re-includes
modversions (the pragma is not hit, because _LINUX_MODVERSIONS_H is
already defined) *but* the macros within it suddenly become active.

I'm confused!

Preprocessor bug?  Demon possessed compiler?

Tony (still coding at 20 minutes to midnight --- sad or what?)

-- 
Can't think of a decent signature...

tmh@magenta-netlogic.com		http://www.nothing-on.tv
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
