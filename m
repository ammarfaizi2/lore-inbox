Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132832AbRDPCCz>; Sun, 15 Apr 2001 22:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132835AbRDPCCp>; Sun, 15 Apr 2001 22:02:45 -0400
Received: from mail2.rdc2.ab.home.com ([24.64.2.49]:12762 "EHLO
	mail2.rdc2.ab.home.com") by vger.kernel.org with ESMTP
	id <S132832AbRDPCCk>; Sun, 15 Apr 2001 22:02:40 -0400
Message-ID: <3ADA51A9.C3028950@home.com>
Date: Sun, 15 Apr 2001 19:58:01 -0600
From: swds.mlowe@home.com
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: IP Acounting Idea for 2.5
In-Reply-To: <Pine.LNX.4.33.0104152048250.17111-100000@asdf.capslock.lan>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No, one rule would be MUCH faster. What's do you think would be faster of the two:

if ((ipaddr>=3232235521)&&(ipaddr<=3232235774))
    return 1;
else
    return 0;

or

for (a=0;a<(3232235774-3232235521);a++)
    if (ipaddr==a)
        return 1;
return 0;

Obviously it compares the 192.168.0.1 - 192.168.0.255 range, but I think we both
know which one will be faster. Not to mention countless other redundant checks
will be added in on both, but on the second one the time of the checks is
multiplied by the number of times you have too loop.

But, I'm just a newbie so I don't really know :P Just taking up bandwith :(

L8ers,
Matt

"Mike A. Harris" wrote:

> On Tue, 17 Apr 2001, David Findlay wrote:
>
> >> Perhaps I misunderstand what it is exactly you are trying to do,
> >> but I would think that this could be done entirely in userland by
> >> software that just adds rules for you instead of you having to do
> >> it manually.
> >
> >I suppose, but it would be so much easier if the kernel did it automatically.
> >Having a rule to go through for each IP address to be logged would be slower
> >than implementing one rule that would log all of them. Doing this in the
> >kernel would improve preformance.
>
> I don't think it would, but then only benchmarking it both ways
> would know for sure.  Even with incredibly large rulesets,
> ipchains &&/|| netfilter works admirably well.  Rusty?
>
> ----------------------------------------------------------------------
>     Mike A. Harris  -  Linux advocate  -  Free Software advocate
>           This message is copyright 2001, all rights reserved.
>   Views expressed are my own, not necessarily shared by my employer.
> ----------------------------------------------------------------------
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

