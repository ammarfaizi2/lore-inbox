Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263776AbTKRSfN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 13:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263777AbTKRSfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 13:35:13 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:52109 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263776AbTKRSfE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 13:35:04 -0500
Subject: Re: Terrible interactivity with 2.6.0-t9-mm3
From: john stultz <johnstul@us.ibm.com>
To: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
Cc: Thomas Schlichter <schlicht@uni-mannheim.de>,
       "Ronny V. Vindenes" <s864@ii.uib.no>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, cat@zip.com.au,
       gawain@freda.homelinux.org, gene.heskett@verizon.net,
       papadako@csd.uoc.gr
In-Reply-To: <3FBA44CD.8060605@gmx.de>
References: <1069071092.3238.5.camel@localhost.localdomain>
	 <3FB8C92E.7030201@gmx.de>  <200311172046.17736.schlicht@uni-mannheim.de>
	 <1069104441.11424.1979.camel@cog.beaverton.ibm.com> <3FB950EE.10806@gmx.de>
	 <1069109719.11424.1994.camel@cog.beaverton.ibm.com>
	 <1069110272.11438.2000.camel@cog.beaverton.ibm.com>
	 <3FBA1D78.8060502@gmx.de>  <3FBA44CD.8060605@gmx.de>
Content-Type: text/plain
Organization: 
Message-Id: <1069180130.11436.2071.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 18 Nov 2003 10:28:50 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-11-18 at 08:11, Prakash K. Cheemplavam wrote:
> Prakash K. Cheemplavam wrote:
> >>
> >> After sending out multiple patches I should have been more clear. Just
> >> to avoid confusion:
> >>
> >> * the init_cpu_khz patch goes along side Thomas' patch.
> >> * the more experimental sched_clock() -> monotonic_clock() patch I just
> >> sent out for testing replaces Thomas' patch.
> > 
> > 
> > 
> > I now tried the second one and it seems to work, tough I am not sure 
> > whether the performance is as good as APCI timer deavt. It seems that 
> > now CPU Hz is not shown anymore. Have a look at my dmesg:

The init_cpu_khz patch is the one that displays the calibrated CPU
frequency. The two patches listed above address independent bugs. 

> So I deactivated the PM timer again and my computer is much faster 
> again. Haven prime in the background taking 100% doesn't noticeable 
> affect deskop performance. But I think I know where the problem lies:

Yes, Thomas pointed out that the sched_clock->monotonic_clock patch
didn't seem to work for pmtmr. I'm looking into if the pmtmr's
montonic_clock call is doing the right thing (didn't have my laptop
yesterday). 

For now Thomas' patch to switch on "use_tsc" is the best fix when using
the pmtmr. 

> current: c0499a60
> current->thread_info: c0528000
> Initializing CPU#0
> PID hash table entries: 4096 (order 12: 32768 bytes)
> Detected 2004.698 MHz processor.
> Using tsc for high-res timesource
> 
> 
> In above dmesg you can see that nothing was used as timesource, but here 
> in current dmesg tsc is used. Is this normal or a bug? Need I pass a 
> kernel paramtere when pm timer is enbaled?

No, its just cosmetic. Both Thomas and I have sent out a patch that
initializes the name field in the pmtmr's timer_opts struct. 

See: http://www.ussg.iu.edu/hypermail/linux/kernel/0311.1/0983.html

I appreciate the testing and feedback!

thanks,
-john


