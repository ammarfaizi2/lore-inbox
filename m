Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbTJSPTv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 11:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbTJSPTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 11:19:51 -0400
Received: from h1ab.lcom.net ([216.51.237.171]:46464 "EHLO digitasaru.net")
	by vger.kernel.org with ESMTP id S261239AbTJSPTt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 11:19:49 -0400
Date: Sun, 19 Oct 2003 10:19:45 -0500
From: Joseph Pingenot <trelane@digitasaru.net>
To: Javier Achirica <achirica@telefonica.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: airo regression with Linux 2.4.23-pre2
Message-ID: <20031019151943.GA3528@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: Javier Achirica <achirica@telefonica.net>,
	linux-kernel@vger.kernel.org
References: <20031015194754.GA14859@viac3> <Pine.SOL.4.30.0310152323320.21600-100000@tudela.mad.ttd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0310152323320.21600-100000@tudela.mad.ttd.net>
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Javier Achirica on Wednesday, 15 October, 2003:
>Hello,
>I've been out for a few days, so I'm now catching up with e-mail...
>Anyway, I've been discussing this issue with Celso and looks like the line
>he mentions make his configuration fail. I added it because in other cases
>it makes it work. Anyway, please test the driver removing that line and if
>it fixes the problem I'll just try to figure out the exact cases when it's
>neede (Cisco hasn't been very helpful about it)..

Hello again.

I've tested the change, but I am having a problem even getting to that
  point.

When inserting the airo card in kernel 2.4.22 and 2.4.22-bk36, I get the
  following error:

Oct 18 16:50:10 paulus cardmgr[3036]: socket 1: 350 Series Wireless LAN Adapter
Oct 18 16:50:11 paulus airo: register interrupt 0 failed, rc -16
Oct 18 16:50:11 paulus airo_cs: RequestConfiguration: Operation succeeded
Oct 18 16:50:12 paulus cardmgr[3036]: get dev info on socket 1 failed: Resource temporarily unavailable

Do you know where this might be coming from?  The card works pretty well
  (it actually has the following problem in 2.4.21:


ct 19 00:20:52 paulus Warning: kfree_skb passed an skb still on a list (from c011a444).
Oct 19 00:20:52 paulus kernel BUG at skbuff.c:315!
Oct 19 00:20:52 paulus invalid operand: 0000
Oct 19 00:20:52 paulus CPU:    0
Oct 19 00:20:52 paulus EIP:    0010:[<c022dedb>]    Not tainted
Oct 19 00:20:52 paulus EFLAGS: 00010282
Oct 19 00:20:52 paulus eax: 00000045   ebx: c3c124a0   ecx: 00000001   edx: c9c5e000
Oct 19 00:20:52 paulus esi: c9f43f8c   edi: 00000000   ebp: c9f42000   esp: c9f43f78
Oct 19 00:20:52 paulus ds: 0018   es: 0018   ss: 0018
Oct 19 00:20:52 paulus Process keventd (pid: 2, stackpage=c9f43000)
Oct 19 00:20:52 paulus Stack: c02b6180 c011a444 c9f43f8c c011a444 c3c124a0 c89602e4 c89602e4 ffffffff 
Oct 19 00:20:52 paulus c9f42568 c0121fbc c02cd770 c9f42560 c9f42570 c9f42000 00000001 00000000 
Oct 19 00:20:52 paulus c02cb260 00010000 00000000 00000700 c0121ea0 c031f23c 00000000 c9f42000 
Oct 19 00:20:52 paulus Call Trace:    [<c011a444>] [<c011a444>] [<c0121fbc>] [<c0121ea0>] [<c0105000>]
Oct 19 00:20:52 paulus [<c0105706>] [<c0121ea0>]
Oct 19 00:20:52 paulus 
Oct 19 00:20:52 paulus Code: 0f 0b 3b 01 ac 53 2b c0 58 5a 8b 5c 24 08 e9 e2 fe ff ff 90 

(unfortunately, it doesn't look like ksymoops could translate this for
  some reason.)

which is what I was hoping was fixed in the upgrade.

Unfortunately, neither 2.4.22 work (as described above), and for some reason
  the pcmcia/cardbus driver locks up my system (I found this by stripping out
  everything and slowly adding stuff back 'till it broke) without an error
  that I can find in 2.6.0.  :(

Any assistance you can provide would be extremely helpful.  I can edit the
  files and add debugging info if need be--I just want to be able to use
  a current kernel again.  ;)

Thank you for your help.

-Joseph
-- 
Joseph===============================================trelane@digitasaru.net
"Asked by CollabNet CTO Brian Behlendorf whether Microsoft will enforce its
 patents against open source projects, Mundie replied, 'Yes, absolutely.'
 An audience member pointed out that many open source projects aren't
 funded and so can't afford legal representation to rival Microsoft's. 'Oh
 well,' said Mundie. 'Get your money, and let's go to court.' 
Microsoft's patents only defensive? http://swpat.ffii.org/players/microsoft
