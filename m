Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270750AbRHWXfk>; Thu, 23 Aug 2001 19:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270748AbRHWXfa>; Thu, 23 Aug 2001 19:35:30 -0400
Received: from mail.fbab.net ([212.75.83.8]:14858 "HELO mail.fbab.net")
	by vger.kernel.org with SMTP id <S270746AbRHWXfV>;
	Thu, 23 Aug 2001 19:35:21 -0400
X-Qmail-Scanner-Mail-From: mag@fbab.net via mail.fbab.net
X-Qmail-Scanner-Rcpt-To: ajc@gmx.net linux-kernel@vger.kernel.org
X-Qmail-Scanner: 0.94 (No viruses found. Processed in 5.692081 secs)
Message-ID: <057601c12c2c$9877b650$020a0a0a@totalmef>
From: "Magnus Naeslund\(f\)" <mag@fbab.net>
To: "Andrew Cannon" <ajc@gmx.net>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <20010823143440.G20693@mindspring.com> <3B85615A.58920036@timesn.com> <03fc01c12c10$8155b060$020a0a0a@totalmef> <3B858F62.AD7CED14@gmx.net>
Subject: Re: macro conflict
Date: Fri, 24 Aug 2001 01:37:38 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Andrew Cannon" <ajc@gmx.net>
>
> What about this then:
>
> #define min(x,y) ({typeof(x) __x=(x); typeof(y) __y=(y); (__x < __y) ?
> __x : __y})
>
> This is guaranteed to work the same as the old min/max in all cases but
> without side effects. You can still force the comparison to be done with
> a certain type by casting the arguments first:
>
[snip]

Well it's closer but not really what i want.
The min/max_type is maybe the way to go, but the above can still bit you if
the types differ. Consider max().

char lut[256];
int   c1 = 256+rand()%256;
char  c2 = rand()%256;
char dest = lut[max(c2,c1)];

Won't c1 still be returned untruncated?

Ofcourse one will use another construct for these kinds of checks, but maybe
your brain collapses just for a second and think that this will return a
char.

OK ok bad example, but maybe you see that i have a point here somewhere
(under my chair? :) ).

Magnus

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
 Programmer/Networker [|] Magnus Naeslund
 PGP Key: http://www.genline.nu/mag_pgp.txt
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


