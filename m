Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288109AbSAMUSg>; Sun, 13 Jan 2002 15:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288102AbSAMUSa>; Sun, 13 Jan 2002 15:18:30 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:8964 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S288093AbSAMUSP>; Sun, 13 Jan 2002 15:18:15 -0500
Message-ID: <3C41EA24.11494402@zip.com.au>
Date: Sun, 13 Jan 2002 12:12:20 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Oliver.Neukum@lrz.uni-muenchen.de, linux-kernel@vger.kernel.org
Subject: Re: ugly warnings with likely/unlikely
In-Reply-To: <16PjOb-0oLbCCC@fwd11.sul.t-online.com> from "Oliver Neukum" at Jan 13, 2002 01:05:13 PM <E16PmEA-0007Ai-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > if (likely(stru->pointer))
> >
> > results in an ugly warning about using pointer as int.
> > Is there something that could be done against that ?
> 
>         if (likely(stru->pointer == NULL))
> 

-#define likely(x)       __builtin_expect((x),1)
-#define unlikely(x)     __builtin_expect((x),0)
+#define likely(x)       __builtin_expect((x)!=0,1)
+#define unlikely(x)     __builtin_expect((x)!=0,0)

?
