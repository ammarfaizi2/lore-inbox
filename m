Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279912AbRKBBYp>; Thu, 1 Nov 2001 20:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279914AbRKBBYg>; Thu, 1 Nov 2001 20:24:36 -0500
Received: from [63.231.122.81] ([63.231.122.81]:36919 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S279912AbRKBBYY>;
	Thu, 1 Nov 2001 20:24:24 -0500
Date: Thu, 1 Nov 2001 18:23:34 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: linux-kernel@vger.kernel.org, J Sloan <jjs@lexus.com>,
        Petr Vandrovec <VANDROVE@vc.cvut.cz>,
        george anzinger <george@mvista.com>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        Benjamin LaHaise <bcrl@redhat.com>
Subject: Re: [Patch] Re: Nasty suprise with uptime
Message-ID: <20011101182334.P16554@lynx.no>
Mail-Followup-To: Tim Schmielau <tim@physik3.uni-rostock.de>,
	linux-kernel@vger.kernel.org, J Sloan <jjs@lexus.com>,
	Petr Vandrovec <VANDROVE@vc.cvut.cz>,
	george anzinger <george@mvista.com>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	Benjamin LaHaise <bcrl@redhat.com>
In-Reply-To: <Pine.LNX.4.30.0111011224440.1053-100000@gans.physik3.uni-rostock.de> <Pine.LNX.4.30.0111020059170.5092-100000@gans.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.30.0111020059170.5092-100000@gans.physik3.uni-rostock.de>; from tim@physik3.uni-rostock.de on Fri, Nov 02, 2001 at 01:28:29AM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 02, 2001  01:28 +0100, Tim Schmielau wrote:
> Well, I did the next patch without waiting for progress on the stability
> front (fsck still in heavy use here). As an excercise I added proper
> locking to get_jiffies64().

Looks good.

>  	idle = init_tasks[0]->times.tms_utime + init_tasks[0]->times.tms_stime;
> [snip]
>  	 */
>  #if HZ!=100
>  	len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
> -		uptime / HZ,
> -		(((uptime % HZ) * 100) / HZ) % 100,
> +		(unsigned long) uptime,
> +		(remainder * 100) / HZ,
>  		idle / HZ,
>  		(((idle % HZ) * 100) / HZ) % 100);

Probably need to make idle a 64-bit value as well, even if the individual
items are not, just to avoid potential overflow...  Calling do_div(idle,HZ)
may end up being just as fast as the hoops we jump through above to calculate
the fractions (2 divides, 2 modulus, and one multiply).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

