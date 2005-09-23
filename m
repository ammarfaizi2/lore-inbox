Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbVIWXmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbVIWXmM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 19:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbVIWXmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 19:42:12 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:2443 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751346AbVIWXmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 19:42:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:From:To:Subject:Date:User-Agent:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=FJU/OIcTAckMT/2EUTQAQBmcNVLTwcB/rkoZKBWuZKNbGykDG7wFBgTe4Mj0qVWO+OpFVdqK3DM3JYktb6z4svRajdGntQPAkEPzDvTdDrPyJ1jzL4A1Z/fJweY6NlJi0qjKsGCxxyHLP7kEuSFfJgS/BUz0QT/GlqWww41b50M=  ;
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 2/2] HPET: make frequency calculations 32 bit safe
Date: Sat, 24 Sep 2005 01:46:22 +0200
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, Bob Picco <bob.picco@hp.com>,
       Ingo Molnar <mingo@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509240146.22715.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- linux-2.6.13.orig/drivers/char/hpet.c       2005-09-22 11:10:01.000000000 +0200
> +++ linux-2.6.13/drivers/char/hpet.c    2005-09-22 12:08:48.000000000 +0200
> @@ -78,7 +78,7 @@ struct hpets {
>         struct hpet __iomem *hp_hpet;
>         unsigned long hp_hpet_phys;
>         struct time_interpolator *hp_interpolator;
> -       unsigned long hp_period;
> +       unsigned long long hp_tick_freq;
An 'unsigned long' is enough.
Are we expecting hpets stepping at more than 4GHz?
They are called 'legacy' in some docs already ;-)
Here the via8237's hpet runs at ~14MHz.

>         unsigned long hp_delta;
>         unsigned int hp_ntimer;
>         unsigned int hp_which;

Tested OK on i386 2.6.13-rt14 with above nitpick applied.

      Karsten


	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
