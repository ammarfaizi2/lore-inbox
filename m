Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267890AbRGZMpu>; Thu, 26 Jul 2001 08:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267904AbRGZMpl>; Thu, 26 Jul 2001 08:45:41 -0400
Received: from foobar.isg.de ([62.96.243.63]:17418 "HELO mail.isg.de")
	by vger.kernel.org with SMTP id <S267890AbRGZMp2>;
	Thu, 26 Jul 2001 08:45:28 -0400
Message-ID: <3B6010EC.B7428A0D@isg.de>
Date: Thu, 26 Jul 2001 14:45:32 +0200
From: Lutz Vieweg <lkv@isg.de>
Organization: Innovative Software AG
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: German, de, en
MIME-Version: 1.0
To: kas@informatics.muni.cz, linux-kernel@vger.kernel.org
Cc: unix@fi.muni.cz
Subject: Re: [Fwd: Linux 2.4 networking/routing slowdown]
In-Reply-To: <3B600EAD.3F8F9A70@isg.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Jan Kasprzak <kas@informatics.muni.cz> wrote:

> >         I have tried to upgrade my firewall to 2.4 kernel (2.4.7), and I have
> > observed a major slowdown of the network speed.

We observed a similar problem, hunted it down via kernel profiling:

When we used ipchains to establish a port redirection (just one
rule, map one port to another), the network would become rediculously
slow after some time of use, causing the CPU to spend almost 100%
as "system time".

We found that the expensive kernel functions were redir_cmp and unredir_cmp,
which were called an unreasonable amount of times by find_redir - seems the
iteration over the list there is quite lengthy...

We didn't investigate the problem further, but found that by using 
"iptables" instead of the obsolete "ipchains" to establish the redirection
rule, everything was fine again.

So my advice would be to try iptables and see if your problem goes away
as well.

Regards,

Lutz Vieweg

--
 Dipl. Phys. Lutz Vieweg | email: lkv@isg.de
 Innovative Software AG  | Phone/Fax: +49-69-505030 -120/-505
 Feuerbachstrasse 26-32  | http://www.isg.de/people/lkv/
 60325 Frankfurt am Main | ^^^ PGP key available here ^^^
