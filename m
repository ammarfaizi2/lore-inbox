Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262516AbSI0PZV>; Fri, 27 Sep 2002 11:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262517AbSI0PZV>; Fri, 27 Sep 2002 11:25:21 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:25539 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S262516AbSI0PZV>;
	Fri, 27 Sep 2002 11:25:21 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200209271530.TAA21206@sex.inr.ac.ru>
Subject: Re: [PATCH] IPv6: Refine IPv6 Address Validation Timer
To: yoshfuji@linux-ipv6.org (YOSHIFUJI Hideaki /
	=?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?=)
Date: Fri, 27 Sep 2002 19:30:14 +0400 (MSD)
Cc: davem@redhat.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       usagi@linux-ipv6.org
In-Reply-To: <20020928.001617.91124319.yoshfuji@linux-ipv6.org> from "YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?=" at Sep 28, 2 00:16:17 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> So, is this reasonable?

Yes, I like this.

Let's only delete this:

> +	if (time_before(now + HZ/2, jiffies)) {
> +		ADBG((KERN_WARNING 
> +		      "addrconf_verify(): too slow; jiffies - now = %ld\n",
> +		      (long)jiffies - (long)now));
> +	}

I do not understand how this survived. If you worry about infinite
spinning in loop you could make this check real, f.e. breaking loop
when jiffies >= now+2. In this form it is just mud.

Alexey
