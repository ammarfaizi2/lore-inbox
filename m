Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <153965-8088>; Fri, 18 Sep 1998 01:28:26 -0400
Received: from [194.248.82.140] ([194.248.82.140]:2269 "EHLO fjellnett.fjellnett.no" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <153878-8088>; Fri, 18 Sep 1998 01:11:33 -0400
From: "Helge Hafting" <helge.hafting@daldata.no>
Date: Fri, 18 Sep 1998 10:34:15 +0100
To: Ian McKellar <imckellar@harvestroad.com.au>
In-Reply-To: <19980918151457.C9740@harvestroad.com.au>
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: Non-urgent issue with fs/isofs/util.c
X-Mailer: MR/2 Internet Cruiser Edition for OS/2 v1.50 b48 
Message-ID: <19980918083130171.AAA288.91@HELGES_PC>
Sender: owner-linux-kernel@vger.rutgers.edu

In <19980918151457.C9740@harvestroad.com.au>, on 09/18/98 
   at 03:14 PM, Ian McKellar <imckellar@harvestroad.com.au> said:


>Hi,

>The iso_date function in fs/isofs/util.c doesn't correctly handle leap
>years.

>Well, it doesn't handle the year 2100 - which according to the code is a
>leap year, but according to the commonly accepted rules is not.

>I don't think we need to be to concerned right now, but changing:
>         if (((year+2) % 4) == 0 && month > 2)
>to:
>             if (((year+2) % 4) == 0 && month > 2 && year != 130) should
>fix it.
The equivalent code
              if (!((year+2) & 3) && month > 2 && year != 130) is probably
faster.  The somewhat expensive mod operator is 
replaced by a bitwise "and", that is faster on most platforms.

Helge Hafting
-- 
-----------------------------------------------------------
helge.hafting@daldata.no
-----------------------------------------------------------


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
