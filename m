Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273065AbRJaVlp>; Wed, 31 Oct 2001 16:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273213AbRJaVlf>; Wed, 31 Oct 2001 16:41:35 -0500
Received: from [63.231.122.81] ([63.231.122.81]:34161 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S273065AbRJaVl2>;
	Wed, 31 Oct 2001 16:41:28 -0500
Date: Wed, 31 Oct 2001 14:39:02 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: Gerhard Mack <gmack@innerfire.net>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        vda <vda@port.imtp.ilyichevsk.odessa.ua>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Re: Nasty suprise with uptime
Message-ID: <20011031143902.Q16554@lynx.no>
Mail-Followup-To: Tim Schmielau <tim@physik3.uni-rostock.de>,
	Gerhard Mack <gmack@innerfire.net>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	vda <vda@port.imtp.ilyichevsk.odessa.ua>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011031135215.O16554@lynx.no> <Pine.LNX.4.30.0110312157060.30141-100000@gans.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.30.0110312157060.30141-100000@gans.physik3.uni-rostock.de>; from tim@physik3.uni-rostock.de on Wed, Oct 31, 2001 at 10:05:17PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 31, 2001  22:05 +0100, Tim Schmielau wrote:
> > This means you need to call something that _checks_ the uptime
> > (or needs the 64-bit jiffies value) at least once every 1.3 years.
> > If you don't do it at least that often, you probably don't care
> > about the uptime anyways.
> >
> > This only impacts anything that really needs a 64-bit jiffies count,
> > and has zero impact everywhere else.
> 
> I initially thought of that too. My objection was that boxes with long
> uptimes typically get forgotten in a corner until years later someone
> checks uptime again.
> 
> However, I fully agree with your importance argument and believe this
> proposal to be the best one.

Note that there are several tools that check the uptime, not just the
"uptime" command.  For example "top" and "w" also display the uptime
value (reading /proc/uptime).  But yes, if people don't check on their
boxes in a year, then this method will lose full multiples of 1.3 years
between checks.  Probably not a big deal - we can assume such a system
is an "appliance" at that point, regardless of what kind of real system
it is.  If someone wants to ensure their uptime is correct, they can
always put "[ -r /proc/uptime ] && cat /proc/uptime > /dev/null" in their
cron.monthly directory.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

