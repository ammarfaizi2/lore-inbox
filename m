Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262514AbSI0QJ0>; Fri, 27 Sep 2002 12:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262520AbSI0QJ0>; Fri, 27 Sep 2002 12:09:26 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:14604 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S262514AbSI0QJZ>; Fri, 27 Sep 2002 12:09:25 -0400
Date: Sat, 28 Sep 2002 01:14:39 +0900 (JST)
Message-Id: <20020928.011439.108856769.yoshfuji@linux-ipv6.org>
To: kuznet@ms2.inr.ac.ru
Cc: davem@redhat.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Refine IPv6 Address Validation Timer
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <200209271530.TAA21206@sex.inr.ac.ru>
References: <20020928.001617.91124319.yoshfuji@linux-ipv6.org>
	<200209271530.TAA21206@sex.inr.ac.ru>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200209271530.TAA21206@sex.inr.ac.ru> (at Fri, 27 Sep 2002 19:30:14 +0400 (MSD)), kuznet@ms2.inr.ac.ru says:

> Let's only delete this:
> 
> > +	if (time_before(now + HZ/2, jiffies)) {
> > +		ADBG((KERN_WARNING 
> > +		      "addrconf_verify(): too slow; jiffies - now = %ld\n",
> > +		      (long)jiffies - (long)now));
> > +	}
> 
> I do not understand how this survived. If you worry about infinite
> spinning in loop you could make this check real, f.e. breaking loop
> when jiffies >= now+2. In this form it is just mud.

hmm, I supposed it finally exited the loop (and then we got above warn).
Code around end of patch (*) prevent continuous run of this function.
If it is (almost) meaningless, just delete it.

(*) Oops, I slipped at (almost) end of the patch when making patch... sorry;
I inteded to refine timing into ~0.5 sec at worst; so, please change
	addr_chk_timer.expires = time_before(next, jiffies + HZ) ? jiffies + HZ : next;
to
	addr_chk_timer.expires = time_before(next, jiffies + HZ/2) ? jiffies + HZ/2 : next;
.

Thanks.


(do I need to resend complete patch?)

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
