Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273305AbRJaVq5>; Wed, 31 Oct 2001 16:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273534AbRJaVqs>; Wed, 31 Oct 2001 16:46:48 -0500
Received: from [63.231.122.81] ([63.231.122.81]:14706 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S273305AbRJaVqj>;
	Wed, 31 Oct 2001 16:46:39 -0500
Date: Wed, 31 Oct 2001 14:45:20 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        Tim Schmielau <tim@physik3.uni-rostock.de>,
        vda <vda@port.imtp.ilyichevsk.odessa.ua>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Re: Nasty suprise with uptime
Message-ID: <20011031144520.R16554@lynx.no>
Mail-Followup-To: Petr Vandrovec <VANDROVE@vc.cvut.cz>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	Tim Schmielau <tim@physik3.uni-rostock.de>,
	vda <vda@port.imtp.ilyichevsk.odessa.ua>,
	linux-kernel@vger.kernel.org
In-Reply-To: <7DFB419183D@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <7DFB419183D@vcnet.vc.cvut.cz>; from VANDROVE@vc.cvut.cz on Wed, Oct 31, 2001 at 10:11:09PM +0000
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 31, 2001  22:11 +0000, Petr Vandrovec wrote:
>   this reminds me. Year or so ago there was patch from someone, which 
> detected jiffies overflow in /proc/uptime proc_read() code, so only thing
> you had to do was run 'uptime', 'w', 'top' or something like that
> every 497 days - you can schedule it as cron job for Jan 1, 0:00:00,
> to find some workoholics.

Sorry, your posting is 14 minutes too late ;-).  I just re-invented this
wheel.  Such is the pace of Linux kernel development.

> static unsigned long long jiffies_hi = 0;
> static unsigned long old_jiffies = 0;
> unsigned long jiffy_cache;
> 
> /* some spinlock or inode lock or something like that */
> jiffy_cache = jiffies;
> if (jiffy_cache < old_jiffies) {
>    jiffies_hi += 1ULL << BITS_PER_LONG;
> }

Ah, my code only stored the high 32 bits of the jiffies_hi, so we don't
ever do 64-bit math for this, only a simple increment.  Otherwise it is
exactly the same, including the "some spinlock or something" comment ;-).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

