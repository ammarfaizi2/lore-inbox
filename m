Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265521AbTFMUUo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 16:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265522AbTFMUUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 16:20:44 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:32762 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S265521AbTFMUUm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 16:20:42 -0400
Message-ID: <3EEA3541.4000909@mvista.com>
Date: Fri, 13 Jun 2003 13:34:09 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Clemens Schwaighofer <cs@tequila.co.jp>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: uptime wrong in 2.5.70
References: <3EE9903E.2040101@tequila.co.jp>
In-Reply-To: <3EE9903E.2040101@tequila.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clemens Schwaighofer wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi,
> 
> I a got a test vmware running with a 2.5.70 and I have sligh "overflow"
> with my uptime.
> 
> gentoo root # uptime
>  22:29:47 up 14667 days, 19:08,  3 users,  load average: 0.00, 0.00, 0.00

Uptime currently reports a conversion of jiffies which is currently 
jacked up to a few seconds short of 32 bits worth of jiffies (for 
testing purposes).

I have a patch pending with Andrew to convert uptime to use the POSIX 
monotonic clock which a) will start at 0 at boot time and b) will 
account for NTP clock adjustments.  Should give an uptime real close 
to the best of watches (or even better) :)

-g
> 
> I think thats a bit too much ;)
> 
> Linux gentoo.tequila.intern 2.5.80 #1 Tue May 27 14:42:51 JST 2003 i686
> Intel(R) Penitum(R) 4 CPU 1.60GHz GenuineIntel GNU/Linux
> running on a
> Gentoo System (unstable tree)
> 
> - --
> Clemens Schwaighofer - IT Engineer & System Administration
> ==========================================================
> Tequila Japan, 6-17-2 Ginza Chuo-ku, Tokyo 104-8167, JAPAN
> Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343
> http://www.tequila.jp
> ==========================================================
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.1 (MingW32)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org
> 
> iD8DBQE+6ZA9jBz/yQjBxz8RAgnJAJ4yZTZJuP5QJOZv3Lc9Awnr4sblpQCeOHaD
> fgjlR74Svry26Jh+1oBjt6g=
> =6rUw
> -----END PGP SIGNATURE-----
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

