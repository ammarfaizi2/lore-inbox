Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129555AbQK0RtZ>; Mon, 27 Nov 2000 12:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129641AbQK0RtQ>; Mon, 27 Nov 2000 12:49:16 -0500
Received: from netwinder.org ([207.245.35.202]:41464 "EHLO kei.netwinder.org")
        by vger.kernel.org with ESMTP id <S129555AbQK0RtI>;
        Mon, 27 Nov 2000 12:49:08 -0500
Message-ID: <3A22978B.30E6A29A@netwinder.org>
Date: Mon, 27 Nov 2000 12:19:07 -0500
From: "Andrew E. Mileski" <andrewm@netwinder.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Universal debug macros.
In-Reply-To: <Pine.LNX.3.95.1001127115313.153A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> On Mon, 27 Nov 2000, Andrew E. Mileski wrote:
> >
> > Reminds me ... <linux/kernel.h> has a "#if DEBUG" statement that blows
> > up if the debug code does something like "#define DEBUG(X...) printk(X...)".
> > I came across this recently (think I was debugging PCI code ... not sure).
> > Changing it to "#ifdef DEBUG" avoids problems.
> >
> > --
> > Andrew E. Mileski - Software Engineer
> > Rebel.com  http://www.rebel.com/
> 
> I find that the following works fine:
> 
> #ifdef DEBUG
> #define DEB(f) f
> #else
> #define DEB(f)
> #endif

Agreed, but that wasn't my point.  There is debug code in the current
kernel that defines DEBUG to something non-numeric, which causes
the compile to barf on kernel.h in some cases (try defining DEBUG in
your Makefile).  Instances of the offending code (there are SEVERAL)
and kernel.h should be fixed.

Try this from the top level:
  grep -r DEBUG * | grep -v DEBUG_ | less

--
Andrew E. Mileski - Software Engineer
Rebel.com  http://www.rebel.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
