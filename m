Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbTKQWr6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 17:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbTKQWr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 17:47:58 -0500
Received: from pop.gmx.de ([213.165.64.20]:56032 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261836AbTKQWr4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 17:47:56 -0500
X-Authenticated: #4512188
Message-ID: <3FB950EE.10806@gmx.de>
Date: Mon, 17 Nov 2003 23:51:26 +0100
From: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031116
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: Thomas Schlichter <schlicht@uni-mannheim.de>,
       "Prakash K. Cheemplavam" <prakashpublic@gmx.de>,
       "Ronny V. Vindenes" <s864@ii.uib.no>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, cat@zip.com.au,
       gawain@freda.homelinux.org, gene.heskett@verizon.net,
       papadako@csd.uoc.gr
Subject: Re: Terrible interactivity with 2.6.0-t9-mm3
References: <1069071092.3238.5.camel@localhost.localdomain>	 <3FB8C92E.7030201@gmx.de>  <200311172046.17736.schlicht@uni-mannheim.de> <1069104441.11424.1979.camel@cog.beaverton.ibm.com>
In-Reply-To: <1069104441.11424.1979.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> On Mon, 2003-11-17 at 11:46, Thomas Schlichter wrote:
> 
>>On Monday 17 November 2003 14:12, Prakash K. Cheemplavam wrote:
>>
>>>Ronny V. Vindenes wrote:
>>>
>>>>I've found that neither linus.patch nor
>>>>context-switch-accounting-fix.patch is causing the problem, but rather
>>>>acpi-pm-timer-fixes.patch & acpi-pm-timer.patch
>>>>
>>>>With these applied my cpu (athlon64) is detected as 0.0Mhz, bogomips
>>>>drops to 50% and anything cpu intensive destroys interactivity. Revert
>>>>them and performance is back at -mm2 level.
>>>
>>>Yup, works for me too. Reverting those patches and my machine is smooth
>>>again. :)
> 
> 
> Not configuring the ACPI PM time source in should also work as well. 


> You're correct, I forgot to initialize cpu_khz in the ACPI PM timesource
> init code. This patch fixes that. 

Well I applied your patch without the ones from Thomas Schlichter. Was 
is intended like that or should it be on top of Thomas patches?

I haven't tested thouroughly, but on the first impression your patch 
didn't make things really better, that's why I stoped testing. I just 
did following test:

Running prime95 as task taking 100% CPU) and started up mozilla and 
mailer. This took nearly endlessly. Deaktivating ACPI timer and things 
are fast again, ie. starting mozilla is like no background task is 
runnig. I dunno if it is a not 100% working patch or if it is Nick's 
scheduler, which I am using.

Prakash

